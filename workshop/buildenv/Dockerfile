FROM k8s.gcr.io/pause:3.1 as pause
FROM golang:1.13
COPY --from=pause /pause /pause
ENV HOME=/go/
ADD https://storage.googleapis.com/kubernetes-release/release/v1.16.2/bin/linux/amd64/kubectl /usr/local/bin/kubectl
ADD https://k8s.work/docker.list /etc/apt/sources.list.d/docker.list 
RUN chmod +x /usr/local/bin/kubectl
RUN set +x && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add && \
  apt update && \
  apt install docker-ce-cli vim rsync --no-install-recommends -y && \
  rm -rf /var/lib/apt/lists/*

CMD ["/pause"]
