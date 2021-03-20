FROM mysql:latest

COPY buyme.sql ./docker-entrypoint-initdb.d

ENV MYSQL_ROOT_PASSWORD="cs336project"
ENV MYSQL_DATABASE="buyme"

EXPOSE 3306