# syntax=docker/dockerfile:1.3-labs

FROM  amazonlinux:latest AS build

ADD aws /media

WORKDIR /media

RUN ./install

######################################################################################################################

FROM amazonlinux:latest

ARG AWS_REGION=ap-southeast-2

# # Copy over the binaries and libraries
COPY --from=build /usr/local/aws-cli /usr/local/aws-cli
RUN ln -s /usr/local/aws-cli/v2/current/bin/aws /usr/local/bin/aws

ADD ./entry-point.sh /bin/entry-point.sh

ENV AWS_DEFAULT_REGION=$AWS_REGION

WORKDIR /opt

ENTRYPOINT ["/bin/entry-point.sh"]
