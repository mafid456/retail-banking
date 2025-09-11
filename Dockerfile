# Use official Maven + JDK image for build stage
FROM maven:3.9.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy source
COPY . .

# Build without tests
RUN mvn clean package -DskipTests

# --- Runtime image ---
FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy JAR from build stage
COPY --from=build /app/target/*.jar app.jar

# Expose application port (change if needed)
EXPOSE 8081

# Run application
ENTRYPOINT ["java", "-jar", "app.jar"]
