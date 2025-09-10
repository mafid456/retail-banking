# =========================
# Build stage
# =========================
FROM maven:3-amazoncorretto-21-debian AS build

WORKDIR /app

# Copy pom and download dependencies first (better caching)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source and build (this will generate target/app.jar)
COPY src ./src
RUN mvn clean package -DskipTests -B

# =========================
# Run stage
# =========================
FROM amazoncorretto:21-alpine

WORKDIR /app

# Copy our fixed JAR (always app.jar now)
COPY --from=build /app/target/app.jar app.jar

EXPOSE 33060

ENV SPRING_PROFILES_ACTIVE=prod

ENTRYPOINT ["java", "-jar", "app.jar"]
