pipeline {
    agent any

    tools {
        maven 'maven'
    }

    environment {
        DOCKER_COMPOSE_DIR = "/var/lib/jenkins/workspace/jenkins"
        DOCKER_IMAGE = "sak_redis_app"
    }

    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Spring Boot JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                    cd ${DOCKER_COMPOSE_DIR}
                    docker build -t ${DOCKER_IMAGE} .
                """
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                sh """
                    cd ${DOCKER_COMPOSE_DIR}
                    docker-compose down -v --remove-orphans
                    docker-compose up -d --build
                """
            }
        }
    }

    post {
        success {
            echo "Deployment completed successfully!"
        }
        failure {
            echo "Deployment failed!"
        }
    }
}
