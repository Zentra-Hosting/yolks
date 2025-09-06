#!/bin/bash
set -e

cd /home/container

# Export HOME so Ollama writes config to a writable directory
export HOME=/home/container

# Create .ollama directory if it doesn't exist
mkdir -p "$HOME/.ollama"

# Ensure permissions (optional, since container user owns /home/container)
chmod 700 "$HOME/.ollama"

# Make internal Docker IP address available to processes
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Replace Startup Variables (handle {{VAR}} syntax)
MODIFIED_STARTUP=$(echo -e "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo ":/home/container$ ${MODIFIED_STARTUP}"

# Run the server command
eval "${MODIFIED_STARTUP}"