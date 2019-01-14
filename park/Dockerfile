FROM openjdk:8-alpine
MAINTAINER Yonghak An <neoshaby@gmail.com>

ARG MIRROR=http://mirror.navercorp.com/apache/flume
ARG VERSION=1.9.0
ARG BIN_VERSION=apache-flume-${VERSION}
ARG GLIBC_VERSION=2.28-r0

LABEL name=${BIN_VERSION} version=${VERSION}


# Install required packages
RUN apk add --no-cache bash wget tzdata \
  && cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
  && echo "Asia/Seoul" > /etc/timezone \
  && mkdir -p /opt/flume \
  && mkdir -p /opt/flume/logs \
  && wget -q ${MIRROR}/${VERSION}/${BIN_VERSION}-bin.tar.gz \
  && tar -zxvf ${BIN_VERSION}-bin.tar.gz -C /opt/flume --strip 1 \
  && rm -rf ${BIN_VERSION}-bin.tar.gz \
  && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
  && apk add --no-cache --allow-untrusted glibc-${GLIBC_VERSION}.apk \
  && rm glibc-${GLIBC_VERSION}.apk

ADD ./flume/InstallCert.java /InstallCert.java

RUN javac InstallCert.java \
  && echo "1" | java -cp ./ InstallCert data.kma.go.kr \
  && keytool -exportcert -keystore jssecacerts -storepass changeit -file output.cert -alias data.kma.go.kr-1 \
  && echo "yes" | keytool -importcert -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit -file output.cert -alias data.kma.go.kr-1

WORKDIR /opt/flume


ADD ./flume/entrypoint.sh /opt/start.sh
RUN chmod +x /opt/start.sh

CMD ["/opt/start.sh"]
