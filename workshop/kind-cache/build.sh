#!/usr/bin/env bash

set -xe
echo "prepulling images"
cat images | xargs -I {} docker pull {}

mkdir -p tars/ tars/quay.io/mauilion tars/k8s.gcr.io tars/kindest
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
docker build -f Dockerfile -t quay.io/mauilion/kind-cache:unflat .
container_id=$(docker run -d quay.io/mauilion/kind-cache:unflat /bin/true)
docker export $container_id | docker import - quay.io/mauilion/kind-cache:latest
