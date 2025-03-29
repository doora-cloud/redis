#!/bin/bash

echo "🔄 Fetching secrets from Infisical..."
export $(infisical export --domain "$VAULT_URL" --projectId "$VAULT_PROJECT_ID" --env "$VAULT_ENV" --format=dotenv | xargs)

echo "✅ Secrets loaded"

echo "🚀 Starting Redis..."

exec docker-entrypoint.sh redis-server --save 20 1 --loglevel warning --requirepass $REDIS_PASS
