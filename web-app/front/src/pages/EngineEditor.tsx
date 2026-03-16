// front/src/pages/EngineEditor.tsx
import { useParams } from 'react-router-dom';
import { useEngineProject, useGenerationStatus, useStartGeneration } from '@/hooks/useEngine';
import { WorkTabs } from '@/components/engine/WorkTabs';
import { VncPreview } from '@/components/engine/VncPreview';
import { GenerationMonitor } from '@/components/engine/GenerationMonitor';

const EngineEditor = () => {
  const { projectName } = useParams<{ projectName: string }>();
  const { data: project, isLoading } = useEngineProject(projectName || '');
  const { data: status } = useGenerationStatus(projectName || '');
  const startGen = useStartGeneration();

  if (!projectName) return <div>No project selected</div>;
  if (isLoading) return <div className="flex items-center justify-center h-screen text-muted-foreground">Loading project...</div>;

  return (
    <div className="h-screen flex flex-col bg-background">
      {/* Main content — flex layout (no ResizablePanelGroup) */}
      <div className="flex-1 flex overflow-hidden">
        {/* Left: Work Area (70%) */}
        <div className="flex-[7] min-w-0">
          <WorkTabs>
            {{
              vibeCoder: (
                <div className="h-full flex flex-col items-center justify-center text-muted-foreground">
                  <p className="text-lg mb-2">Vibe Coder</p>
                  <p className="text-sm">Chat + Code Editor for live adjustments</p>
                  <p className="text-xs mt-4">
                    This will be connected to the existing ChatPanel + CodeEditor
                    <br />once we wire up engine file serving.
                  </p>
                  {status?.phase === 'idle' && (
                    <button
                      onClick={() => startGen.mutate({ name: projectName, skeletonOnly: true })}
                      className="mt-4 px-4 py-2 bg-primary text-primary-foreground rounded-md text-sm"
                    >
                      Start Skeleton Generation
                    </button>
                  )}
                </div>
              ),
              generationMonitor: (
                <GenerationMonitor projectName={projectName} />
              ),
            }}
          </WorkTabs>
        </div>

        {/* Right: VNC Preview (Always Visible, 30%) */}
        <div className="flex-[3] min-w-0">
          <VncPreview projectName={projectName} />
        </div>
      </div>
    </div>
  );
};

export default EngineEditor;
