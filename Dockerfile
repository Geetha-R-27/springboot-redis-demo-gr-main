# Use OpenJDK 17
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy JAR
COPY target/springboot-redis-demo-1.0.0.jar app.jar

# Copy wait-for-it script
COPY wait-for-it.sh /app/wait-for-it.sh
RUN chmod +x /app/wait-for-it.sh

# Expose port
EXPOSE 8084

# Wait for Redis and then start app
CMD ["./wait-for-it.sh", "redis:6379", "--timeout=30", "--strict", "--", "java", "-jar", "app.jar"]
