FROM alpine:latest
MAINTAINER "Dave Walker <email@daviey.com>"

ENV TERRAFORM_VERSION=0.10.6
ENV TERRAFORM_SHA256SUM=fbb4c37d91ee34aff5464df509367ab71a90272b7fab0fbd1893b367341d6e23

RUN apk upgrade libssl1.0 --update-cache && \
    apk add git wget curl ca-certificates make bash findutils && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/bin/terraform"]
