FROM golang:1.13
RUN set +x && \
  apt update && \
  apt install rsync sudo --no-install-recommends -y && \
  rm -rf /var/lib/apt/lists/*

RUN GO111MODULE=on go get sigs.k8s.io/kind
RUN go get -d k8s.io/kubernetes || true
RUN cd src/k8s.io/kubernetes && git checkout v1.16.0
RUN tar -cvzf /srv/go.tgz /go/src/k8s.io/kubernetes /go/bin/kind
COPY serve.go /go/src/serve.go
RUN go build src/serve.go

CMD ["./serve","-d", "/srv"]
