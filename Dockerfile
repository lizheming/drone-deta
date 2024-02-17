FROM golang:alpine AS build

WORKDIR /app
RUN apk add git --no-cache && \
  git config --global http.version HTTP/1.1 && \
  git clone https://github.com/deta/space-cli.git --depth=1 && \
  cd space-cli && \
  go build .

FROM alpine

LABEL maintainer="lizheming <i@imnerd.org>"
LABEL org.label-schema.version=latest
LABEL org.label-schema.vcs-url="https://github.com/lizheming/drone-deta"
LABEL org.label-schema.name="drone-deta"
LABEL org.label-schema.description="Release to deta space with Drone CI"
LABEL org.label-schema.vendor="lizheming"
LABEL org.label-schema.schema-version="2.0"

# RUN apk add curl --no-cache
# RUN curl -fsSL https://get.deta.dev/space-cli.sh | sh
# RUN apk del curl
COPY --from=build /app/space-cli/space /root/.detaspace/bin/space

RUN /root/.detaspace/bin/space --help

ADD script.sh /bin/
RUN chmod +x /bin/script.sh

ENTRYPOINT /bin/script.sh
