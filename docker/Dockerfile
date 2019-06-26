FROM azul/zulu-openjdk-alpine:8u212-jre
MAINTAINER colincoleman

RUN mkdir -p /home/minecraft/data

COPY entrypoint.sh /home/minecraft/

RUN apk update &&\
  apk add jq

RUN cd /home/minecraft &&\
  wget https://launchermeta.mojang.com/mc/game/version_manifest.json &&\
  LATESTVER=`cat version_manifest.json|jq -r .latest.release` &&\
  wget  -O versionfile.json `cat version_manifest.json | jq -r ".versions[] | select(.id==\"$LATESTVER\")|.url"` &&\
  DOWNLOADURL=`cat versionfile.json |jq -r '.downloads.server.url'` &&\
  wget $DOWNLOADURL &&\
  echo "done"

ENTRYPOINT ["/home/minecraft/entrypoint.sh"]
