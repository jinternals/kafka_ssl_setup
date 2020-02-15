FROM java:8-jre
MAINTAINER Mradul Pandey <pandeymradul@gmail.com>

ADD ./@project.build.finalName@.jar /app/
CMD ["java", "-Xmx1024m", "-jar", "/app/@project.build.finalName@.jar"]

EXPOSE 8080
