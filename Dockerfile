FROM oracle/graalvm-ce:20.2.0-java8
MAINTAINER Marthen Luther <marthen.luther@oracle.com>
ENV MYSQL_HOST=mysql \
    DO_NOT_INITIALIZE=never \
    ORACLE_HOST=oracle \
    VERSION=v0.8
COPY target/petclinic-jpa .
EXPOSE 8080
ENTRYPOINT ["/petclinic-jpa"]
