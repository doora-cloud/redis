#!/bin/bash

echo "🔄 Fetching secrets from Infisical..."
export $(infisical export --domain "$VAULT_URL" --projectId "$VAULT_PROJECT_ID" --env "$VAULT_ENV" --format=dotenv | xargs)

echo "✅ Secrets loaded"

echo "🚀 Starting Redis..."

exec docker-entrypoint.sh redis-server --save 60 1000 \
  --loglevel warning \
  --requirepass ${REDIS_PASS} \
  --maxmemory 512mb \
  --maxmemory-policy allkeys-lru \
  --appendonly yes \
  --appendfsync everysec \
  --no-appendfsync-on-rewrite yes \
  --auto-aof-rewrite-percentage 100 \
  --auto-aof-rewrite-min-size 64mb \
  --tcp-keepalive 300 \
  --activedefrag yes
