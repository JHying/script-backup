#依賴的父映像檔 
FROM ubuntu:20.04 as builder
#作者 
MAINTAINER yinghan
WORKDIR /usr/myfile
#docker run 時須加上 -v $JAVA_HOME:/usr/local/java -v $MAVEN_HOME:/usr/local/maven 掛載本地 java, maven 至容器中 
ENV JAVA_HOME=/usr/local/java \
    JRE_HOME=${JAVA_HOME}/jre \ 
    MAVEN_HOME=/usr/local/maven \
    MAVEN_CONFIG=/root/.m2
#timezone
ENV TZ=Asia/Taipei \
    DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/*
#將 jar 包新增到父映像檔中（並重新取名） 
ADD test.jar test.jar
#容器宣告的埠
EXPOSE 8080
#容器啟動之後執行的命令（執行 jar 檔） 
ENTRYPOINT ["/usr/local/java/bin/java","-jar","test.jar"]