#!/bin/sh
if [ ! -f /home/minecraft/data/eula.txt ]
then
    echo "eula=true" > /home/minecraft/data/eula.txt
fi
cd /home/minecraft/data
java -XX:+UseG1GC -Xmx4G -Xms4G -Dsun.rmi.dgc.server.gcInterval=2147483646 -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=32M -jar /home/minecraft/server.jar nogui