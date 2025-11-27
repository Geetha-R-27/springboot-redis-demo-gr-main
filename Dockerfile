# Use OpenJDK 17 on Alpine
FROM eclipse-temurin:17-jdk-alpine

# Install bash (needed for wait-for-it)
RUN apk add --no-cache bash

# Set working directory
WORKDIR /app

# Copy JAR and wait-for-it script
COPY target/springboot-redis-demo-1.0.0.jar app.jar
COPY wait-for-it.sh /app/wait-for-it.sh

# Make wait-for-it executable
RUN chmod +x /app/wait-for-it.sh

# Expose port
EXPOSE 8084

# Wait for Redis before starting the app
CMD ["./wait-for-it.sh", "redis:6379", "--timeout=30", "--strict", "--", "java", "-jar", "app.jar"]
