#!/bin/bash

echo "third party reset start."

###env
export MYSQL_HOME=/home/user/mysql
export JAVA_HOME=/home/user/env/jdk-17.0.9+8
export PYTHON_HOME=/home/user/env/Python-3.12.1
export LOG_HOME=/home/user/app-logs
export REDIS_HOME=/home/user/redis

###portainer
# docker stop portainer
# docker rm portainer
# docker run -d -p 8001:8000 -p 9001:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /home/user/portainer/data:/data portainer/portainer-ce

###redis
docker stop redis
docker rm redis
docker run -p 6379:6379 --name redis --network test-env --ip 172.20.0.4 --restart always -v $REDIS_HOME/data:/data -v $REDIS_HOME/conf:/etc/redis/redis.conf -d redis redis-server /etc/redis/redis.conf

###mysql
docker stop mysql8
docker rm mysql8
docker run --name mysql8 --restart always -p 3306:3306 --network test-env --ip 172.20.0.2 -v $MYSQL_HOME:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=test​ -e MYSQL_DATABASE=testdb -d mysql:8
echo "docker reset finished."

echo "services reset start."
###api-gateway
cd /home/user/app-deploy/api-gateway/
source deploy-gateway.sh

###eureka
cd /home/user/app-deploy/eureka/
source deploy-eureka.sh
echo "services reset finished."
