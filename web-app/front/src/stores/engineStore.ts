// front/src/stores/engineStore.ts
import { create } from 'zustand';
import type { AgentInfo, EpicInfo, GenerationPhase } from '@/services/engineApi';
import { createEngineWebSocket } from '@/services/engineApi';

interface EngineState {
  // Connection
  connected: boolean;
  ws: WebSocket | null;

  // Active generation
  activeProject: string | null;
  phase: GenerationPhase;
  progressPct: number;
  agents: AgentInfo[];
  epics: EpicInfo[];

  // Actions
  connect: () => void;
  disconnect: () => void;
  setActiveProject: (name: string | null) => void;
}

export const useEngineStore = create<EngineState>((set, get) => ({
  connected: false,
  ws: null,
  activeProject: null,
  phase: 'idle',
  progressPct: 0,
  agents: [],
  epics: [],

  connect: () => {
    if (get().ws) return; // Already connected

    const ws = createEngineWebSocket((type, data) => {
      switch (type) {
        case 'engine:agent_status':
          set((s) => ({
            agents: s.agents.map((a) =>
              a.name === data.name ? { ...a, ...data } : a
            ),
          }));
          break;
        case 'engine:epic_progress':
          set((s) => ({
            epics: s.epics.map((e) =>
              e.id === data.id ? { ...e, ...data } : e
            ),
          }));
          break;
        case 'engine:progress':
          set({ progressPct: data.progress_pct, phase: data.phase });
          break;
        case 'engine:phase_change':
          set({ phase: data.phase });
          break;
        default:
          break;
      }
    });

    ws.onopen = () => set({ connected: true });
    ws.onclose = () => set({ connected: false, ws: null });

    set({ ws });
  },

  disconnect: () => {
    const { ws } = get();
    if (ws) {
      ws.close();
      set({ ws: null, connected: false });
    }
  },

  setActiveProject: (name) => set({ activeProject: name }),
}));
