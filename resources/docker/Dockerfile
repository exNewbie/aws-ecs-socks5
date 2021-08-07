# syntax=docker/dockerfile:1.3-labs

#docker run -d -p 1080:1080 --restart unless-stopped -e PROXY_USER=vait -e PROXY_PASSWORD=Id0ntkn0w -e PROXY_SERVER=0.0.0.0:1080 xkuma/socks5
#"/bin/scoks5"
#FROM xkuma/socks5

FROM  amazonlinux:latest AS build

ADD aws /media

WORKDIR /media

RUN ./install

######################################################################################################################

FROM amazonlinux:latest

# # Copy over the binaries and libraries
COPY --from=build /usr/local/aws-cli /usr/local/aws-cli
RUN ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/local/bin/aws

ADD ./entry-point.sh /bin/entry-point.sh

ENV AWS_DEFAULT_REGION=ap-southeast-2

WORKDIR /opt

ENTRYPOINT ["/bin/entry-point.sh"]
