FROM tomcat:8-jre11-slim

RUN apt-get update && apt-get install -y mariadb-server

ADD build/libs/cs336-buyme.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD [ "catalina.sh", "run" ]