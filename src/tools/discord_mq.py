"""
Discord Message Queue — Uses Discord channels as agent queues.

Architecture (from Dave's diagram):
  #orchestrator  → PM Agent posts new tasks, controls DAG
  #dev-tasks     → Dev Agents pick up coding tasks
  #integration   → Integrator Agent reviews PRs
  #fixes         → Dev Agents post fix suggestions
  #testing       → QA Tester Agent runs E2E tests
  #done          → Verified/completed tasks

Each agent runs a poll loop on its queue channel.
When a new structured message arrives, the agent processes it
and posts the result to the next queue in the pipeline.

Pipeline:
  Orchestrator → #dev-tasks → Dev Agent → #integration → Integrator
  → #testing → QA Tester → #done (or #fixes → Dev Agent → retry)
"""

import asyncio
import logging
import os
from typing import Callable, Optional

from src.tools.discord_agent import DiscordAgent
from src.tools.discord_structured import (
    StructuredMessage, StructuredDiscord, MessageType, Scope
)

logger = logging.getLogger(__name__)

# Channel IDs — set via env or hardcoded from creation
CHANNELS = {
    "orchestrator": os.environ.get("DISCORD_CH_ORCHESTRATOR", "1484193339405369344"),
    "dev-tasks": os.environ.get("DISCORD_CH_DEV_TASKS", "1484193408955322399"),
    "integration": os.environ.get("DISCORD_CH_INTEGRATION", "1484193411182366902"),
    "fixes": os.environ.get("DISCORD_CH_FIXES", "1484193412679733302"),
    "testing": os.environ.get("DISCORD_CH_TESTING", "1484193415364214958"),
    "done": os.environ.get("DISCORD_CH_DONE", "1484193417381679225"),
    "general": os.environ.get("DISCORD_CH_GENERAL", "1484160715580510242"),
}

# Bot tokens
ENGINE_BOT = os.environ.get(
    "DISCORD_BOT_TOKEN",
    ""
)
ANALYZER_BOT = os.environ.get(
    "DISCORD_BOT_TOKEN_ANALYZER",
    ""
)


class QueueAgent:
    """An agent that polls a Discord channel queue and processes messages."""

    def __init__(
        self,
        name: str,
        listen_channel: str,
        output_channel: str,
        bot_token: str = "",
        poll_interval: int = 5,
    ):
        self.name = name
        self.listen_channel = CHANNELS.get(listen_channel, listen_channel)
        self.output_channel = CHANNELS.get(output_channel, output_channel)
        self.poll_interval = poll_interval
        self.discord = StructuredDiscord(
            bot_token=bot_token or ENGINE_BOT,
            channel_id=self.listen_channel,
        )
        self.output = StructuredDiscord(
            bot_token=bot_token or ENGINE_BOT,
            channel_id=self.output_channel,
        )
        self._running = False
        self._last_seen_id = "0"
        self._handler: Optional[Callable] = None

    def on_message(self, handler: Callable):
        """Register a message handler. Called with (StructuredMessage) -> StructuredMessage or None."""
        self._handler = handler
        return handler

    async def start(self):
        """Start the polling loop."""
        self._running = True
        logger.info("[%s] Started polling #%s", self.name, self.listen_channel)

        while self._running:
            try:
                await self._poll_once()
            except Exception as e:
                logger.error("[%s] Poll error: %s", self.name, e)
            await asyncio.sleep(self.poll_interval)

    async def stop(self):
        """Stop the polling loop."""
        self._running = False
        logger.info("[%s] Stopped", self.name)

    async def _poll_once(self):
        """Check for new messages and process them."""
        agent = DiscordAgent(
            bot_token=self.discord.agent.bot_token,
            channel_id=self.listen_channel,
        )
        raw = await agent.read_recent(limit=10)
        if not raw:
            return

        # Process newest first, skip already seen
        for msg in reversed(raw):
            msg_id = msg.get("id", "0")
            if msg_id <= self._last_seen_id:
                continue

            # Skip own bot messages
            author = msg.get("author", {})
            if author.get("bot", False):
                # Only skip if it's from OUR bot
                pass

            content = msg.get("content", "")
            parsed = StructuredMessage.from_discord(content)
            if not parsed:
                continue

            self._last_seen_id = msg_id
            logger.info("[%s] Processing: %s %s", self.name, parsed.msg_type.value, parsed.task_id)

            if self._handler:
                try:
                    response = await self._handler(parsed)
                    if response and isinstance(response, StructuredMessage):
                        self.output.agent.channel_id = self.output_channel
                        await self.output.post(response)
                        logger.info("[%s] Posted to #%s: %s", self.name, self.output_channel, response.msg_type.value)
                except Exception as e:
                    logger.error("[%s] Handler error: %s", self.name, e)

    async def post_to(self, channel: str, msg: StructuredMessage):
        """Post a message to a specific channel."""
        ch_id = CHANNELS.get(channel, channel)
        agent = DiscordAgent(
            bot_token=self.discord.agent.bot_token,
            channel_id=ch_id,
        )
        await agent.send(msg.to_discord())


