# Build environment
FROM gradle:9.3-jdk21 AS builder

WORKDIR /app

# Copy only build files first
COPY gradle gradle
COPY gradlew .
COPY build.gradle.kts .
COPY settings.gradle.kts .

RUN ./gradlew dependencies --no-daemon

# Copy source
COPY . .

# Build the application
RUN ./gradlew bootJar --no-daemon

# Runtime environment
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copy built jar from builder
COPY --from=builder /app/build/libs/*.jar app.jar

EXPOSE 8080

# Run jar directly
ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]
