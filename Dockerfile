# Use Eclipse Temurin JDK 21 as build environment
FROM eclipse-temurin:21-jdk AS build

WORKDIR /app

# Copy Maven wrapper and pom.xml
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B

# Copy source and build
COPY src src
RUN ./mvnw clean package -DskipTests

# -----------------------------
# Runtime Image
# -----------------------------
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copy built jar
COPY --from=build /app/target/*.jar app.jar

# Expose custom port (e.g., 9090)
EXPOSE 9090

# Run Spring Boot app on port 9090
ENTRYPOINT ["java", "-jar", "app.jar", "--server.port=9090"]
