FROM 	ghcr.io/zentra-hosting/yolks:java_22

LABEL author="Chriss Quartz" maintainer="quartz@zentrahosting.xyz"

USER root

RUN apt-get update && apt-get install -y tini iproute2 iputils-ping

WORKDIR /home/container

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN chown -R container:container /home/container /entrypoint.sh

STOPSIGNAL SIGINT

USER container

ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD ["/entrypoint.sh"]