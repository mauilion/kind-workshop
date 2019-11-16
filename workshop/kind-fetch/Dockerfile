FROM bash
RUN apk add --update aria2 && rm -rf /var/cache/apk/
COPY runit.sh /runit.sh
ENTRYPOINT ["/runit.sh"]
