# =========================
# Build stage
# =========================
FROM maven:3-amazoncorretto-21-debian AS build

WORKDIR /app

# Copy pom and download dependencies first (better caching)
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy source and build
COPY src ./src
RUN mvn clean package -DskipTests

# =========================
# Run stage
# =========================
FROM amazoncorretto:21-alpine

WORKDIR /app

# Copy the built JAR (any *.jar from target) and rename to app.jar
COPY --from=build /app/target/*.jar app.jar

EXPOSE 9998

# Set default Spring profile (can override in docker-compose.yml)
ENV SPRING_PROFILES_ACTIVE=prod

ENTRYPOINT ["java", "-jar", "app.jar"]
