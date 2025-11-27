# Use OpenJDK 17 as base image
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy jar and wait-for-it script
COPY target/springboot-redis-demo-1.0.0.jar app.jar
COPY wait-for-it.sh wait-for-it.sh

# Make wait-for-it executable
RUN chmod +x wait-for-it.sh

# Expose application port
EXPOSE 8084

# Start app only after Redis is ready
ENTRYPOINT ["./wait-for-it.sh", "redis:6379", "--", "java", "-jar", "app.jar"]
