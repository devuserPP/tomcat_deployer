#!/bin/bash
set -x
#vars
param=$1
source ./docker.ver



#./start rebuild
#delete old docker image and docker container, build new image and start new container based on new image

if [ "$param" == "rebuild" ]; then  
    echo "Delete previous Docker Image and Docker Container"
    images | grep {MY_DOCKER_IMAGE_NAME} | awk '{print $1}' | xargs docker rmi -f

    echo "Rebuilding Docker image --"${MY_DOCKER_IMAGE_NAME}"-- without cashe"
    docker build --build-arg TOMCAT_VERSION=${TOMCAT_VERSION} --build-arg MY_DOCKER_IMAGE_FROM=${MY_DOCKER_IMAGE_FROM} --pull --no-cache -t ${MY_DOCKER_IMAGE_NAME} .
    
    echo "---Starting: "${MY_DOCKER_CONTAINER_NAME}"---"
    docker run --rm -d --name ${MY_DOCKER_CONTAINER_NAME} -p ${MY_DOCKER_CONTAINER_PORT}:8080 ${MY_DOCKER_IMAGE_NAME}

#Docker flags
# --rm automatically clean up the container and remove the file system when the container exits
# -d To start a container in detached mode


     


#./start.sh 
# create new image if does not exists and recreate docker container 

    else
    echo "Without rebulding Docker images if already exists"
docker build --build-arg TOMCAT_VERSION=${TOMCAT_VERSION} --build-arg MY_DOCKER_IMAGE_FROM=${MY_DOCKER_IMAGE_FROM} -t ${MY_DOCKER_IMAGE_NAME} .
fi
    echo "---Starting: "${MY_DOCKER_CONTAINER_NAME}"---"

 if [ "$(docker inspect -f '{{.State.Running}}' ${MY_DOCKER_CONTAINER_NAME} 2>/dev/null)" = "true" ]; then 
 echo ${MY_DOCKER_CONTAINER_NAME}" - already running"
 echo "Im trying to kill - "${MY_DOCKER_CONTAINER_NAME}
 docker rm ${MY_DOCKER_CONTAINER_NAME} -f


else
docker run --rm -d --name ${MY_DOCKER_CONTAINER_NAME} -p ${MY_DOCKER_CONTAINER_PORT}:8080 ${MY_DOCKER_IMAGE_NAME}    

fi

#for tesint purposes
#   if I want listing all build arguments from file like variables and check i.e. correct url for TOMCAT
#   docker build $(for i in `cat docker.ver`; do out+="--build-arg $i " ; done; echo $out;out="") --pull --no-cache -t ${MY_DOCKER_IMAGE_NAME} .
