FROM        --platform=$TARGETOS/$TARGETARCH node:14-bullseye-slim

LABEL       author="Chriss Quartz" maintainer="quartz@zentrahosting.xyz"

# Add container user and set stop signal
RUN         useradd -m -d /home/container container
STOPSIGNAL  SIGINT

# Update and install necessary packages including Google Chrome
RUN         apt update \
    && apt -y install \
    wget \
    gnupg2 \
    apt-utils \
    ffmpeg \
    iproute2 \
    git \
    sqlite3 \
    libsqlite3-dev \
    python3 \
    python3-dev \
    ca-certificates \
    dnsutils \
    tzdata \
    zip \
    tar \
    curl \
    build-essential \
    libtool \
    iputils-ping \
    libnss3 \
    libatk1.0-0 \            
    libcups2 \                
    libx11-xcb1 \             
    libxcomposite1 \           
    libxrandr2 \  
    libxss1 \     
    libasound2 \  
    libgtk-3-0

# Install npm packages globally
RUN         npm install --global npm@latest typescript ts-node @types/node

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT  ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]