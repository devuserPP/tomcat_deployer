FROM centos
arg TOMCAT_VERSION=8.5.46


RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat

#https://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.46/bin/apache-tomcat-8.5.46-deployer.tar.gz
RUN curl -o apache-tomcat-${TOMCAT_VERSION}.tar.gz https://www-eu.apache.org/dist/tomcat/tomcat-8/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz

RUN tar xvfz apache-tomcat-${TOMCAT_VERSION}.tar.gz
RUN mv apache-tomcat-${TOMCAT_VERSION}/* /opt/tomcat/.

#cleaning
RUN rm -df apache-tomcat-${TOMCAT_VERSION}/
RUN rm -f apache-tomcat-${TOMCAT_VERSION}.tar.gz

RUN yum -y install java
RUN java -version

#files with was extension in folder ./target will be deploy inside container 
copy ./target/*.war /opt/tomcat/webapps/


#setting user name and password 
ADD ./tomcat-conf/tomcat-users.xml /opt/tomcat/conf/

#allow to connect from remote host
ADD ./tomcat-conf/context.xml /opt/tomcat/webapps/manager/META-INF/context.xml

WORKDIR /opt/tomcat/webapps

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]

#$docker build -t my-calculator . 
#$docker container run -it --publish 3333:8080 my-calculator 