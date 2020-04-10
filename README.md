# minecraft-docker
This docker image provides a size optimized vanilla Minecraft server

### Quickstart
```
docker run -d -p 25565:25565 -e EULA=true colincoleman/minecraft-docker:latest
```

### Parameters
#### EULA
To accept the Minecraft EULA (and have the server actually start) pass in the parameter EULA and set it to true `-e EULA=true`
#### JAVAOPTIONS
By default the server runs with `-Xmx1024M -Xms1024M` as suggested on the Minecraft Server instrutctions.
If you want to run a bigger server (or are a JVM Ninja with special experimental options skills) pass in
the parameter JAVAOPTIONS e.g `-e JAVAOPTIONS='-Xmx2G -Xms2G'`

### Persisting your world
By default the server's data folder is stored inside the container and will only last as long as the container.
If you wish to upgrade your Minecraft server without losing all your hard work spent finding all those diamonds
then the best way is to mount a volume to the container  e.g `-v $PWD/minecraft-data:/home/minecraft/data`

This also give you easy access to the items in the data folder to allow you to do things like change the MOTD

### Using Docker Compose
Instead of remembering and typing long chains of parameters and docker options you can create a docker-compose.yml file
(example [here](docker-compose.yml))
and simply run the command `docker-compose up` to bring up the server with a specified data folder and then use the
command `docker-compose down` to stop and get rid of the container.  Later when you wish to restart the server you can 
run `docker-compose up` again and the world persisted on your local volume will be attached to a new container running a
Minecraft server