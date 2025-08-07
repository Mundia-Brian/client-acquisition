#!/bin/bash
echo "🧪 Testing Automation Pipeline"

# Test database connection
echo "Testing database..."
docker exec postgres psql -U postgres -d leads -c "SELECT COUNT(*) FROM prospects;" || echo "❌ Database test failed"

# Test n8n webhooks
echo "Testing n8n webhooks..."
curl -X POST http://localhost:5678/webhook/test -d '{"test": true}' -H "Content-Type: application/json" || echo "❌ n8n webhook test failed"

# Test communication hub
echo "Testing communication hub..."
curl -X POST http://localhost:5000/test -d '{"test": true}' -H "Content-Type: application/json" || echo "❌ Communication hub test failed"

# Test AI services
echo "Testing Ollama..."
curl -X POST http://localhost:11434/api/generate -d '{"model":"llama2","prompt":"test","stream":false}' || echo "❌ Ollama test failed"

echo "Testing Whisper..."
curl -X GET http://localhost:9000/health || echo "❌ Whisper test failed"

# Test lead scoring
echo "Testing lead scoring..."
docker exec lead-scorer python -c "
import psycopg2
import os
conn = psycopg2.connect(host='postgres', database='leads', user='postgres', password=os.getenv('POSTGRES_PASSWORD'))
cursor = conn.cursor()
cursor.execute('SELECT id, score FROM prospects LIMIT 1')
result = cursor.fetchone()
print(f'✅ Lead scoring working: ID {result[0]}, Score {result[1]}' if result else '❌ No prospects found')
"

echo "✅ Automation pipeline test complete!"