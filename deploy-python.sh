#!/bin/bash

NAME="python-service"
PORT="8088"
ROOT_DIR="/home/user/app-deploy"
source /etc/profile
DOCKER_NETWORK="test-env"
DOCKER_IP="172.20.1.3"

# Check if container exists
if [[ -n $(docker ps -a -q -f "name=^$NAME$") ]]; then
    docker stop $NAME
    docker rm $NAME
    docker rmi $NAME
else
    echo "Container not exist."
fi

# Build the Docker image
docker build -t $NAME . --no-cache
echo "Docker image build finished."

# Run container
docker run -d --network $DOCKER_NETWORK --ip $DOCKER_IP --name $NAME --restart always \
-p ${PORT}:${PORT} \
-v /home/user/uploadFile:/usr/puhui/upload \
-v /home/user/downloadFile:/usr/puhui/download \
$NAME
# $LOG_HOME:/usr/puhui/logs 
echo "Docker run finished."

# Clean up Docker system
docker system prune -af
