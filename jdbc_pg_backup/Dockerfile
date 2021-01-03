FROM maven:3-openjdk-11

ENV JDBC_PG_BACKUP_VERSION=daab977410db0f6b8fcfde4af85a4869323754eb
ENV JDBC_PG_BACKUP_SHA256=8bf3ba990ab0a79374e37a9f087091424c1039ee4bb0d41158137eb21ac929c7

WORKDIR /usr/src

RUN wget https://github.com/tig100/JdbcPgBackup/archive/$JDBC_PG_BACKUP_VERSION.zip \
    && echo "$JDBC_PG_BACKUP_SHA256 $JDBC_PG_BACKUP_VERSION.zip" | sha256sum -c \
    && unzip $JDBC_PG_BACKUP_VERSION.zip \
    && rm $JDBC_PG_BACKUP_VERSION.zip \
    && mv JdbcPgBackup-$JDBC_PG_BACKUP_VERSION JdbcPgBackup


WORKDIR /usr/src/JdbcPgBackup

COPY pom.xml .

RUN mkdir -p src/main/java \
    && mv jdbcpgbackup src/main/java \
    && mvn package

COPY jdbc_pg_backup.sh .

CMD ["./jdbc_pg_backup.sh"]
