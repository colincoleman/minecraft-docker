#!/bin/sh
if [ ! -f /home/minecraft/data/eula.txt ]
then
    echo "eula=$EULA" > /home/minecraft/data/eula.txt
fi
cd /home/minecraft/data
if [ -ne $JAVAPARAMS ]
then
    JAVAPARAMS='-Xmx1024M -Xms1024M'
fi
java $JAVAPARAMS -jar /home/minecraft/server.jar nogui