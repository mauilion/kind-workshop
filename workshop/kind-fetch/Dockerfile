FROM debian:buster-slim as docker
RUN apt update && apt -y install apt-transport-https ca-certificates curl gnupg2
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN echo "deb [arch=amd64] https://download.docker.com/linux/debian buster stable" > /etc/apt/sources.list.d/docker.list
RUN apt update && apt install docker-ce-cli
ADD https://github.com/coreos/quayctl/releases/download/v0.0.1/quayctl-linux-x64 /usr/bin/quayctl
RUN chmod +x /usr/bin/quayctl

FROM gcr.io/distroless/base:latest
COPY --from=docker /usr/bin/docker /usr/bin/docker
COPY --from=docker /usr/bin/quayctl /usr/bin/quayctl
COPY --from=docker /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /usr/lib/x86_64-linux-gnu/libstdc++.so.6
COPY --from=docker /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libgcc_s.so.1

CMD ["/usr/bin/quayctl", "docker", "torrent", "pull", "quay.io/kind-workshop/kind-cache:v1.16.0"]
