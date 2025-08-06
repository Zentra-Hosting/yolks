FROM        --platform=$TARGETOS/$TARGETARCH node:12-bullseye-slim

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
    tini \
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list \
    && apt update \
    && apt install -y google-chrome-stable --no-install-recommends --allow-downgrades

# Install npm packages globally
RUN         npm install --global npm@latest typescript ts-node @types/node

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT  ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]