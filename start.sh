#!/bin/bash
set -x
#vars
param=$1
source ./docker.ver





if [ "$param" == "rebuild" ]; then  
    echo "Delete previous Docker Image and Docker Container"
    images | grep {MY_DOCKER_IMAGE_NAME} | awk '{print $1}' | xargs docker rmi -f

    echo "Rebuilding Docker image --"${MY_DOCKER_IMAGE_NAME}"-- without cashe"
docker build --build-arg TOMCAT_VERSION=${TOMCAT_VERSION} --build-arg MY_DOCKER_IMAGE_FROM=${MY_DOCKER_IMAGE_FROM} --pull --no-cache -t ${MY_DOCKER_IMAGE_NAME} .
    
    echo "---Starting: "${MY_DOCKER_CONTAINER_NAME}"---"
docker run --rm -d --name ${MY_DOCKER_CONTAINER_NAME} -p ${MY_DOCKER_CONTAINER_PORT}:8080 ${MY_DOCKER_IMAGE_NAME}

# --rm automatically clean up the container and remove the file system when the container exits
# -d To start a container in detached mode


     

#   in case Im lazy and want listing all build arguments from file like variables  
#   docker build $(for i in `cat docker.ver`; do out+="--build-arg $i " ; done; echo $out;out="") --pull --no-cache -t ${MY_DOCKER_IMAGE_NAME} .
    else
    echo "Without rebulding Docker images if already exists"
docker build --build-arg TOMCAT_VERSION=${TOMCAT_VERSION} --build-arg MY_DOCKER_IMAGE_FROM=${MY_DOCKER_IMAGE_FROM} -t ${MY_DOCKER_IMAGE_NAME} .

    echo "---Starting: "${MY_DOCKER_CONTAINER_NAME}"---"
docker run --rm -d --name ${MY_DOCKER_CONTAINER_NAME} -p ${MY_DOCKER_CONTAINER_PORT}:8080 ${MY_DOCKER_IMAGE_NAME}    

fi
