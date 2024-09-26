# Étape 1 : Construire l'application avec Maven
FROM maven:3.8.1-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Étape 2 : Exécuter l'application avec OpenJDK
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/guerinApp-0.0.1-SNAPSHOT.jar guerinApp.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "guerinApp.jar"]
