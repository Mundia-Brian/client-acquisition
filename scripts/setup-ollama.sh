#!/bin/bash
echo "🧠 Setting up local AI models..."

# Wait for Ollama to be ready
until curl -f -s http://localhost:11434/api/tags > /dev/null; do
    echo "Waiting for Ollama..."
    sleep 5
done

# Pull free models
echo "📥 Downloading Llama2 (7B)..."
curl -X POST http://localhost:11434/api/pull -d '{"name":"llama2"}'

echo "📥 Downloading CodeLlama..."
curl -X POST http://localhost:11434/api/pull -d '{"name":"codellama"}'

echo "✅ Local AI models ready for zero-cost operation"