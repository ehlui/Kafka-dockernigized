FROM openjdk:11
LABEL MAINTAINER="ehlui"
ARG JAR_FILE=kafkadockerized/target/*.jar
WORKDIR /app
COPY ${JAR_FILE} ./consumer.jar
ENTRYPOINT ["java","-jar","consumer.jar"]