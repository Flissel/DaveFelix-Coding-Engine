import { defineConfig } from "vite";
import react from "@vitejs/plugin-react-swc";
import path from "path";
import { componentTagger } from "lovable-tagger";

// https://vitejs.dev/config/
export default defineConfig(({ mode }) => ({
  server: {
    host: "::",
    port: 8080,
    headers: {
      // COEP/COOP removed — blocks cross-origin VNC iframe and health checks
      // Re-add only if SharedArrayBuffer is needed for WASM features
    },
    proxy: {
      // Coding Engine routes (Docker container on port 8000)
      '/api/v1/dashboard': { target: 'http://localhost:8000', changeOrigin: true },
      '/api/v1/ws': { target: 'http://localhost:8000', changeOrigin: true, ws: true },
      '/api/v1/engine/generation/ws': { target: 'http://localhost:8000', changeOrigin: true, ws: true },
      '/api/v1/engine': { target: 'http://localhost:8000', changeOrigin: true },
      // engine-settings is under /api/v1/dashboard/engine-settings (covered by dashboard proxy)
      '/api/v1/jobs': { target: 'http://localhost:8000', changeOrigin: true },
      '/api/v1/colony': { target: 'http://localhost:8000', changeOrigin: true },
      '/api/v1/enrichment': { target: 'http://localhost:8000', changeOrigin: true },
      '/api/v1/artifacts': { target: 'http://localhost:8000', changeOrigin: true },
      '/api/v1/vision': { target: 'http://localhost:8000', changeOrigin: true },
      '/api/v1/llm-config': { target: 'http://localhost:8000', changeOrigin: true },
      '/api/v1/clarifications': { target: 'http://localhost:8000', changeOrigin: true },
      '/api/v1/projects': { target: 'http://localhost:8000', changeOrigin: true },
      // Catch-all — route everything to Coding Engine API
      '/api/v1': { target: 'http://localhost:8000', changeOrigin: true },
    },
  },
  plugins: [react(), mode === "development" && componentTagger()].filter(Boolean),
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
}));
