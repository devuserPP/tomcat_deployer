
# check if this version still exists
# https://downloads.apache.org/tomcat/tomcat-8/v8.5.53/bin/apache-tomcat-8.5.53.tar.gz
# if not update TOMCAT_VERSION in file ./docker.ver


ARG MY_DOCKER_IMAGE_FROM

FROM ${MY_DOCKER_IMAGE_FROM}

ARG TOMCAT_VERSION


RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat


RUN curl -o apache-tomcat-${TOMCAT_VERSION}.tar.gz https://downloads.apache.org/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz 
RUN tar xvfz apache-tomcat-${TOMCAT_VERSION}.tar.gz
RUN mv apache-tomcat-${TOMCAT_VERSION}/* /opt/tomcat/.

#cleaning
RUN rm -df apache-tomcat-${TOMCAT_VERSION}/
RUN rm -f apache-tomcat-${TOMCAT_VERSION}.tar.gz

RUN yum -y install java
RUN java -version

#files with was extension in folder ./target will be deploy inside container 
copy ./target/*.war /opt/tomcat/webapps/


#setting user TOMCAT_VERSION and password 
ADD ./tomcat-conf/tomcat-users.xml /opt/tomcat/conf/

#allow to connect from remote host
ADD ./tomcat-conf/context.xml /opt/tomcat/webapps/manager/META-INF/context.xml

WORKDIR /opt/tomcat/webapps

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]
