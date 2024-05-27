FROM tomcat:10.1-jdk21
EXPOSE 8080
RUN apt-get update && apt-get install -y wget
WORKDIR /usr/local/tomcat/webapps/
RUN wget http://tomcat.apache.org/tomcat-8.5-doc/appdev/sample/sample.war
