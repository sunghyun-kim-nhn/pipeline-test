FROM maven:3-eclipse-temurin-17 AS builder
ARG APP_HOME=/home/usr/app
COPY . $APP_HOME
WORKDIR $APP_HOME
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine

ARG APP_HOME=/home/usr/app
ARG SERVICE_NAME=app

COPY --from=builder $APP_HOME/target/*.jar $APP_HOME/$SERVICE_NAME.jar
CMD java -jar $APP_HOME/$SERVICE_NAME.jar