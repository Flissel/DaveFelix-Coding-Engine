"""
Fix Voter - Use voting to select best fix among multiple proposals.

This module implements democratic voting for fix selection using VotingAI.
When multiple fix approaches are proposed, voters evaluate each option
from different perspectives and vote on the best one.

Voters:
- CodeQualitySolver: Is the fix clean and maintainable?
- StabilitySolver: Will the fix introduce new bugs?
- MinimalChangeSolver: Does it change only what's needed?

Usage:
    voter = FixVoter(working_dir="./project")
    best_fix = await voter.select_fix(
        error=error_context,
        proposed_fixes=[fix1, fix2, fix3],
    )
"""

import asyncio
from dataclasses import dataclass, field
from typing import Optional, Any
from enum import Enum
import structlog

logger = structlog.get_logger()


class VotingMethod(Enum):
    """Voting methods supported."""
    MAJORITY = "majority"
    RANKED_CHOICE = "ranked_choice"
    QUALIFIED_MAJORITY = "qualified_majority"
    UNANIMOUS = "unanimous"


@dataclass
class ProposedFix:
    """A proposed fix for an error."""
    id: str
    description: str
    code_changes: list[dict] = field(default_factory=list)
    files_modified: list[str] = field(default_factory=list)
    complexity: str = "low"  # low, medium, high
    reasoning: str = ""
    source: str = "llm"  # llm, pattern, manual

    def to_option(self) -> dict:
        """Convert to voting option format."""
        return {
            "id": self.id,
            "label": self.description[:100],
            "details": self.reasoning,
            "complexity": self.complexity,
            "files": self.files_modified,
        }


@dataclass
class ErrorContext:
    """Context about the error being fixed."""
    error_type: str
    error_message: str
    file_path: Optional[str] = None
    line_number: Optional[int] = None
    related_files: list[str] = field(default_factory=list)
    stack_trace: Optional[str] = None

    def to_context(self) -> str:
        """Convert to prompt context."""
        return f"""
Error Type: {self.error_type}
Message: {self.error_message}
Location: {self.file_path}:{self.line_number if self.line_number else 'unknown'}
Related Files: {', '.join(self.related_files) or 'none'}
"""


@dataclass
class VoteResult:
    """Result of a single vote."""
    voter_id: str
    perspective: str
    selected_option: str
    confidence: float  # 0.0 - 1.0
    reasoning: str
    rankings: list[str] = field(default_factory=list)  # For ranked choice


@dataclass
class VotingResult:
    """Final voting result."""
    winning_option_id: str
    winning_fix: Optional[ProposedFix]
    confidence_score: float
    consensus_reached: bool
    votes: list[VoteResult] = field(default_factory=list)
    deliberation_summary: str = ""


class BaseSolver:
    """Base class for voting solvers."""

    def __init__(
        self,
        solver_id: str,
        perspective: str,
        working_dir: str,
    ):
        self.solver_id = solver_id
        self.perspective = perspective
        self.working_dir = working_dir
        self.logger = logger.bind(solver=solver_id)

    async def vote(
        self,
        context: ErrorContext,
        options: list[ProposedFix],
    ) -> VoteResult:
        """Vote on the best fix option."""
        raise NotImplementedError

    async def rank(
        self,
        context: ErrorContext,
        options: list[ProposedFix],
    ) -> VoteResult:
        """Rank all fix options (for ranked choice voting)."""
        raise NotImplementedError


class CodeQualitySolver(BaseSolver):
    """Evaluates fixes based on code quality and maintainability."""

    def __init__(self, working_dir: str):
        super().__init__(
            solver_id="code_quality",
            perspective="Code Quality & Maintainability",
            working_dir=working_dir,
        )

    async def vote(
        self,
        context: ErrorContext,
        options: list[ProposedFix],
    ) -> VoteResult:
        """Vote based on code quality criteria."""
        # Scoring criteria:
        # - Clean, readable code
        # - Follows existing patterns
        # - No unnecessary complexity
        # - Good variable/function names

        scores = {}
        for fix in options:
            score = 0.5  # Base score

            # Lower complexity = better
            if fix.complexity == "low":
                score += 0.3
            elif fix.complexity == "medium":
                score += 0.1

            # Fewer files = likely cleaner
            if len(fix.files_modified) <= 2:
                score += 0.2
            elif len(fix.files_modified) <= 5:
                score += 0.1

            scores[fix.id] = min(1.0, score)

        # Select highest scoring
        best_id = max(scores, key=scores.get)
        best_fix = next(f for f in options if f.id == best_id)

        return VoteResult(
            voter_id=self.solver_id,
            perspective=self.perspective,
            selected_option=best_id,
            confidence=scores[best_id],
            reasoning=f"Selected '{best_fix.description[:50]}' for best code quality (complexity: {best_fix.complexity})",
            rankings=sorted(scores, key=scores.get, reverse=True),
        )

    async def rank(
        self,
        context: ErrorContext,
        options: list[ProposedFix],
    ) -> VoteResult:
        """Rank options by code quality."""
        vote_result = await self.vote(context, options)
        return vote_result


