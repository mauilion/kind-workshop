FROM golang:1.13 as build
RUN GO111MODULE=on go get sigs.k8s.io/kind
RUN go get -d k8s.io/kubernetes || true
RUN go get -u github.com/philippgille/serve
RUN cd src/k8s.io/kubernetes && git checkout v1.16.0
RUN tar -cvzf /srv/go.tgz /go/src/k8s.io/kubernetes /go/bin/kind

FROM gcr.io/distroless/base
COPY --from=build /go/bin/serve /bin/serve
COPY --from=build /srv/ /srv/

CMD ["/bin/serve","-d", "/srv"]
