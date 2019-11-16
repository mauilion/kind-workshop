#!/usr/bin/env bash
IMAGE_NAME=quay.io/kind-workshop/kind-fetch
IMAGE_TAG=latest
set -xe

echo "FROM bash" > Dockerfile
echo "RUN apk add --update aria2 && rm -rf /var/cache/apk/" >> Dockerfile
echo "COPY runit.sh /runit.sh" >> Dockerfile
echo 'CMD ["/runit.sh"]' >> Dockerfile

docker build -f Dockerfile -t ${IMAGE_NAME}:unflat .
flat_id=$(docker run -d ${IMAGE_NAME}:unflat /bin/true)

docker export ${flat_id} | docker import - ${IMAGE_NAME}:flat

echo "FROM ${IMAGE_NAME}:flat" > Dockerfile.flat
echo 'CMD ["/runit.sh"]' >> Dockerfile.flat

docker build -f Dockerfile.flat -t ${IMAGE_NAME}:${IMAGE_TAG} .

docker rmi -f ${IMAGE_NAME}:unflat ${IMAGE_NAME}:flat

docker push ${IMAGE_NAME}:${IMAGE_TAG}

rm Dockerfile*
