FROM amazoncorretto:21-alpine
MAINTAINER colincoleman

RUN addgroup minecraft && adduser -h /home/minecraft -u 200 -s /bin/false -G minecraft -S minecraft

ADD https://launchermeta.mojang.com/mc/game/version_manifest.json /home/minecraft/version_manifest.json

RUN apk add jq && \
    LATESTVER=`cat /home/minecraft/version_manifest.json|jq -r .latest.release` &&\
    wget  -O /home/minecraft/versionfile.json `cat /home/minecraft/version_manifest.json | jq -r ".versions[] | select(.id==\"$LATESTVER\")|.url"` &&\
    DOWNLOADURL=`cat /home/minecraft/versionfile.json |jq -r '.downloads.server.url'` &&\
    wget -O /home/minecraft/server.jar $DOWNLOADURL &&\
    mkdir /home/minecraft/data && \
    chown minecraft:minecraft /home/minecraft/data

USER minecraft

COPY entrypoint.sh /home/minecraft/

ENTRYPOINT ["/home/minecraft/entrypoint.sh"]
