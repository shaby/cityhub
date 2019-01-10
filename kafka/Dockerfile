FROM openjdk:8-alpine
MAINTAINER Yonghak An <neoshaby@gmail.com>

ARG MIRROR=http://apache.mirror.cdnetworks.com/kafka
ARG VERSION=2.1.0
ARG BIN_VERSION=kafka_2.12-${VERSION}
ARG GLIBC_VERSION=2.28-r0

LABEL name=${BIN_VERSION} version=${VERSION}

# Install required packages
RUN apk add --no-cache bash wget tzdata \
  && cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
  && echo "Asia/Seoul" > /etc/timezone \
  && mkdir -p /opt/kafka \
  && mkdir -p /data \
  && mkdir -p /logs \
  && wget -q ${MIRROR}/${VERSION}/${BIN_VERSION}.tgz \
  && tar -zxvf ${BIN_VERSION}.tgz -C /opt/kafka --strip 1 \
  && rm -rf ${BIN_VERSION}.tgz \
  && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
  && apk add --no-cache --allow-untrusted glibc-${GLIBC_VERSION}.apk \
  && rm glibc-${GLIBC_VERSION}.apk
  
WORKDIR /opt/kafka

ADD ./kafka/config /opt/kafka/config

add ./kafka/entrypoint.sh /opt/start.sh
RUN chmod +x /opt/start.sh
CMD  ["/opt/start.sh"]
#ENTRYPOINT ['/bin/bash']