FROM k8s.gcr.io/pause:3.1 as pause
FROM golang:1.13 as kind
RUN GO111MODULE=on go get sigs.k8s.io/kind@v0.5.1

FROM golang:1.13
COPY --from=pause /pause /pause
COPY --from=kind /go/bin/kind /go/bin/kind
ENV HOME=/go/
ADD https://storage.googleapis.com/kubernetes-release/release/v1.16.2/bin/linux/amd64/kubectl /usr/local/bin/kubectl
ADD https://k8s.work/docker.list /etc/apt/sources.list.d/docker.list 

RUN set +x && \
  chmod +x /usr/local/bin/kubectl && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add && \
  apt update && \
  apt install docker-ce-cli vim rsync --no-install-recommends -y && \
  rm -rf /var/lib/apt/lists/*

RUN set +x && \
  mkdir -p /go/src/k8s.io/kubernetes && \
  cd /go/src/k8s.io/kubernetes && \
  git init && \
  git remote add origin https://github.com/kubernetes/kubernetes.git && \
  git fetch --depth 2 origin 97c4edaa4f28f914db45766330b6db8953720588 && \
  git checkout 2adaa5d64d897a980a80bc9759a001711f2bc360 && \
  git tag v1.16.0-alpha.1 && \
  git checkout -b master && \
  git checkout 97c4edaa4f28f914db45766330b6db8953720588 -b fix && \
  git checkout master

COPY kind-config.yaml /go/kind-config.yaml

CMD ["/pause"]
