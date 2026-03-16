// web-app/front/src/components/engine/ServiceStatusBar.tsx
import { useState, useEffect } from 'react';
import { platform, platformEvents, isElectron } from '@/services/platform';

interface Status {
  fastapi: boolean;
  docker: boolean;
}

export function ServiceStatusBar() {
  const [status, setStatus] = useState<Status>({ fastapi: false, docker: false });

  useEffect(() => {
    const checkStatus = async () => {
      try {
        if (isElectron()) {
          const s = await window.electronAPI!.services.getStatus();
          setStatus({ fastapi: s.fastapi, docker: s.docker });
        } else {
          const res = await fetch((import.meta.env.VITE_API_URL || 'http://localhost:8000/api/v1') + '/engine/projects');
          setStatus({ fastapi: res.ok, docker: false });
        }
      } catch {
        setStatus({ fastapi: false, docker: false });
      }
    };

    checkStatus();
    const interval = setInterval(checkStatus, 10000);

    platformEvents.onServiceStatusUpdate((s) => {
      setStatus({ fastapi: s.fastapi, docker: s.docker });
    });

    return () => clearInterval(interval);
  }, []);

  const Dot = ({ active }: { active: boolean }) => (
    <span className={`w-1.5 h-1.5 rounded-full inline-block ${active ? 'bg-green-400' : 'bg-red-400'}`} />
  );

  return (
    <div className="flex items-center gap-3 text-xs text-white/60">
      <span className="flex items-center gap-1"><Dot active={status.fastapi} /> API</span>
      {isElectron() && <span className="flex items-center gap-1"><Dot active={status.docker} /> Docker</span>}
    </div>
  );
}
