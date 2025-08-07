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
sleep 60

# Health check
echo "🔍 Checking service health..."
services=("crm:8080" "n8n:5678" "mixpost:8081" "posthog:8000" "clickhouse:8123" "postgres:5432" "redis:6379" "botpress:3000" "ollama:11434" "whisper:9000")
for service in "${services[@]}"; do
    name=${service%:*}
    port=${service#*:}
    if curl -f -s http://localhost:$port > /dev/null 2>&1 || nc -z localhost $port 2>/dev/null; then
        echo "✅ $name is ready"
    else
        echo "⚠️  $name may still be starting"
    fi
done

echo ""
echo "🎉 Complete Conversion Stack Ready!"
echo "📊 CRM: http://localhost:8080"
echo "🔄 n8n Automation: http://localhost:5678"
echo "📱 Mixpost Social: http://localhost:8081"
echo "🤖 Botpress Chatbot: http://localhost:3000"
echo "📈 PostHog Analytics: http://localhost:8000"
echo "🗄️  ClickHouse: http://localhost:8123"
echo "🧠 Ollama AI: http://localhost:11434"
echo "🎤 Whisper Voice: http://localhost:9000"
echo "💾 PostgreSQL: localhost:5432"
echo "⚡ Redis: localhost:6379"
echo ""
echo "🚀 Features: Calls, SMS, WhatsApp, Video Creation, YouTube Upload, Chatbots"
echo "💰 Zero-cost AI with Ollama + Whisper for perpetual operation"