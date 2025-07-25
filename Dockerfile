# Stage 1: Build using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Stage 2: Run the fat JAR
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/target/MavenHelloWorld-0.2.0.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
