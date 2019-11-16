#!/usr/bin/env bash

if docker ps ; then
  find /images/ -type f | xargs -I {} docker image load -i {}
  docker tag sha256:df54d1ad3310712c82314945afee172e0de2bc8365072edd1b3e2ffc797b7cec kindest/base
else
  echo "couldn't see docker socket. did you start this container with -v /var/run/docker.sock:/var/run/docker.sock"
  exit 1
fi
