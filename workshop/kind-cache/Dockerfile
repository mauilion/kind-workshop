FROM bash
WORKDIR /images
RUN apk add --update docker-cli && rm -rf /var/cache/apk/
COPY tars/mauilion/kind-buildenv:latest mauilion/kind-buildenv:latest
COPY tars/k8s.gcr.io/etcd:3.3.15-0 k8s.gcr.io/etcd:3.3.15-0
COPY tars/k8s.gcr.io/kube-cross:v1.12.9-1 k8s.gcr.io/kube-cross:v1.12.9-1
COPY tars/k8s.gcr.io/coredns:1.6.2 k8s.gcr.io/coredns:1.6.2
COPY tars/kindest/kindnetd:0.5.0 kindest/kindnetd:0.5.0
COPY tars/k8s.gcr.io/debian-iptables-amd64:v11.0.2 k8s.gcr.io/debian-iptables-amd64:v11.0.2
COPY tars/k8s.gcr.io/debian-base-amd64:v1.0.0 k8s.gcr.io/debian-base-amd64:v1.0.0
COPY tars/k8s.gcr.io/pause:3.1 k8s.gcr.io/pause:3.1
COPY images /root/images
COPY runit.sh /root/runit.sh
CMD ["/root/runit.sh"]
