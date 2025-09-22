FROM        --platform=$TARGETOS/$TARGETARCH node:24

LABEL       author="Chriss Quartz" maintainer="quartz@zentrahosting.xyz"

# Add container user and set stop signal
RUN         useradd -m -d /home/container container
STOPSIGNAL  SIGINT

# Update and install necessary packages (expanded for Puppeteer/Chromium deps)
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
    # Puppeteer/Chromium core libs (your originals + missing ones)
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libx11-xcb1 \
    libxcomposite1 \
    libxrandr2 \
    libxss1 \
    libasound2 \
    libgtk-3-0 \
    libdrm2 \
    libxkbcommon0 \
    libatspi2.0-0 \
    libcairo2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libglib2.0-0 \
    libnspr4 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libx11-6 \
    libxcb1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxtst6 \
    # Your other packages
    lsb-release \
    apt-transport-https \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-thai-tlwg \
    fonts-khmeros \
    fonts-kacst \
    fonts-freefont-ttf \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Install npm packages globally
RUN         npm install --global npm@latest typescript ts-node @types/node puppeteer

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT  ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]