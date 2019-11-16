#!/usr/bin/env bash
FILENAME=kind-cache.tar.gz
if grep -qs /tmp /proc/mounts ; then
  echo "beginning download"
  rm /tmp/${FILENAME}
  aria2c -s9 -x2 https://t{1..9}.k8s.work/${FILENAME} --console-log-level=error -o /tmp/${FILENAME}
  chmod +r /tmp/${FILENAME}
  echo "to load this run:"
  echo "docker load -i /tmp/${FILENAME}"
else
  echo "couldn't see /tmp dir mounted please run the command as:"
  echo "docker run --rm -v /tmp:/tmp quay.io/kind-fetch"
  echo "or curl -L kind.k8s.work/fetch | bash"
  exit 1
fi
