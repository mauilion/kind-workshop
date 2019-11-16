#!/usr/bin/env bash
IMAGE_NAME=quay.io/kind-workshop/kind-cache
IMAGE_TAG=latest
set -xe
echo "prepulling images"
cat images | xargs -I {} docker pull {}

mkdir -p tars/ tars/quay.io/kind-workshop tars/k8s.gcr.io tars/kindest
echo "exporting images"

cat images | xargs -I {} docker image save {} -o tars/{}
echo "building Dockerfile"
echo "FROM bash" > Dockerfile
echo "WORKDIR /images" >> Dockerfile
echo "RUN apk add --update docker-cli && rm -rf /var/cache/apk/" >> Dockerfile
cat images | xargs -I {} echo "COPY tars/{} {}" >> Dockerfile
echo "COPY images /root/images" >> Dockerfile
echo "COPY runit.sh /root/runit.sh" >> Dockerfile
echo 'CMD ["/root/runit.sh"]' >> Dockerfile

echo "building layered image"
docker build -f Dockerfile -t ${IMAGE_NAME}:unflat .
flat_id=$(docker run -d ${IMAGE_NAME}:unflat /bin/true)
docker export ${flat_id} | docker import - ${IMAGE_NAME}:flat
echo "FROM ${IMAGE_NAME}:flat" > Dockerfile.flat
echo 'CMD ["/root/runit.sh"]' >> Dockerfile.flat
docker build -f Dockerfile.flat -t ${IMAGE_NAME}:${IMAGE_TAG} .

rm Dockerfile*
