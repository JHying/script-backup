#!/bin/bash

NAME="test"
ROOT_DIR="/home/usr/myfile/app"
PORT="8080"

#建立應用儲存資料夾
if [ -d $ROOT_DIR/$NAME ]; then
	echo "directory already exist."
else
	mkdir $ROOT_DIR/$NAME
fi

#移動至應用資料夾
cp ~/myfile/jenkins/workspace/$NAME/target/$NAME.jar $ROOT_DIR/$NAME
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
docker run -d --network dev-net --ip 172.17.0.3 --name $NAME -p ${PORT}:${PORT} -v $JAVA_HOME:/usr/local/java -v $MAVEN_HOME:/usr/local/maven -v $ROOT_DIR/logs:/usr/myfile/logs $NAME
echo "docker run finished."