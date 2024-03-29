# FROM oracle/graalvm-ce:20.2.0-java8
FROM ghcr.io/graalvm/graalvm-ce:java8-20.3.3
MAINTAINER Marthen Luther <marthen.luther@oracle.com>
ENV MYSQL_HOST=mysql \
    DO_NOT_INITIALIZE=never \
    ORACLE_HOST=oracle \
    VERSION=v0.11
COPY target/petclinic-jpa .
EXPOSE 8080
ENTRYPOINT ["/petclinic-jpa"]
