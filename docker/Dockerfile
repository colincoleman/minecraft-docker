FROM azul/zulu-openjdk-alpine:8u212-jre
MAINTAINER colincoleman

RUN mkdir -p /home/minecraft/data

COPY entrypoint.sh /home/minecraft/

RUN apk update &&\
  apk add jq

ADD https://launchermeta.mojang.com/mc/game/version_manifest.json /home/minecraft/version_manifest.json

RUN LATESTVER=`cat /home/minecraft/version_manifest.json|jq -r .latest.release` &&\
  wget  -O /home/minecraft/versionfile.json `cat /home/minecraft/version_manifest.json | jq -r ".versions[] | select(.id==\"$LATESTVER\")|.url"` &&\
  DOWNLOADURL=`cat /home/minecraft/versionfile.json |jq -r '.downloads.server.url'` &&\
  wget -O /home/minecraft/server.jar $DOWNLOADURL &&\
  echo "done"

ENTRYPOINT ["/home/minecraft/entrypoint.sh"]
