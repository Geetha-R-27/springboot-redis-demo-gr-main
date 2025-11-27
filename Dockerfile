FROM eclipse-temurin:17-jdk-alpine

# Install bash
RUN apk add --no-cache bash

WORKDIR /app

COPY target/springboot-redis-demo-1.0.0.jar app.jar
COPY wait-for-it.sh /app/wait-for-it.sh

# Make wait-for-it executable
RUN chmod +x /app/wait-for-it.sh

EXPOSE 8084

# Run wait-for-it to wait for Redis, then start the app
CMD ["./wait-for-it.sh", "redis:6379", "--timeout=30", "--strict", "--", "java", "-jar", "app.jar"]
