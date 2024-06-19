#!/bin/bash

FILE_NAME="frontend-20240528.tar"
IMAGE_NAME="frontend:latest"
NAME="frontend"
PORT="80"
ROOT_DIR="/home/user/app-deploy"
if [[ -n $(docker ps -a -q -f "name=^$NAME$") ]];then
	docker stop $NAME
	docker rm $NAME
	docker rmi $IMAGE_NAME
else
	echo "container not exist."
fi
#建立容器
docker load < $FILE_NAME
echo "docker image build finished."
#執行容器
docker run -d --network test-env --ip 172.20.1.0 --name $NAME --restart always -p ${PORT}:${PORT} $IMAGE_NAME
echo "docker run finished."

#上傳至 gcp artifact registry
REGISTRY_PATH="asia-east1-docker.pkg.dev/PROJECT/test-docker-registry"
docker tag $IMAGE_NAME $REGISTRY_PATH/$NAME:latest
docker push $REGISTRY_PATH/$NAME:latest
echo "docker image push finished."

docker system prune -af