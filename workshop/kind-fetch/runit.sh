#!/usr/bin/env bash
if grep -qs /image /proc/mounts ; then
  aria2c -s9 -x2 https://t{1..9}.k8s.work/kind-cache.tar.gz -o /image/kind-cache.tar.gz | grep -v WARN
  chmod +r /image/kind-cache.tar.gz
  echo "to load this run:"
  echo "docker load -i /tmp/kind-cache.tar.gz"
else
  echo "couldn't see /image mounted please run the command as:"
  echo "docker run --rm -v /tmp:/image quay.io/kind-fetch"
  exit 1
fi
