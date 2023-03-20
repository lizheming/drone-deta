FROM alpine

LABEL maintainer="lizheming <i@imnerd.org>"
LABEL org.label-schema.version=latest
LABEL org.label-schema.vcs-url="https://github.com/lizheming/drone-deta"
LABEL org.label-schema.name="drone-deta"
LABEL org.label-schema.description="Release to deta space with Drone CI"
LABEL org.label-schema.vendor="lizheming"
LABEL org.label-schema.schema-version="2.0"

RUN apk add curl --no-cache && \
  curl -fsSL https://get.deta.dev/space-cli.sh | sh && \
  apk del curl

ADD script.sh /bin/
RUN chmod +x /bin/script.sh

ENTRYPOINT /bin/script.sh
