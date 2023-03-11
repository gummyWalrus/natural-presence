#!/bin/bash
PROJECT_NAME=$1

if [[ -f "./Makefile" && -d "./app" ]]; then
    LANGUAGE=c
elif [[ -f "./app/main.bf" ]]; then
    LANGUAGE=befunge
elif [[ -f "./app/pom.xml" ]]; then
    LANGUAGE=java
elif [[ -f "requirements.txt" ]]; then
    LANGUAGE=python
elif [[ -f "package.json" ]]; then
    LANGUAGE=javascript
else
    echo "Not a Whanos compatible project. exiting"
    exit 1
fi

IMAGE_NAME=${DOCKER_USERNAME}/${PROJECT_NAME}


if [[ -f "Dockerfile" ]]; then
    docker build -t $IMAGE_NAME --no-cache --pull .
else
    echo "No Dockerfile found, using default"
    cp /root/images/${LANGUAGE}/Dockerfile.standalone ./Dockerfile
    docker build -t $IMAGE_NAME   --no-cache --pull .
fi

docker login --username ${DOCKER_USERNAME} --password ${DOCKER_PASSWORD} docker.io
docker push $IMAGE_NAME