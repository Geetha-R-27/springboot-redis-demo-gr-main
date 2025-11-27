pipeline {
agent any
    
tools {
    maven 'maven' 
}

environment {
    DOCKER_COMPOSE_DIR = "/var/lib/jenkins/workspace/jenkins"  // Directory containing docker-compose.yml
    DOCKER_IMAGE = "sak_redis_app"
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
                cd ${DOCKER_COMPOSE_DIR}
                docker build -t ${DOCKER_IMAGE} .
            """
        }
    }

    stage('Deploy with Docker Compose') {
        steps {
            echo "🚀 Deploying using docker-compose..."
            sh """
                cd ${DOCKER_COMPOSE_DIR}
                echo "Stopping old containers..."
                docker-compose down -v --remove-orphans

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
