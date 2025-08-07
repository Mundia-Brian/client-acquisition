#!/bin/bash
set -e

echo "🚀 Client Acquisition Stack Setup"

# Check Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker first."
    exit 1
fi

if ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose not found. Please install Docker Compose first."
    exit 1
fi

# Setup environment
if [ ! -f .env ]; then
    echo "📝 Creating .env file..."
    cp .env.example .env
    echo "⚠️  Please update .env with your actual credentials"
fi

# Start services
echo "🐳 Starting services..."
cd Docker
docker compose up -d

# Wait for services
echo "⏳ Waiting for services to be ready..."
sleep 30

# Health check
echo "🔍 Checking service health..."
services=("crm:8080" "n8n:5678" "posthog:8000" "clickhouse:8123")
for service in "${services[@]}"; do
    name=${service%:*}
    port=${service#*:}
    if curl -f -s http://localhost:$port > /dev/null 2>&1; then
        echo "✅ $name is ready"
    else
        echo "⚠️  $name may still be starting"
    fi
done

echo ""
echo "🎉 Setup complete!"
echo "📊 CRM: http://localhost:8080"
echo "🔄 n8n: http://localhost:5678"
echo "📈 PostHog: http://localhost:8000"
echo "🗄️  ClickHouse: http://localhost:8123"