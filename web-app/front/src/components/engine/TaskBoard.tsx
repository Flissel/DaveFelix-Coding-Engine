// web-app/front/src/components/engine/TaskBoard.tsx
import { useState } from 'react';
import { platform } from '@/services/platform';
import { useEngineStore } from '@/stores/engineStore';

interface Task {
  id: string;
  name: string;
  status: 'pending' | 'running' | 'completed' | 'failed';
  description?: string;
  elapsed_seconds?: number;
  error?: string;
}

export function TaskBoard({ projectPath }: { projectPath: string }) {
  const epics = useEngineStore(state => state.epics);
  const selectedEpicId = useEngineStore(state => state.selectedEpicId);
  const [tasks, setTasks] = useState<Task[]>([]);
  const [loading, setLoading] = useState(false);
  const [fixInput, setFixInput] = useState<Record<string, string>>({});

  const loadTasks = async (epicId: string) => {
    setLoading(true);
    try {
      const result = await platform.engine.getEpicTasks(epicId, projectPath);
      setTasks(result.tasks || []);
      useEngineStore.setState({ selectedEpicId: epicId });
    } catch (e) {
      console.error('Failed to load tasks:', e);
    } finally {
      setLoading(false);
    }
  };

  const handleRunEpic = async (epicId: string) => {
    await platform.engine.runEpic(epicId, projectPath);
  };

  const handleRerunTask = async (epicId: string, taskId: string) => {
    await platform.engine.rerunTask(epicId, taskId, projectPath, fixInput[taskId]);
    setFixInput(prev => ({ ...prev, [taskId]: '' }));
    if (selectedEpicId) loadTasks(selectedEpicId);
  };

  const statusColor = (status: string) => {
    switch (status) {
      case 'completed': return 'text-green-400';
      case 'running': return 'text-blue-400';
      case 'failed': return 'text-red-400';
      default: return 'text-gray-400';
    }
  };

  const statusDot = (status: string) => {
    switch (status) {
      case 'completed': return '\u2713';
      case 'running': return '\u25B6';
      case 'failed': return '\u2717';
      default: return '\u25CB';
    }
  };

  return (
    <div className="flex h-full gap-4">
      {/* Epic list */}
      <div className="w-64 border-r border-white/10 pr-4 overflow-y-auto">
        <h3 className="text-sm font-semibold text-white/70 mb-3">Epics</h3>
        {epics.map(epic => (
          <div
            key={epic.id}
            onClick={() => loadTasks(epic.id)}
            className={`p-3 rounded-lg cursor-pointer mb-2 transition-colors ${
              selectedEpicId === epic.id ? 'bg-indigo-600/30 border border-indigo-500/50' : 'bg-white/5 hover:bg-white/10'
            }`}
          >
            <div className="text-sm font-medium text-white">{epic.name}</div>
            <div className="flex items-center gap-2 mt-1">
              <div className="flex-1 h-1.5 bg-white/10 rounded-full overflow-hidden">
                <div className="h-full bg-indigo-500 rounded-full" style={{ width: `${epic.progress_pct}%` }} />
              </div>
              <span className="text-xs text-white/50">{epic.tasks_complete}/{epic.tasks_total}</span>
            </div>
            <button
              onClick={(e) => { e.stopPropagation(); handleRunEpic(epic.id); }}
              className="mt-2 text-xs px-2 py-1 rounded bg-indigo-600 hover:bg-indigo-500 text-white"
            >
              Run Epic
            </button>
          </div>
        ))}
      </div>

      {/* Task list */}
      <div className="flex-1 overflow-y-auto">
        <h3 className="text-sm font-semibold text-white/70 mb-3">
          Tasks {selectedEpicId && `(${tasks.length})`}
        </h3>
        {loading ? (
          <div className="text-white/50 text-sm">Loading tasks...</div>
        ) : tasks.length === 0 ? (
          <div className="text-white/50 text-sm">Select an epic to view tasks</div>
        ) : (
          <div className="space-y-2">
            {tasks.map(task => (
              <div key={task.id} className="p-3 bg-white/5 rounded-lg">
                <div className="flex items-center gap-2">
                  <span className={`text-sm ${statusColor(task.status)}`}>{statusDot(task.status)}</span>
                  <span className="text-sm text-white font-medium">{task.name}</span>
                  {task.elapsed_seconds && (
                    <span className="text-xs text-white/40 ml-auto">{task.elapsed_seconds}s</span>
                  )}
                </div>
                {task.description && (
                  <p className="text-xs text-white/50 mt-1 ml-6">{task.description}</p>
                )}
                {task.error && (
                  <p className="text-xs text-red-400 mt-1 ml-6">{task.error}</p>
                )}
                {task.status === 'failed' && selectedEpicId && (
                  <div className="ml-6 mt-2 flex gap-2">
                    <input
                      type="text"
                      placeholder="Fix instructions (optional)"
                      value={fixInput[task.id] || ''}
                      onChange={(e) => setFixInput(prev => ({ ...prev, [task.id]: e.target.value }))}
                      className="flex-1 text-xs px-2 py-1 rounded bg-white/10 border border-white/20 text-white placeholder:text-white/30"
                    />
                    <button
                      onClick={() => handleRerunTask(selectedEpicId, task.id)}
                      className="text-xs px-2 py-1 rounded bg-orange-600 hover:bg-orange-500 text-white"
                    >
                      Rerun
                    </button>
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
