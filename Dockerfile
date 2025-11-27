FROM eclipse-temurin:17-jdk-alpine

# Install bash for wait-for-it.sh
RUN apk add --no-cache bash

WORKDIR /app

# Copy the built jar and wait-for-it script
COPY target/springboot-redis-demo-1.0.0.jar app.jar
COPY wait-for-it.sh /app/wait-for-it.sh

# Make wait-for-it executable
RUN chmod +x /app/wait-for-it.sh

EXPOSE 8084

# Wait for Redis to be ready, then start the app
CMD ["./wait-for-it.sh", "redis:6379", "--timeout=30", "--strict", "--", "java", "-jar", "app.jar"]
