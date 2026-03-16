// front/src/services/engineApi.ts
import { API_URL } from './api';

// Types
export interface EngineProject {
  name: string;
  path: string;
  service_count: number;
  endpoint_count: number;
  story_count: number;
  type: 'engine' | 'vibe';
}

export interface EngineProjectDetail extends EngineProject {
  services: Array<{
    name: string;
    port: number;
    endpoint_count: number;
    entity_count: number;
    story_count: number;
  }>;
  generation_order: string[];
  dependency_graph: Record<string, string[]>;
}

export type AgentStatus = 'running' | 'done' | 'queued' | 'failed';
export type GenerationPhase = 'idle' | 'parsing' | 'skeleton' | 'generation' | 'validation' | 'integration' | 'complete' | 'failed';

export interface AgentInfo {
  name: string;
  status: AgentStatus;
  task: string;
  elapsed_seconds: number;
}

export interface EpicInfo {
  id: string;
  name: string;
  progress_pct: number;
  tasks_total: number;
  tasks_complete: number;
}

export interface GenerationStatus {
  project_name: string;
  phase: GenerationPhase;
  progress_pct: number;
  agents: AgentInfo[];
  epics: EpicInfo[];
  service_count: number;
  endpoint_count: number;
}

// REST API
export const engineApi = {
  listProjects: async (): Promise<EngineProject[]> => {
    const res = await fetch(`${API_URL}/engine/projects`);
    if (!res.ok) throw new Error(`Failed to list engine projects: ${res.status}`);
    return res.json();
  },

  getProject: async (name: string): Promise<EngineProjectDetail> => {
    const res = await fetch(`${API_URL}/engine/projects/${encodeURIComponent(name)}`);
    if (!res.ok) throw new Error(`Failed to get engine project: ${res.status}`);
    return res.json();
  },

  getStatus: async (name: string): Promise<GenerationStatus> => {
    const res = await fetch(`${API_URL}/engine/projects/${encodeURIComponent(name)}/status`);
    if (!res.ok) throw new Error(`Failed to get generation status: ${res.status}`);
    return res.json();
  },

  startGeneration: async (name: string, skeletonOnly = false): Promise<GenerationStatus> => {
    const res = await fetch(`${API_URL}/engine/projects/${encodeURIComponent(name)}/start`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ skeleton_only: skeletonOnly }),
    });
    if (!res.ok) throw new Error(`Failed to start generation: ${res.status}`);
    return res.json();
  },

  stopGeneration: async (name: string): Promise<GenerationStatus> => {
    const res = await fetch(`${API_URL}/engine/projects/${encodeURIComponent(name)}/stop`, {
      method: 'POST',
    });
    if (!res.ok) throw new Error(`Failed to stop generation: ${res.status}`);
    return res.json();
  },
};

// WebSocket connection
export function createEngineWebSocket(
  onEvent: (type: string, data: any) => void,
): WebSocket {
  const wsUrl = API_URL.replace('http', 'ws').replace('/api/v1', '') + '/api/v1/engine/ws';
  const ws = new WebSocket(wsUrl);

  ws.onmessage = (event) => {
    try {
      const msg = JSON.parse(event.data);
      onEvent(msg.type, msg.data);
    } catch (e) {
      console.error('Failed to parse engine WS message:', e);
    }
  };

  ws.onerror = (e) => console.error('Engine WS error:', e);
  ws.onclose = () => console.log('Engine WS closed');

  return ws;
}
