#!/bin/bash
echo "🛑 Stopping Client Acquisition Stack..."
cd ../Docker
docker compose down
echo "✅ All services stopped"