FROM alpine:latest
MAINTAINER "Dave Walker <email@daviey.com>"

ENV TERRAFORM_VERSION=0.10.8
ENV TERRAFORM_SHA256SUM=b786c0cf936e24145fad632efd0fe48c831558cc9e43c071fffd93f35e3150db

RUN apk upgrade libssl1.0 --update-cache && \
    apk add git wget curl ca-certificates make bash findutils && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    echo "${TERRAFORM_SHA256SUM}  terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    sha256sum -cs terraform_${TERRAFORM_VERSION}_SHA256SUMS && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /bin && \
    rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/bin/terraform"]
