docker run --rm -d --name buildenv --hostname buildenv -v /var/run/docker.sock:/var/run/docker.sock -v /tmp:/tmp quay.io/kind-workshop/kind-buildenv:1.13

