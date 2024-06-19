#!/bin/bash

NAME="java-service"
PORT="8081"
ROOT_DIR="/home/user/app-deploy"
if [[ -n $(docker ps -a -q -f "name=^$NAME$") ]];then
	docker stop $NAME
	docker rm $NAME
	docker rmi $NAME
else
	echo "container not exist."
fi
docker build -t $NAME . --no-cache
echo "docker image build finished."
#執行容器
docker run -d --network test-env --ip 172.20.1.2 --name $NAME --restart always -p ${PORT}:${PORT} -v $JAVA_HOME:/usr/local/java -v $LOG_HOME:/usr/puhui/logs -v /home/user/uploadFile:/usr/puhui/upload -v /home/user/downloadFile:/usr/puhui/download $NAME 
echo "docker run finished."

#上傳至artifact registry
REGISTRY_PATH="asia-east1-docker.pkg.dev/PROJECT/test-docker-registry"
docker tag $NAME:latest $REGISTRY_PATH/$NAME:latest
docker push $REGISTRY_PATH/$NAME:latest
echo "docker image push finished."

docker system prune -af
