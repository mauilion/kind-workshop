FROM gcr.io/distroless/base:debug
ADD https://k8s.work/dfget /usr/bin/dfget
COPY dragonfly.conf /etc/dragonfly.conf
COPY runit.sh /runit.sh
ENTRYPOINT ["/busybox/sh", "/runit.sh"]
