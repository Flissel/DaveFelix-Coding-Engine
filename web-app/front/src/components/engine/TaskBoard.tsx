// web-app/front/src/components/engine/TaskBoard.tsx
import { useState, useEffect } from 'react';
import { getDbProjects, getDbTasks } from '@/services/engineApi';
import { platform } from '@/services/platform';
import { useEngineStore } from '@/stores/engineStore';

interface DbTask {
  id: number;
  task_id: string;
  title: string;
  description: string;
  status: 'pending' | 'running' | 'completed' | 'failed' | 'blocked' | 'cancelled';
  status_message: string | null;
  task_type: string;
  depends_on: string[];
  retry_count: number;
  execution_time_ms: number | null;
  tokens_used: number | null;
  cost_usd: number | null;
  created_at: string | null;
  updated_at: string | null;
}

interface DbProject {
  id: number;
  name: string;
  description: string;
  status: string;
  created_at: string;
  updated_at: string;
}

interface JobInfo {
  id: number;
  status: string;
  tasks_completed: number;
  tasks_failed: number;
  total_tasks: number;
  progress_pct: number;
}

export function TaskBoard({ projectPath }: { projectPath: string }) {
  const epics = useEngineStore(state => state.epics);
  const selectedEpicId = useEngineStore(state => state.selectedEpicId);

  // DB-backed state
  const [dbProjects, setDbProjects] = useState<DbProject[]>([]);
  const [selectedProjectId, setSelectedProjectId] = useState<number | null>(null);
  const [dbTasks, setDbTasks] = useState<DbTask[]>([]);
  const [jobInfo, setJobInfo] = useState<JobInfo | null>(null);
  const [loading, setLoading] = useState(false);
  const [filter, setFilter] = useState<string>('all');
  const [searchQuery, setSearchQuery] = useState('');
  const [fixInput, setFixInput] = useState<Record<string, string>>({});

  // Load projects on mount
  useEffect(() => {
    loadProjects();
  }, []);

  // Auto-refresh tasks every 5s
  useEffect(() => {
    if (!selectedProjectId) return;
    const interval = setInterval(() => loadDbTasks(selectedProjectId), 5000);
    return () => clearInterval(interval);
  }, [selectedProjectId]);

  const loadProjects = async () => {
    try {
      const projects = await getDbProjects();
      setDbProjects(projects);
      // Auto-select first project
      if (projects.length > 0 && !selectedProjectId) {
        setSelectedProjectId(projects[0].id);
        loadDbTasks(projects[0].id);
      }
    } catch (e) {
      console.error('Failed to load projects:', e);
    }
  };

  const loadDbTasks = async (projectId: number) => {
    try {
      const result = await getDbTasks(projectId);
      setDbTasks(result.tasks || []);
      setJobInfo(result.job || null);
    } catch (e) {
      console.error('Failed to load DB tasks:', e);
    }
  };

  // Filtered tasks
  const filteredTasks = dbTasks.filter(t => {
    if (filter !== 'all' && t.status !== filter) return false;
    if (searchQuery && !t.title.toLowerCase().includes(searchQuery.toLowerCase()) &&
        !t.task_id.toLowerCase().includes(searchQuery.toLowerCase())) return false;
    return true;
  });

  // Status counts
  const counts = {
    all: dbTasks.length,
    completed: dbTasks.filter(t => t.status === 'completed').length,
    running: dbTasks.filter(t => t.status === 'running').length,
    failed: dbTasks.filter(t => t.status === 'failed').length,
    pending: dbTasks.filter(t => t.status === 'pending').length,
  };

  const statusColor = (status: string) => {
    switch (status) {
      case 'completed': return 'text-green-400';
      case 'running': return 'text-blue-400 animate-pulse';
      case 'failed': return 'text-red-400';
      case 'blocked': return 'text-yellow-400';
      default: return 'text-gray-400';
    }
  };

  const statusIcon = (status: string) => {
    switch (status) {
      case 'completed': return '✓';
      case 'running': return '▶';
      case 'failed': return '✗';
      case 'blocked': return '⏸';
      default: return '○';
    }
  };

  const statusBg = (status: string) => {
    switch (status) {
      case 'completed': return 'bg-green-500/10 border-green-500/20';
      case 'running': return 'bg-blue-500/10 border-blue-500/20';
      case 'failed': return 'bg-red-500/10 border-red-500/20';
      case 'blocked': return 'bg-yellow-500/10 border-yellow-500/20';
      default: return 'bg-white/5 border-white/10';
    }
  };

  return (
    <div className="flex flex-col h-full gap-3">
      {/* Header with project selector and job progress */}
      <div className="flex items-center gap-3 flex-wrap">
        {/* Project selector */}
        <select
          value={selectedProjectId || ''}
          onChange={(e) => {
            const id = Number(e.target.value);
            setSelectedProjectId(id);
            loadDbTasks(id);
          }}
          className="text-sm px-3 py-1.5 rounded-lg bg-white/10 border border-white/20 text-white"
        >
          {dbProjects.map(p => (
            <option key={p.id} value={p.id}>{p.name} ({p.status})</option>
          ))}
          {dbProjects.length === 0 && <option value="">No projects</option>}
        </select>

        {/* Job progress bar */}
        {jobInfo && (
          <div className="flex items-center gap-2 flex-1">
            <div className="flex-1 h-2 bg-white/10 rounded-full overflow-hidden">
              <div
                className="h-full bg-indigo-500 rounded-full transition-all"
                style={{ width: `${jobInfo.progress_pct}%` }}
              />
            </div>
            <span className="text-xs text-white/60 whitespace-nowrap">
              {jobInfo.tasks_completed}/{jobInfo.total_tasks} ({Math.round(jobInfo.progress_pct)}%)
            </span>
            <span className={`text-xs px-2 py-0.5 rounded-full ${
              jobInfo.status === 'running' ? 'bg-blue-500/20 text-blue-400' :
              jobInfo.status === 'completed' ? 'bg-green-500/20 text-green-400' :
              'bg-red-500/20 text-red-400'
            }`}>
              {jobInfo.status}
            </span>
          </div>
        )}
      </div>

      {/* Filter bar */}
      <div className="flex items-center gap-2">
        <input
          type="text"
          placeholder="Search tasks..."
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
          className="text-xs px-3 py-1.5 rounded-lg bg-white/10 border border-white/20 text-white placeholder:text-white/30 w-48"
        />
        {(['all', 'completed', 'running', 'failed', 'pending'] as const).map(f => (
          <button
            key={f}
            onClick={() => setFilter(f)}
            className={`text-xs px-2 py-1 rounded-full transition-colors ${
              filter === f ? 'bg-indigo-600 text-white' : 'bg-white/5 text-white/60 hover:bg-white/10'
            }`}
          >
            {f} ({counts[f]})
          </button>
        ))}
      </div>

      {/* Task list */}
      <div className="flex-1 overflow-y-auto space-y-1.5">
        {filteredTasks.length === 0 ? (
          <div className="text-white/50 text-sm text-center py-8">
            {dbTasks.length === 0 ? 'No tasks yet — start a generation' : 'No tasks match filter'}
          </div>
        ) : (
          filteredTasks.map(task => (
            <div key={task.id} className={`p-2.5 rounded-lg border ${statusBg(task.status)}`}>
              <div className="flex items-center gap-2">
                <span className={`text-sm ${statusColor(task.status)}`}>{statusIcon(task.status)}</span>
                <span className="text-sm text-white font-medium truncate flex-1">{task.title}</span>
                <span className="text-[10px] text-white/30 font-mono">{task.task_id.split('-').slice(-2).join('-')}</span>
                {task.execution_time_ms && (
                  <span className="text-[10px] text-white/40">{(task.execution_time_ms / 1000).toFixed(1)}s</span>
                )}
                {task.cost_usd && (
                  <span className="text-[10px] text-green-400">${task.cost_usd.toFixed(4)}</span>
                )}
              </div>
              {task.description && task.description !== task.title && (
                <p className="text-[11px] text-white/40 mt-0.5 ml-6 truncate">{task.description}</p>
              )}
              {task.status_message && (
                <p className="text-[11px] text-red-400/80 mt-0.5 ml-6 truncate">{task.status_message}</p>
              )}
              {task.depends_on.length > 0 && (
                <div className="ml-6 mt-0.5 flex gap-1 flex-wrap">
                  {task.depends_on.slice(0, 3).map(dep => (
                    <span key={dep} className="text-[9px] px-1.5 py-0.5 rounded bg-white/5 text-white/30">{dep.split('-').slice(-2).join('-')}</span>
                  ))}
                  {task.depends_on.length > 3 && (
                    <span className="text-[9px] text-white/30">+{task.depends_on.length - 3} more</span>
                  )}
                </div>
              )}
            </div>
          ))
        )}
      </div>
    </div>
  );
}
