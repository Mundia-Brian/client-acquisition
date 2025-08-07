FROM gitpod/workspace-full

# Install Docker Compose
RUN sudo curl -L "https://github.com/docker/compose/releases/download/v2.21.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
    && sudo chmod +x /usr/local/bin/docker-compose

# Install additional tools
RUN sudo apt-get update && sudo apt-get install -y \
    postgresql-client \
    redis-tools \
    ffmpeg \
    && sudo rm -rf /var/lib/apt/lists/*

# Pre-pull Docker images to speed up startup
RUN docker pull postgres:15 \
    && docker pull redis:7-alpine \
    && docker pull n8nio/n8n \
    && docker pull espocrm/espocrm \
    && docker pull posthog/posthog \
    && docker pull ollama/ollama \
    && docker pull botpress/server