pipeline {
    agent any
  
  tools{
    maven 'maven'
  }

    stages {

        stage('Checkout Code') {
            steps {
                echo "📥 Pulling latest code..."
                checkout scm
            }
        }

        stage('Build Spring Boot JAR') {
            steps {
                echo "🔨 Building JAR..."
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "📦 Building Docker image..."
                sh """
                    docker build -t spring-redis-app:latest .
                """
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                echo "🚀 Deploying using docker-compose..."
                sh """
                    echo "Stopping old containers..."
                    docker-compose down

                    echo "Starting new containers..."
                    docker-compose up -d --build
                """
            }
        }
    }

    post {
        success {
            echo "🎉 Deployment completed successfully!"
        }
        failure {
            echo "❌ Deployment failed!"
        }
    }
}
