// front/src/components/engine/VncPreview.tsx
import { useState, useEffect } from 'react';
import { platform } from '@/services/platform';
import { useEngineStore } from '@/stores/engineStore';

interface VncPreviewProps {
  vncUrl?: string;
  projectName: string;
}

export function VncPreview({ vncUrl: propVncUrl, projectName }: VncPreviewProps) {
  const [status, setStatus] = useState<'connecting' | 'connected' | 'error'>('connecting');
  const [vncPort, setVncPort] = useState<number | null>(null);
  const storeVncUrl = useEngineStore(state => state.vncPreviewUrl);

  // Resolve VNC port via platform adapter
  useEffect(() => {
    if (projectName) {
      platform.ports.getVncPort(projectName).then(port => {
        if (port) setVncPort(port);
      });
    }
  }, [projectName]);

  // Build VNC URL: prop > store > port-resolved > null
  const vncUrl = propVncUrl
    || storeVncUrl
    || (vncPort ? `http://localhost:${vncPort}/vnc.html?autoconnect=true&resize=scale&reconnect=true` : null);

  useEffect(() => {
    if (!vncUrl) {
      setStatus('connecting');
      return;
    }
    // Health check
    const check = setInterval(async () => {
      try {
        const res = await fetch(vncUrl.replace('/vnc.html', '/').split('?')[0], { mode: 'no-cors' });
        setStatus('connected');
      } catch {
        setStatus('connecting');
      }
    }, 3000);
    return () => clearInterval(check);
  }, [vncUrl]);

  return (
    <div className="flex flex-col h-full border-l border-border/30">
      <div className="flex items-center gap-2 px-3 py-2 border-b border-border/30">
        <span className="text-sm text-muted-foreground font-medium">Live Preview</span>
        <span className={`ml-auto text-[10px] px-2 py-0.5 rounded-full border ${
          status === 'connected'
            ? 'bg-green-500/10 text-green-400 border-green-500/25'
            : 'bg-yellow-500/10 text-yellow-400 border-yellow-500/25'
        }`}>
          {status === 'connected' ? 'Connected' : 'Connecting...'}
        </span>
      </div>
      <div className="flex-1 bg-black m-1.5 rounded-md overflow-hidden">
        {vncUrl ? (
          <iframe
            src={vncUrl}
            className="w-full h-full border-0"
            title={`Preview: ${projectName}`}
            sandbox="allow-same-origin allow-scripts allow-forms"
          />
        ) : (
          <div className="w-full h-full flex items-center justify-center text-muted-foreground text-sm">
            <div className="text-center">
              <p>Waiting for preview...</p>
              <p className="text-xs mt-1">Start generation to see live output</p>
            </div>
          </div>
        )}
      </div>
      <div className="px-3 py-1.5 text-[10px] text-muted-foreground bg-background/50 flex items-center gap-2">
        <span>{vncUrl || 'localhost:6080/vnc.html'}</span>
      </div>
    </div>
  );
}
