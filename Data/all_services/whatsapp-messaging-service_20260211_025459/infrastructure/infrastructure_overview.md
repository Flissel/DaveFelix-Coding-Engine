# Infrastructure Configuration: whatsapp-messaging-service

**Generated:** 2026-02-12T17:16:27.032626

## Files Generated

| File | Description |
|------|-------------|
| `.env.example` | Environment variables |
| `docker-compose.yml` | Local development stack |
| `Dockerfile` | Backend container image |
| `kubernetes/deployment.yaml` | K8s deployment |
| `kubernetes/service.yaml` | K8s service |
| `kubernetes/configmap.yaml` | K8s config |
| `.github/workflows/ci.yml` | CI/CD pipeline |

## Environment Variables

| Variable | Default |
|----------|---------|
| `NODE_ENV` | `development` |
| `PORT` | `3000` |
| `APP_NAME` | `whatsapp_messaging_service` |
| `LOG_LEVEL` | `info` |
| `DB_HOST` | `localhost` |
| `DB_PORT` | `5432` |
| `DB_NAME` | `whatsapp_messaging_service` |
| `DB_USER` | `postgres` |
| `DB_PASSWORD` | `changeme` |
| `DATABASE_URL` | `postgresql://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}` |
| `REDIS_HOST` | `localhost` |
| `REDIS_PORT` | `6379` |
| `REDIS_URL` | `redis://${REDIS_HOST}:${REDIS_PORT}` |
| `KAFKA_BROKERS` | `localhost:9092` |
| `KAFKA_CLIENT_ID` | `whatsapp_messaging_service` |
| `KAFKA_GROUP_ID` | `whatsapp_messaging_service-consumer` |
| `JWT_SECRET` | `your-secret-key-change-in-production` |
| `JWT_EXPIRY` | `3600` |
| `JWT_REFRESH_EXPIRY` | `604800` |
| `KONG_ADMIN_URL` | `http://localhost:8001` |
| `SMS_PROVIDER_API_KEY` | `` |
| `SMS_PROVIDER_URL` | `` |
| `PUSH_NOTIFICATION_KEY` | `` |
| `STORAGE_BUCKET` | `whatsapp_messaging_service-uploads` |
