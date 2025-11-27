# Dockerfile
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy wait-for-it script to wait for Redis
COPY wait-for-it.sh /app/wait-for-it.sh
RUN chmod +x /app/wait-for-it.sh

# Copy Spring Boot jar
COPY target/springboot-redis-demo-1.0.0.jar app.jar

# Expose the app port
EXPOSE 8084

# Wait for Redis before starting the app
ENTRYPOINT ["/app/wait-for-it.sh", "redis:6379", "--", "java", "-jar", "app.jar"]
