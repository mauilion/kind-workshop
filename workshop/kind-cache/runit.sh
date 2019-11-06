#!/usr/bin/env bash

if docker ps ; then
  find /images/ -type f | xargs -I {} docker image load -i {}
else
  echo "couldn't see docker socket. did you start this container with -v /var/run/docker.sock:/var/run/docker.sock"
  exit 1
fi
