#!/bin/bash
echo "📥 Importing n8n workflows..."

# Wait for n8n to be ready
until curl -f -s http://localhost:5678/healthz > /dev/null; do
    echo "Waiting for n8n..."
    sleep 5
done

# Import workflows
for workflow in ../n8n-flows/*.json; do
    if [ -f "$workflow" ]; then
        echo "Importing $(basename "$workflow")..."
        curl -X POST http://localhost:5678/rest/workflows/import \
             -H "Content-Type: application/json" \
             -u "${N8N_BASIC_AUTH_USER}:${N8N_BASIC_AUTH_PASSWORD}" \
             -d @"$workflow"
    fi
done

echo "✅ Workflows imported successfully"