class StabilitySolver(BaseSolver):
    """Evaluates fixes based on stability and risk of introducing new bugs."""

    def __init__(self, working_dir: str):
        super().__init__(
            solver_id="stability",
            perspective="Stability & Bug Risk",
            working_dir=working_dir,
        )

    async def vote(
        self,
        context: ErrorContext,
        options: list[ProposedFix],
    ) -> VoteResult:
        """Vote based on stability criteria."""
        # Scoring criteria:
        # - Minimal side effects
        # - Well-tested approach
        # - Doesn't break other features
        # - Safe null/error handling

        scores = {}
        for fix in options:
            score = 0.5  # Base score

            # Prefer fixes that touch fewer files
            if len(fix.files_modified) == 1:
                score += 0.3
            elif len(fix.files_modified) <= 3:
                score += 0.15

            # Pattern-based fixes are more stable
            if fix.source == "pattern":
                score += 0.2

            # Lower complexity = lower risk
            if fix.complexity == "low":
                score += 0.15

            scores[fix.id] = min(1.0, score)

        best_id = max(scores, key=scores.get)
        best_fix = next(f for f in options if f.id == best_id)

        return VoteResult(
            voter_id=self.solver_id,
            perspective=self.perspective,
            selected_option=best_id,
            confidence=scores[best_id],
            reasoning=f"Selected '{best_fix.description[:50]}' for lowest bug risk ({len(best_fix.files_modified)} files)",
            rankings=sorted(scores, key=scores.get, reverse=True),
        )

    async def rank(
        self,
        context: ErrorContext,
        options: list[ProposedFix],
    ) -> VoteResult:
        """Rank options by stability."""
        return await self.vote(context, options)


class MinimalChangeSolver(BaseSolver):
    """Evaluates fixes based on minimizing changes."""

    def __init__(self, working_dir: str):
        super().__init__(
            solver_id="minimal_change",
            perspective="Minimal Change Principle",
            working_dir=working_dir,
        )

    async def vote(
        self,
        context: ErrorContext,
        options: list[ProposedFix],
    ) -> VoteResult:
        """Vote based on minimal change criteria."""
        # Scoring criteria:
        # - Fewest files modified
        # - Smallest code delta
        # - Most targeted fix

        scores = {}
        for fix in options:
            score = 0.3  # Base score

            # Fewer files = better
            if len(fix.files_modified) == 1:
                score += 0.5
            elif len(fix.files_modified) == 2:
                score += 0.3
            elif len(fix.files_modified) <= 3:
                score += 0.15

            # Lower complexity = smaller change
            if fix.complexity == "low":
                score += 0.2
            elif fix.complexity == "medium":
                score += 0.1

            scores[fix.id] = min(1.0, score)

        best_id = max(scores, key=scores.get)
        best_fix = next(f for f in options if f.id == best_id)

        return VoteResult(
            voter_id=self.solver_id,
            perspective=self.perspective,
            selected_option=best_id,
            confidence=scores[best_id],
            reasoning=f"Selected '{best_fix.description[:50]}' for minimal footprint ({len(best_fix.files_modified)} files, {best_fix.complexity} complexity)",
            rankings=sorted(scores, key=scores.get, reverse=True),
        )

    async def rank(
        self,
        context: ErrorContext,
        options: list[ProposedFix],
    ) -> VoteResult:
        """Rank options by minimal change."""
        return await self.vote(context, options)


