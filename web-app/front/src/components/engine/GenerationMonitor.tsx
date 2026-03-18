// front/src/components/engine/GenerationMonitor.tsx
import { useState, useRef, useEffect } from 'react';
import { useGenerationStatus } from '@/hooks/useEngine';
import { ProgressHeader } from './ProgressHeader';
import { AgentList } from './AgentList';
import { EpicSidebar } from './EpicSidebar';
import { TaskBoard } from './TaskBoard';
import { ReviewChat } from './ReviewChat';
import { ClarificationPanel } from './ClarificationPanel';
import { SettingsPanel } from './SettingsPanel';
import { useEngineStore } from '@/stores/engineStore';
import { API_URL } from '@/services/api';
import type { EpicInfo } from '@/services/engineApi';

function LogViewer({ projectName }: { projectName: string }) {
  const wsLogs = useEngineStore(state => state.logs);
  const [polledLogs, setPolledLogs] = useState<string[]>([]);
  const containerRef = useRef<HTMLDivElement>(null);

  // Poll backend events as log lines
  useEffect(() => {
    let active = true;
    const poll = async () => {
      try {
        const res = await fetch(`${API_URL}/dashboard/project/status?projectId=${encodeURIComponent(projectName)}`);
        if (res.ok) {
          const data = await res.json();
          const lines: string[] = [];
          if (data.phase) lines.push(`[Phase] ${data.phase}`);
          if (data.completed !== undefined) lines.push(`[Progress] ${data.completed}/${data.total} tasks completed (${data.progress_pct}%)`);
          if (data.failed > 0) lines.push(`[Warning] ${data.failed} tasks failed`);
          if (data.epics?.length > 0) {
            data.epics.forEach((e: EpicInfo) => {
              lines.push(`[Epic] ${e.id}: ${e.name} — ${e.tasks_complete}/${e.tasks_total} tasks (${e.progress_pct}%)`);
            });
          }
          if (active) setPolledLogs(lines);
        }
      } catch { /* ignore */ }
    };
    poll();
    const interval = setInterval(poll, 5000);
    return () => { active = false; clearInterval(interval); };
  }, [projectName]);

  const displayLogs = wsLogs.length > 0 ? wsLogs : polledLogs;

  useEffect(() => {
    if (containerRef.current) {
      containerRef.current.scrollTop = containerRef.current.scrollHeight;
    }
  }, [displayLogs.length]);

  return (
    <div ref={containerRef} className="h-full overflow-y-auto font-mono text-xs p-4 bg-black/30 rounded-lg">
      {displayLogs.length === 0 ? (
        <div className="text-white/30">No logs yet. Start generation to see output.</div>
      ) : (
        displayLogs.map((log, i) => (
          <div key={i} className="text-white/70 py-0.5 border-b border-white/5">{log}</div>
        ))
      )}
    </div>
  );
}

function EpicList({ epics }: { epics: EpicInfo[] }) {
  return (
    <div className="flex-1 overflow-y-auto p-4">
      <h3 className="text-sm font-semibold text-white/70 mb-4">Epics ({epics.length})</h3>
      {epics.length === 0 ? (
        <div className="text-white/30 text-sm">No epics loaded yet. Start generation to see epics.</div>
      ) : (
        <div className="space-y-3">
          {epics.map(epic => (
            <div key={epic.id} className="p-4 bg-white/5 rounded-lg border border-white/10">
              <div className="flex justify-between items-center mb-2">
                <div className="font-medium text-white text-sm">{epic.id}</div>
                <span className="text-xs text-green-400 font-semibold">{epic.progress_pct}%</span>
              </div>
              <p className="text-xs text-white/60 mb-3">{epic.name}</p>
              <div className="flex items-center gap-2 mb-1">
                <div className="flex-1 h-1.5 bg-white/10 rounded-full overflow-hidden">
                  <div
                    className="h-full bg-gradient-to-r from-indigo-500 to-green-500 rounded-full transition-all"
                    style={{ width: `${epic.progress_pct}%` }}
                  />
                </div>
              </div>
              <div className="text-[10px] text-white/40">
                {epic.tasks_complete}/{epic.tasks_total} tasks
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

interface GenerationMonitorProps {
  projectName: string;
  parallelism: number;
  onParallelismChange: (v: number) => void;
}

const SUB_TABS = ['Agents', 'Epics', 'Tasks', 'Logs', 'Validation', 'Settings'] as const;

export function GenerationMonitor({ projectName, parallelism, onParallelismChange }: GenerationMonitorProps) {
  const { data: status } = useGenerationStatus(projectName);
  const [activeTab, setActiveTab] = useState<string>('Agents');
  const reviewPaused = useEngineStore(state => state.reviewPaused);

  // Sync epics from status endpoint into zustand store (for TaskBoard)
  useEffect(() => {
    if (status?.epics && status.epics.length > 0) {
      useEngineStore.setState({ epics: status.epics });
    }
  }, [status?.epics]);

  if (!status) return null;

  return (
    <div className="flex flex-col h-full">
      <ProgressHeader
        projectName={projectName}
        phase={status.phase}
        progressPct={status.progress_pct}
        serviceCount={status.service_count}
        endpointCount={status.endpoint_count}
      />
      {reviewPaused && <ReviewChat projectId={projectName} />}
      <div className="flex border-b border-border/30 px-2">
        {SUB_TABS.map((tab) => (
          <button
            key={tab}
            onClick={() => setActiveTab(tab)}
            className={`px-3 py-1.5 text-[11px] border-b-2 transition-colors ${
              activeTab === tab
                ? 'text-primary border-primary'
                : 'text-muted-foreground border-transparent hover:text-foreground'
            }`}
          >
            {tab}
            {tab === 'Agents' && status.agents.length > 0 && (
              <span className="ml-1 text-[9px] bg-primary/10 text-primary px-1.5 rounded">
                {status.agents.length}
              </span>
            )}
            {tab === 'Epics' && status.epics.length > 0 && (
              <span className="ml-1 text-[9px] bg-indigo-500/10 text-indigo-400 px-1.5 rounded">
                {status.epics.length}
              </span>
            )}
          </button>
        ))}
      </div>
      <div className="flex flex-1 overflow-hidden">
        {activeTab === 'Agents' && <AgentList agents={status.agents} />}
        {activeTab === 'Epics' && <EpicList epics={status.epics} />}
        {activeTab === 'Tasks' && <TaskBoard projectPath={projectName} />}
        {activeTab === 'Validation' && <ClarificationPanel />}
        {activeTab === 'Logs' && <LogViewer projectName={projectName} />}
        {activeTab === 'Settings' && (
          <div className="flex-1 overflow-hidden">
            <SettingsPanel
              projectName={projectName}
              parallelism={parallelism}
              onParallelismChange={onParallelismChange}
            />
          </div>
        )}
        <EpicSidebar epics={status.epics} />
      </div>
    </div>
  );
}
