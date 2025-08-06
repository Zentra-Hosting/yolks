FROM        --platform=$TARGETOS/$TARGETARCH node:24-bookworm-slim

LABEL       author="Chriss Quartz" maintainer="quartz@zentrahosting.xyz"

# Add container user and set stop signal
RUN         useradd -m -d /home/container container
STOPSIGNAL  SIGINT

# Update and install necessary packages
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
    libgtk-3-0 \
    lsb-release \
    apt-transport-https \ 
    wget 

RUN apt-get update \
    && apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/googlechrome-linux-keyring.gpg \
    && sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-khmeros fonts-kacst fonts-freefont-ttf libxss1 \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -d /home/container -m container -s /bin/bash

# Install npm packages globally
RUN         npm install --global npm@latest typescript ts-node @types/node

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        --chown=container:container ./../entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT  ["/usr/bin/tini", "-g", "--"]
CMD         ["/entrypoint.sh"]

