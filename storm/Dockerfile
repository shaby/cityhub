FROM baqend/java:8u171
MAINTAINER Yonghak An <neoshaby@gmail.com>

# The used storm version can also be supplied like this with the build command like this:
ARG MIRROR=http://mirror.apache-kr.org/storm
ARG VERSION=1.2.2
ARG BIN_VERSION=apache-storm-${VERSION}

LABEL name=${BIN_VERSION} version=${VERSION}

# Install and set everything up
RUN \
   alias python=python3 \
  && apt-get update -y \
  && apt-get install -y netcat python locales tzdata \
  && cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
  && echo "Asia/Seoul" > /etc/timezone \
  && locale-gen ko_KR.UTF-8 \
  && mkdir -p /opt/storm \
  && wget -q ${MIRROR}/${BIN_VERSION}/${BIN_VERSION}.tar.gz \
  && tar -zxvf ${BIN_VERSION}.tar.gz -C /opt/storm --strip 1 \
  && rm ${BIN_VERSION}.tar.gz \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

ENV LC_ALL ko_KR.UTF-8

WORKDIR /opt/storm

# supervisor: worker ports
EXPOSE 6700 6701 6702 6703
# logviewer
EXPOSE 8000
# DRPC and remote deployment
EXPOSE 6627 3772 3773


# add startup script
ADD ./storm/cluster.xml log4j2/cluster.xml
ADD ./storm/worker.xml log4j2/worker.xml
ADD ./storm/extlib /opt/storm/extlib
ADD ./storm/entrypoint.sh /opt/start.sh
RUN chmod +x /opt/start.sh

ENTRYPOINT ["/opt/start.sh"]
