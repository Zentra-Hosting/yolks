FROM        --platform=$TARGETOS/$TARGETARCH ollama/ollama:latest

LABEL       author="Chriss Quartz" maintainer="quartz@zentrahosting.xyz"

RUN useradd -m -d /home/container -s /bin/bash container

WORKDIR /home/container

# Copy your entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Change ownership to container user
RUN chown -R container:container /home/container /entrypoint.sh
USER container

ENTRYPOINT    ["/sbin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]