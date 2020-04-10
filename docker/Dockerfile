FROM openjdk:11-jre-slim
MAINTAINER colincoleman

RUN useradd -r -u 200 -m -c "minecraft account" -d /home/minecraft -s /bin/false minecraft

ADD https://launchermeta.mojang.com/mc/game/version_manifest.json /home/minecraft/version_manifest.json

RUN apt-get update && \
    apt-get install -y \
      jq \
      wget && \
    LATESTVER=`cat /home/minecraft/version_manifest.json|jq -r .latest.release` &&\
    wget  -O /home/minecraft/versionfile.json `cat /home/minecraft/version_manifest.json | jq -r ".versions[] | select(.id==\"$LATESTVER\")|.url"` &&\
    DOWNLOADURL=`cat /home/minecraft/versionfile.json |jq -r '.downloads.server.url'` &&\
    wget -O /home/minecraft/server.jar $DOWNLOADURL &&\
    apt-get remove -y \
      jq \
      wget && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /home/minecraft/data && \
    chown minecraft:minecraft /home/minecraft/data &&

USER minecraft

COPY entrypoint.sh /home/minecraft/

ENTRYPOINT ["/home/minecraft/entrypoint.sh"]
