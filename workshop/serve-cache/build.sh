#!/usr/bin/env bash
IMAGE_NAME=quay.io/kind-workshop/serve-cache
IMAGE_TAG=latest
set -xe

docker build -f Dockerfile -t ${IMAGE_NAME}:unflat .
flat_id=$(docker run -d ${IMAGE_NAME}:unflat /bin/true)

docker export ${flat_id} | docker import - ${IMAGE_NAME}:${IMAGE_TAG}

docker push ${IMAGE_NAME}:${IMAGE_TAG}

