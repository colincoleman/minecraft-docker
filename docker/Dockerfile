FROM azul/zulu-openjdk-alpine:8u212-jre
MAINTAINER colincoleman

COPY entrypoint.sh ./

RUN apk update &&\
  apk add jq

RUN mkdir -p /home/minecraft/data &&\
  cd /home/minecraft &&\
  wget https://launchermeta.mojang.com/mc/game/version_manifest.json &&\
  LATESTVER=`cat version_manifest.json|jq -r .latest.release` &&\
  wget  -O versionfile.json `cat version_manifest.json | jq -r ".versions[] | select(.id==\"$LATESTVER\")|.url"` &&\
  DOWNLOADURL=`cat versionfile.json |jq -r '.downloads.server.url'` &&\
  wget $DOWNLOADURL &&\
  echo "done"

ENTRYPOINT ["./entrypoint.sh"]
