# Base Java version must be >= the Minecraft server's required JRE. Check via:
#   curl -s <version manifest url for the target id> | jq .javaVersion.majorVersion
# Current `latest` (26.2) needs Java 25; bump this if a future MC release needs more.
FROM amazoncorretto:25-alpine
LABEL org.opencontainers.image.authors="colincoleman"

RUN addgroup minecraft && adduser -h /home/minecraft -u 200 -s /bin/false -G minecraft -S minecraft

# Which Minecraft version to install. "latest" resolves the newest release
# from Mojang's manifest at build time; or pin an explicit id e.g. "26.2".
ARG MINECRAFT_VERSION=latest

ADD https://launchermeta.mojang.com/mc/game/version_manifest.json /home/minecraft/version_manifest.json

RUN apk add --no-cache jq && \
    if [ "$MINECRAFT_VERSION" = "latest" ]; then \
        WANTED=`jq -r .latest.release /home/minecraft/version_manifest.json`; \
    else \
        WANTED="$MINECRAFT_VERSION"; \
    fi && \
    echo "Installing Minecraft server version: $WANTED" && \
    VERSIONURL=`jq -r ".versions[] | select(.id==\"$WANTED\") | .url" /home/minecraft/version_manifest.json` && \
    if [ -z "$VERSIONURL" ]; then echo "Version $WANTED not found in manifest" >&2; exit 1; fi && \
    wget -O /home/minecraft/versionfile.json "$VERSIONURL" && \
    DOWNLOADURL=`jq -r '.downloads.server.url' /home/minecraft/versionfile.json` && \
    wget -O /home/minecraft/server.jar "$DOWNLOADURL" && \
    mkdir /home/minecraft/data && \
    chown minecraft:minecraft /home/minecraft/data

USER minecraft

COPY entrypoint.sh /home/minecraft/

ENTRYPOINT ["/home/minecraft/entrypoint.sh"]
