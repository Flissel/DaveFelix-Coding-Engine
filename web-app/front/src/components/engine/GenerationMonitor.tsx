// front/src/components/engine/GenerationMonitor.tsx
import { useState, useRef, useEffect } from 'react';
import { useGenerationStatus } from '@/hooks/useEngine';
import { ProgressHeader } from './ProgressHeader';
import { AgentList } from './AgentList';
import { EpicSidebar } from './EpicSidebar';
import { TaskBoard } from './TaskBoard';
import { ReviewChat } from './ReviewChat';
import { ClarificationPanel } from './ClarificationPanel';
import { useEngineStore } from '@/stores/engineStore';

function LogViewer() {
  const logs = useEngineStore(state => state.logs);
  const containerRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (containerRef.current) {
      containerRef.current.scrollTop = containerRef.current.scrollHeight;
    }
  }, [logs.length]);

  return (
    <div ref={containerRef} className="h-full overflow-y-auto font-mono text-xs p-4 bg-black/30 rounded-lg">
      {logs.length === 0 ? (
        <div className="text-white/30">No logs yet. Start generation to see output.</div>
      ) : (
        logs.map((log, i) => (
          <div key={i} className="text-white/70 py-0.5 border-b border-white/5">{log}</div>
        ))
      )}
    </div>
  );
}

interface GenerationMonitorProps {
  projectName: string;
}

const SUB_TABS = ['Agents', 'Epics', 'Tasks', 'Dependencies', 'Logs', 'Validation', 'Traceability'] as const;

export function GenerationMonitor({ projectName }: GenerationMonitorProps) {
  const { data: status } = useGenerationStatus(projectName);
  const [activeTab, setActiveTab] = useState<string>('Agents');
  const reviewPaused = useEngineStore(state => state.reviewPaused);

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
          </button>
        ))}
      </div>
      <div className="flex flex-1 overflow-hidden">
        {activeTab === 'Agents' && <AgentList agents={status.agents} />}
        {activeTab === 'Tasks' && <TaskBoard projectPath={projectName} />}
        {activeTab === 'Validation' && <ClarificationPanel />}
        {activeTab === 'Logs' && <LogViewer />}
        {activeTab !== 'Agents' && activeTab !== 'Tasks' && activeTab !== 'Validation' && activeTab !== 'Logs' && (
          <div className="flex-1 flex items-center justify-center text-muted-foreground text-sm">
            {activeTab} view coming soon
          </div>
        )}
        <EpicSidebar epics={status.epics} />
      </div>
    </div>
  );
}
