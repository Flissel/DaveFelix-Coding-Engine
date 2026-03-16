// web-app/front/src/services/clarificationApi.ts
const API_BASE = import.meta.env.VITE_API_URL || 'http://localhost:8000/api/v1';

export interface Clarification {
  id: string;
  task_id: string;
  question: string;
  options?: { id: string; label: string; description?: string }[];
  status: 'pending' | 'resolved';
}

export const getClarifications = async (): Promise<Clarification[]> => {
  const res = await fetch(`${API_BASE}/clarifications`);
  return res.json();
};

export const submitClarificationChoice = async (id: string, choiceId: string): Promise<void> => {
  await fetch(`${API_BASE}/clarifications/${id}/choice`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ choice_id: choiceId }),
  });
};