class FixVoter:
    """
    Use voting to select best fix among multiple proposals.

    Implements democratic voting with multiple solver perspectives:
    - CodeQualitySolver: Code cleanliness and maintainability
    - StabilitySolver: Risk of introducing new bugs
    - MinimalChangeSolver: Smallest necessary change

    Voting Methods:
    - MAJORITY: Simple majority wins
    - RANKED_CHOICE: Ranked preferences with elimination
    - QUALIFIED_MAJORITY: Requires 2/3 agreement
    """

    def __init__(
        self,
        working_dir: str,
        voting_method: VotingMethod = VotingMethod.RANKED_CHOICE,
        qualified_threshold: float = 0.67,
    ):
        self.working_dir = working_dir
        self.voting_method = voting_method
        self.qualified_threshold = qualified_threshold
        self.logger = logger.bind(component="fix_voter")

        # Initialize solvers
        self.solvers = [
            CodeQualitySolver(working_dir),
            StabilitySolver(working_dir),
            MinimalChangeSolver(working_dir),
        ]

    async def select_fix(
        self,
        error: ErrorContext,
        proposed_fixes: list[ProposedFix],
        voting_method: Optional[VotingMethod] = None,
    ) -> VotingResult:
        """
        Vote among proposed fixes and return the winner.

        Args:
            error: Context about the error being fixed
            proposed_fixes: List of proposed fixes to vote on
            voting_method: Optional override for voting method

        Returns:
            VotingResult with winning fix and voting details
        """
        if len(proposed_fixes) == 0:
            return VotingResult(
                winning_option_id="",
                winning_fix=None,
                confidence_score=0.0,
                consensus_reached=False,
                deliberation_summary="No fixes proposed",
            )

        if len(proposed_fixes) == 1:
            # Only one option, no voting needed
            fix = proposed_fixes[0]
            return VotingResult(
                winning_option_id=fix.id,
                winning_fix=fix,
                confidence_score=1.0,
                consensus_reached=True,
                deliberation_summary="Single fix proposed, no voting needed",
            )

        method = voting_method or self.voting_method
        self.logger.info(
            "fix_voting_started",
            num_fixes=len(proposed_fixes),
            method=method.value,
            error_type=error.error_type,
        )

        # Collect votes from all solvers
        vote_tasks = [
            solver.vote(error, proposed_fixes)
            for solver in self.solvers
        ]
        votes = await asyncio.gather(*vote_tasks)

        # Apply voting method
        if method == VotingMethod.MAJORITY:
            result = self._apply_majority_voting(proposed_fixes, votes)
        elif method == VotingMethod.RANKED_CHOICE:
            result = self._apply_ranked_choice(proposed_fixes, votes)
        elif method == VotingMethod.QUALIFIED_MAJORITY:
            result = self._apply_qualified_majority(proposed_fixes, votes)
        else:
            result = self._apply_majority_voting(proposed_fixes, votes)

        result.votes = list(votes)

        self.logger.info(
            "fix_voting_complete",
            winner=result.winning_option_id,
            confidence=result.confidence_score,
            consensus=result.consensus_reached,
        )

        return result

    def _apply_majority_voting(
        self,
        fixes: list[ProposedFix],
        votes: list[VoteResult],
    ) -> VotingResult:
        """Simple majority voting."""
        vote_counts = {}
        confidence_sums = {}

        for vote in votes:
            option = vote.selected_option
            vote_counts[option] = vote_counts.get(option, 0) + 1
            confidence_sums[option] = confidence_sums.get(option, 0) + vote.confidence

        # Find winner
        winner_id = max(vote_counts, key=vote_counts.get)
        winner_votes = vote_counts[winner_id]
        total_votes = len(votes)

        # Calculate confidence
        avg_confidence = confidence_sums[winner_id] / winner_votes

        # Check consensus
        consensus = winner_votes > total_votes / 2

        winning_fix = next((f for f in fixes if f.id == winner_id), None)

        return VotingResult(
            winning_option_id=winner_id,
            winning_fix=winning_fix,
            confidence_score=avg_confidence,
            consensus_reached=consensus,
            deliberation_summary=f"Majority vote: {winner_id} won with {winner_votes}/{total_votes} votes",
        )

    def _apply_ranked_choice(
        self,
        fixes: list[ProposedFix],
        votes: list[VoteResult],
    ) -> VotingResult:
        """Ranked choice voting with elimination."""
        # For ranked choice, we use the rankings from each vote
        # If no rankings, fall back to selected_option as rank 1

        candidates = {f.id for f in fixes}
        rounds = []

        while len(candidates) > 1:
            # Count first-place votes
            first_place_counts = {c: 0 for c in candidates}

            for vote in votes:
                if vote.rankings:
                    for rank in vote.rankings:
                        if rank in candidates:
                            first_place_counts[rank] += 1
                            break
                elif vote.selected_option in candidates:
                    first_place_counts[vote.selected_option] += 1

            # Check for majority
            total_votes = sum(first_place_counts.values())
            for candidate, count in first_place_counts.items():
                if count > total_votes / 2:
                    # Winner found
                    winning_fix = next((f for f in fixes if f.id == candidate), None)
                    avg_confidence = sum(v.confidence for v in votes) / len(votes)

                    return VotingResult(
                        winning_option_id=candidate,
                        winning_fix=winning_fix,
                        confidence_score=avg_confidence,
                        consensus_reached=True,
                        deliberation_summary=f"Ranked choice: {candidate} won in round {len(rounds) + 1}",
                    )

            # Eliminate last place
            min_votes = min(first_place_counts.values())
            to_eliminate = [c for c, v in first_place_counts.items() if v == min_votes]
            candidates -= set(to_eliminate)
            rounds.append(first_place_counts)

        # One candidate left
        winner_id = list(candidates)[0] if candidates else fixes[0].id
        winning_fix = next((f for f in fixes if f.id == winner_id), None)
        avg_confidence = sum(v.confidence for v in votes) / len(votes)

        return VotingResult(
            winning_option_id=winner_id,
            winning_fix=winning_fix,
            confidence_score=avg_confidence,
            consensus_reached=True,
            deliberation_summary=f"Ranked choice: {winner_id} won after {len(rounds)} elimination rounds",
        )

    def _apply_qualified_majority(
        self,
        fixes: list[ProposedFix],
        votes: list[VoteResult],
    ) -> VotingResult:
        """Qualified majority voting (requires threshold agreement)."""
        vote_counts = {}
        confidence_sums = {}

        for vote in votes:
            option = vote.selected_option
            vote_counts[option] = vote_counts.get(option, 0) + 1
            confidence_sums[option] = confidence_sums.get(option, 0) + vote.confidence

        # Find winner
        winner_id = max(vote_counts, key=vote_counts.get)
        winner_votes = vote_counts[winner_id]
        total_votes = len(votes)

        # Check if qualified threshold is met
        vote_ratio = winner_votes / total_votes
        consensus = vote_ratio >= self.qualified_threshold

        # Calculate confidence
        avg_confidence = confidence_sums[winner_id] / winner_votes

        winning_fix = next((f for f in fixes if f.id == winner_id), None)

        return VotingResult(
            winning_option_id=winner_id,
            winning_fix=winning_fix,
            confidence_score=avg_confidence if consensus else avg_confidence * 0.5,
            consensus_reached=consensus,
            deliberation_summary=f"Qualified majority: {winner_id} got {vote_ratio:.0%} (threshold: {self.qualified_threshold:.0%})",
        )

    async def vote_with_deliberation(
        self,
        error: ErrorContext,
        proposed_fixes: list[ProposedFix],
        max_rounds: int = 2,
    ) -> VotingResult:
        """
        Vote with deliberation rounds for complex decisions.

        Solvers can refine their votes after seeing peer opinions.

        Args:
            error: Error context
            proposed_fixes: Fixes to vote on
            max_rounds: Maximum deliberation rounds

        Returns:
            VotingResult after deliberation
        """
        if len(proposed_fixes) <= 1:
            return await self.select_fix(error, proposed_fixes)

        # Initial vote
        result = await self.select_fix(error, proposed_fixes)

        # If consensus reached, no deliberation needed
        if result.consensus_reached:
            return result

        # Deliberation rounds (simplified - in full implementation,
        # solvers would re-vote with knowledge of peer votes)
        for round_num in range(max_rounds):
            self.logger.info(
                "fix_deliberation_round",
                round=round_num + 1,
                current_winner=result.winning_option_id,
            )

            # Re-vote
            result = await self.select_fix(error, proposed_fixes)

            if result.consensus_reached:
                result.deliberation_summary = f"Consensus reached after {round_num + 1} deliberation rounds"
                break

        return result
