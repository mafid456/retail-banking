# Multi-stage build

# ---------- Build Stage ----------
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy source code
COPY . .

# Build application without tests
RUN mvn clean package -DskipTests

# ---------- Runtime Stage ----------
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy built jar from build stage
COPY --from=build /app/target/*.jar app.jar

# Expose app port (change if needed)
EXPOSE 8081

# Start application
ENTRYPOINT ["java", "-jar", "app.jar"]
