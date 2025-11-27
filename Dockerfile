# Use OpenJDK 17 Alpine
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy Spring Boot JAR
COPY target/springboot-redis-demo-1.0.0.jar app.jar

# Expose port
EXPOSE 8084

# Use a single CMD instruction with sh to wait for Redis
CMD sh -c " \
  echo '⏳ Waiting for Redis...'; \
  while ! nc -z ${SPRING_REDIS_HOST:-redis} ${SPRING_REDIS_PORT:-6379}; do \
    echo 'Redis not ready, retrying...'; \
    sleep 2; \
  done; \
  echo '✅ Redis is up! Starting Spring Boot...'; \
  java -jar app.jar \
"
