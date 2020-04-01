FROM alpine:latest
MAINTAINER Rahul Singhai <singrahu@gmail.com>
ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler
# Update and install all of the required packages.
# At the end, remove the apk cache
RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/* && \
    mkdir /usr/app && \
    addgroup -S app && adduser -S -G app app && \
    chown app.app /usr/app
# Change to non-root privilege
USER app
WORKDIR /usr/app
COPY . /usr/app
RUN bundle install
