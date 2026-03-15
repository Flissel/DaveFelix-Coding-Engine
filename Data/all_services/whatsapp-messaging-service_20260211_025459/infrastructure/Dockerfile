# Dockerfile for whatsapp_messaging_service backend (node.js)
# Generated: 2026-02-12T17:16:27.029376

FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build
ENV NODE_ENV=production
EXPOSE 3000
USER node
CMD ["node", "dist/main.js"]
