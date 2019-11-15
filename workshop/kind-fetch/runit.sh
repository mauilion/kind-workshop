#!/busybox/sh

if grep -qs /image /proc/mounts ; then
  chmod +x /usr/bin/dfget
  dfget --showbar -u https://u.nu/kind-cache --notbs --console -o /image/kind-cache
  chmod +r /image/kind-cache
  echo "to load this run:"
  echo "docker load -i /tmp/kind-cache"
else
  echo "couldn't see /image mounted please run the command as:"
  echo "docker run --rm -v /tmp:/image quay.io/kind-fetch"
  exit 1
fi
