#!/bin/bash
echo "🌐 Cloud Deployment Setup"

# Detect platform
if [ "$GITPOD_WORKSPACE_URL" ]; then
    echo "📍 Gitpod detected"
    PLATFORM="gitpod"
    BASE_URL=$GITPOD_WORKSPACE_URL
elif [ "$RAILWAY_ENVIRONMENT" ]; then
    echo "🚂 Railway detected"
    PLATFORM="railway"
    BASE_URL="https://$RAILWAY_STATIC_URL"
elif [ "$RENDER" ]; then
    echo "🎨 Render detected"
    PLATFORM="render"
    BASE_URL="https://$RENDER_EXTERNAL_URL"
elif [ "$VERCEL" ]; then
    echo "▲ Vercel detected"
    PLATFORM="vercel"
    BASE_URL="https://$VERCEL_URL"
else
    echo "💻 Local environment"
    PLATFORM="local"
    BASE_URL="http://localhost"
fi

# Update environment for cloud deployment
if [ "$PLATFORM" != "local" ]; then
    echo "🔧 Configuring for cloud deployment..."
    
    # Update webhook URLs
    sed -i "s|http://localhost:5678|${BASE_URL}:5678|g" n8n-flows/*.json
    sed -i "s|http://n8n:5678|${BASE_URL}:5678|g" n8n-flows/*.json
    
    # Update service URLs
    sed -i "s|http://localhost|${BASE_URL}|g" .env
    
    # Set platform-specific configs
    echo "DEPLOYMENT_PLATFORM=${PLATFORM}" >> .env
    echo "BASE_URL=${BASE_URL}" >> .env
    
    # Create subdomain mappings
    cat > subdomain-config.json << EOF
{
    "platform": "$PLATFORM",
    "base_url": "$BASE_URL",
    "services": {
        "crm": "${BASE_URL}:8080",
        "n8n": "${BASE_URL}:5678", 
        "mixpost": "${BASE_URL}:8081",
        "botpress": "${BASE_URL}:3000",
        "posthog": "${BASE_URL}:8000",
        "ollama": "${BASE_URL}:11434",
        "whisper": "${BASE_URL}:9000"
    }
}
EOF
fi

echo "✅ Deployment configuration complete for $PLATFORM"