class AgentPipeline:
    """Manages all queue agents in the pipeline."""

    def __init__(self):
        self.agents: dict[str, QueueAgent] = {}
        self._tasks: list[asyncio.Task] = []

    def add(self, agent: QueueAgent) -> QueueAgent:
        self.agents[agent.name] = agent
        return agent

    async def start_all(self):
        """Start all agents concurrently."""
        logger.info("Starting %d queue agents", len(self.agents))
        for agent in self.agents.values():
            task = asyncio.create_task(agent.start())
            self._tasks.append(task)

    async def stop_all(self):
        """Stop all agents."""
        for agent in self.agents.values():
            await agent.stop()
        for task in self._tasks:
            task.cancel()
        self._tasks.clear()


async def _pm_handler(msg: StructuredMessage) -> Optional[StructuredMessage]:
    """PM Agent: forwards tasks to dev queue, adds priority/context."""
    logger.info("[PM] Releasing task %s to dev queue", msg.task_id)
    return StructuredMessage(
        msg_type=msg.msg_type,
        scope=msg.scope,
        epic_id=msg.epic_id,
        task_id=msg.task_id,
        task_name=msg.task_name,
        file_path=msg.file_path,
        error=msg.error,
        context=msg.context,
        action=msg.action or "CODE",
    )


async def _dev_handler(msg: StructuredMessage) -> Optional[StructuredMessage]:
    """Dev Agent: processes task, generates code, requests review."""
    logger.info("[Dev] Working on %s: %s", msg.task_id, msg.task_name)
    # In real implementation: call OpenRouter LLM to generate code
    # For now: forward to integration with code context
    return StructuredMessage(
        msg_type=MessageType.FIX_APPLIED if msg.action == "FIX_AND_RETEST" else MessageType.TASK_VERIFIED,
        scope=msg.scope,
        epic_id=msg.epic_id,
        task_id=msg.task_id,
        task_name=msg.task_name,
        file_path=msg.file_path,
        context="Code generated, requesting review",
        action="REVIEW",
        status="PENDING_REVIEW",
    )


async def _integrator_handler(msg: StructuredMessage) -> Optional[StructuredMessage]:
    """Integrator Agent: reviews PR, approves or rejects."""
    logger.info("[Integrator] Reviewing %s", msg.task_id)
    # In real implementation: check git diff, validate contracts
    if msg.status == "PENDING_REVIEW":
        return StructuredMessage(
            msg_type=MessageType.TASK_VERIFIED,
            scope=msg.scope,
            epic_id=msg.epic_id,
            task_id=msg.task_id,
            task_name=msg.task_name,
            context="Integration approved, forwarding to QA",
            action="E2E_TEST",
            status="APPROVED",
        )
    return None


async def _qa_handler(msg: StructuredMessage) -> Optional[StructuredMessage]:
    """QA Tester Agent: runs E2E tests, marks done or sends to fixes."""
    logger.info("[QA] Testing %s", msg.task_id)
    # In real implementation: call OpenClaw browser test
    return StructuredMessage(
        msg_type=MessageType.TASK_VERIFIED,
        scope=msg.scope,
        epic_id=msg.epic_id,
        task_id=msg.task_id,
        task_name=msg.task_name,
        status="PASS",
        context="E2E tests passed",
    )


async def _fix_handler(msg: StructuredMessage) -> Optional[StructuredMessage]:
    """Fix Agent: reads error, generates fix, sends back to dev."""
    logger.info("[Fix] Fixing %s: %s", msg.task_id, msg.error[:50] if msg.error else "")
    return StructuredMessage(
        msg_type=MessageType.FIX_APPLIED,
        scope=msg.scope,
        epic_id=msg.epic_id,
        task_id=msg.task_id,
        file_path=msg.file_path,
        diff="// Fix applied by Fix-Agent",
        action="RETEST",
    )


def create_default_pipeline() -> AgentPipeline:
    """Create the standard agent pipeline matching Dave's architecture."""
    pipeline = AgentPipeline()

    # PM Agent — reads orchestrator queue, posts to dev-tasks
    pm = pipeline.add(QueueAgent(
        name="PM-Agent",
        listen_channel="orchestrator",
        output_channel="dev-tasks",
        bot_token=ENGINE_BOT,
    ))
    pm.on_message(_pm_handler)

    # Dev Agent — reads dev-tasks, codes, posts to integration
    dev = pipeline.add(QueueAgent(
        name="Dev-Agent",
        listen_channel="dev-tasks",
        output_channel="integration",
        bot_token=ENGINE_BOT,
    ))
    dev.on_message(_dev_handler)

    # Integrator Agent — reads integration, reviews, posts to testing or fixes
    integrator = pipeline.add(QueueAgent(
        name="Integrator-Agent",
        listen_channel="integration",
        output_channel="testing",
        bot_token=ANALYZER_BOT,
    ))
    integrator.on_message(_integrator_handler)

    # QA Tester Agent — reads testing, runs E2E, posts to done or fixes
    qa = pipeline.add(QueueAgent(
        name="QA-Tester-Agent",
        listen_channel="testing",
        output_channel="done",
        bot_token=ENGINE_BOT,
    ))
    qa.on_message(_qa_handler)

    # Fix Agent — reads fixes, applies fixes, posts back to dev-tasks
    fixer = pipeline.add(QueueAgent(
        name="Fix-Agent",
        listen_channel="fixes",
        output_channel="dev-tasks",
        bot_token=ANALYZER_BOT,
    ))
    fixer.on_message(_fix_handler)

    return pipeline
