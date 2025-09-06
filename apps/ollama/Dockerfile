# Stage 1: Build Ollama
FROM ubuntu:24.04 AS build

LABEL       author="Chriss Quartz" maintainer="quartz@zentrahosting.xyz"

ENV DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update && apt-get install -y \
    curl ccache gcc g++ git make cmake golang-go \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy source code (adjust path as needed)
COPY . .

# Build Ollama
RUN --mount=type=cache,target=/root/.ccache \
    mkdir -p build && cd build && \
    cmake .. && \
    cmake --build . --parallel && \
    cmake --install . --strip

# Stage 2: Create runtime image compatible with Pterodactyl
FROM ubuntu:24.04

LABEL       author="Chriss Quartz" maintainer="quartz@zentrahosting.xyz"

ENV DEBIAN_FRONTEND=noninteractive

# Install runtime dependencies (adjust as needed)
RUN apt-get update && apt-get install -y \
    ca-certificates curl ccache libgcc1 libc++-dev libstdc++6 libcurl4 libsqlite3-0 libssl3 tini \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /home/container

STOPSIGNAL SIGINT

# Copy Ollama binaries and libraries from build stage
COPY --from=build /usr/bin/ollama /usr/bin/ollama
COPY --from=build /usr/lib/ollama /usr/lib/ollama

RUN         adduser -D -h /home/container container -s /bin/bash container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

STOPSIGNAL SIGINT

# Switch to non-root user
USER container

ENTRYPOINT    ["/sbin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]