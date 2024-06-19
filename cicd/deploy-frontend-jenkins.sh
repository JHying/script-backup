#!/bin/bash

NAME="front"
ROOT_DIR="/home/usr/myfile/app"
PORT="8888"

#建立應用儲存資料夾
if [ -d $ROOT_DIR/$NAME ]; then
	echo "directory already exist."
else
	mkdir $ROOT_DIR/$NAME
fi

#移動至應用資料夾
cp -a ~/myfile/jenkins/workspace/$NAME/. $ROOT_DIR/$NAME/
cd $ROOT_DIR/$NAME/

#刪除舊鏡像及容器
if [[ -n $(docker ps -a -q -f "name=^$NAME$") ]];then
	docker stop $NAME
	docker rm $NAME
	docker rmi $NAME
else
	echo "container not exist."
fi
#建立鏡像
docker build -t $NAME . --no-cache
echo "docker image build finished."
#執行容器
docker run -d --network dev-net --ip 172.17.0.3 --name $NAME --rm -it -p ${PORT}:80 $NAME
echo "docker run finished."
docker image prune -f