FROM tomcat:8.5-jre8

LABEL org.opencontainers.image.source=https://github.com/hardingadonis/miu-shop
LABEL org.opencontainers.image.description="Container that runs Tomcat for Miu Shop"
LABEL org.opencontainers.image.licenses=Apache-2.0

LABEL maintainer=hardingadonis@gmail.com
LABEL maintainer=hardingadonis@gmail.com

# Copy the war file to the container
COPY ./*.war /usr/local/tomcat/webapps/miu.war

# Set the default port
EXPOSE 8080

# Set the default command
CMD ["catalina.sh", "run"]