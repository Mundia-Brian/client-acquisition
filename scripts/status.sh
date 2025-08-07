#!/bin/bash
echo "📊 Client Acquisition Stack Status"
cd ../Docker
docker compose ps
echo ""
echo "🌐 Service URLs:"
echo "CRM: http://localhost:8080"
echo "n8n: http://localhost:5678" 
echo "PostHog: http://localhost:8000"
echo "ClickHouse: http://localhost:8123"