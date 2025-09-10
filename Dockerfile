# =========================
# Build stage
# =========================
FROM maven:3-amazoncorretto-21-debian AS build

WORKDIR /app

# Copy pom.xml and download dependencies (caching)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source and build the JAR
COPY src ./src
RUN mvn clean package -DskipTests -B

# =========================
# Run stage
# =========================
FROM amazoncorretto:21-alpine

WORKDIR /app

# Copy the generated JAR and rename to app.jar
COPY --from=build /app/target/*.jar app.jar

EXPOSE 9998

# Default profile (can override in docker-compose.yml)
ENV SPRING_PROFILES_ACTIVE=prod

ENTRYPOINT ["java", "-jar", "app.jar"]
