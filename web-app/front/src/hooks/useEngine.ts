// front/src/hooks/useEngine.ts
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { engineApi, type EngineProject, type EngineProjectDetail, type GenerationStatus } from '@/services/engineApi';

export const engineKeys = {
  all: ['engine'] as const,
  projects: () => [...engineKeys.all, 'projects'] as const,
  project: (name: string) => [...engineKeys.all, 'project', name] as const,
  status: (name: string) => [...engineKeys.all, 'status', name] as const,
};

export function useEngineProjects() {
  return useQuery({
    queryKey: engineKeys.projects(),
    queryFn: () => engineApi.listProjects(),
    staleTime: 60000,
    refetchOnWindowFocus: false,
  });
}

export function useEngineProject(name: string, enabled = true) {
  return useQuery({
    queryKey: engineKeys.project(name),
    queryFn: () => engineApi.getProject(name),
    enabled: enabled && !!name,
    staleTime: 60000,
  });
}

export function useGenerationStatus(name: string, enabled = true) {
  return useQuery({
    queryKey: engineKeys.status(name),
    queryFn: () => engineApi.getStatus(name),
    enabled: enabled && !!name,
    refetchInterval: 3000, // Always poll — backend generation can start externally
    retry: 1,
  });
}

export function useStartGeneration() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: ({ name, projectPath, parallelism }: {
      name: string;
      projectPath?: string;
      parallelism?: number;
    }) =>
      engineApi.startGeneration(name, { projectPath, parallelism }),
    onSuccess: (status) => {
      queryClient.setQueryData(engineKeys.status(status.project_name), status);
      queryClient.invalidateQueries({ queryKey: engineKeys.projects() });
    },
  });
}

export function useStopGeneration() {
  const queryClient = useQueryClient();
  return useMutation({
    mutationFn: (name: string) => engineApi.stopGeneration(name),
    onSuccess: (status) => {
      queryClient.setQueryData(engineKeys.status(status.project_name), status);
    },
  });
}
