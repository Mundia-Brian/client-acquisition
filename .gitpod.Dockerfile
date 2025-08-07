FROM gitpod/workspace-full

# Install Docker
USER root
RUN apt-get update && \
    apt-get install -y docker.io docker-compose && \
    usermod -aG docker gitpod

# Enable Docker-in-Docker
RUN dockerd-entrypoint.sh &

USER gitpod
