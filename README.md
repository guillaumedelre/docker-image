container-image
====================

FMM Dockerfile repository

```
# build from image name:tag
docker build -t containerdockerdev_app:latest .

# remove from containers
docker rm containerdockerdev_app_0

# run from image with container name
docker run -d --name containerdockerdev_app_0 containerdockerdev_app:latest

# run from image with container name, interactive mode with sheel and entrypoint bypass
docker run -it --entrypoint=/bin/bash containerdockerdev_app:latest -i

# get the logs
docker logs containerdockerdev_app_0

# attach to running container with a shell
docker exec -it containerdockerdev_app_0 bash

# tag image to be pushable to private registry
docker tag containerdockerdev_app 192.168.56.23:5000/bencom/containerdockerdev_app

# push tagged image to registry
docker push 192.168.56.23:5000/bencom/containerdockerdev_app
```

