# Stage 1: Build Ollama
FROM        --platform=$TARGETOS/$TARGETARCH ubuntu:24.04

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

# Download and install specific CMake version if needed (optional)
# RUN curl -fsSL https://github.com/Kitware/CMake/releases/download/v3.31.2/cmake-3.31.2-linux-x86_64.tar.gz | tar xz -C /usr/local --strip-components=1

# Build Ollama
RUN --mount=type=cache,target=/root/.ccache \
    mkdir -p build && cd build && \
    cmake .. && \
    cmake --build . --parallel && \
    cmake --install . --strip

# Stage 2: Create runtime image compatible with Pterodactyl
FROM        --platform=$TARGETOS/$TARGETARCH ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Add container user
RUN useradd -m -d /home/container -s /bin/bash container
ENV USER=container HOME=/home/container

# Install runtime dependencies (adjust as needed)
RUN apt-get update && apt-get install -y \
    ca-certificates curl ccache libgcc1 libc++-dev libstdc++6 libcurl4 libsqlite3-0 libssl3 tini \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure locale
RUN update-locale LANG=en_US.UTF-8 \
    && dpkg-reconfigure --frontend noninteractive locales

WORKDIR /home/container

STOPSIGNAL SIGINT

# Copy Ollama binaries and libraries from build stage
COPY --from=build /usr/bin/ollama /usr/bin/ollama
COPY --from=build /usr/lib/ollama /usr/lib/ollama

# Copy entrypoint script
COPY --chown=container:container entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Switch to non-root user
USER container

ENTRYPOINT ["/usr/bin/tini", "-g", "--", "/entrypoint.sh"]
CMD ["/usr/bin/ollama", "serve"]