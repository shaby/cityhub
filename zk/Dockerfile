FROM openjdk:8-alpine
MAINTAINER Yonghak An <neoshaby@gmail.com>

ARG MIRROR=https://archive.apache.org/dist/zookeeper
ARG VERSION=3.4.13
ARG BIN_VERSION=zookeeper-${VERSION}

LABEL name=${BIN_VERSION} version=${VERSION}

RUN apk add --no-cache wget bash tzdata \
  && cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
  && echo "Asia/Seoul" > /etc/timezone \
  && mkdir -p  /opt/zookeeper \
  && wget -q ${MIRROR}/${BIN_VERSION}/${BIN_VERSION}.tar.gz \
  && tar -zxvf ${BIN_VERSION}.tar.gz -C /opt/zookeeper --strip 1 \
  && cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg \
  && rm -rf ${BIN_VERSION}.tar.gz 

EXPOSE 2181 2888 3888

WORKDIR /opt/zookeeper

VOLUME ["/opt/zookeeper/conf", "/tmp/zookeeper"]
ADD ./zk/entrypoint.sh /opt/start.sh
RUN chmod +x /opt/start.sh

CMD ["/opt/start.sh"]
