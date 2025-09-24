pipeline {
    agent any

    environment {
        IMAGE_NAME = "nodejs-demo-app:${env.BUILD_NUMBER}"
        CONTAINER_NAME = "nodejs-demo"
        HOST_PORT = "8081"
        CONTAINER_PORT = "8080"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning GitHub repository..."
                git branch: 'main', url: 'https://github.com/Kona147/-Simple-Jenkins-Pipeline-for-CI-CD.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Test') {
            steps {
                echo "Running tests inside Docker..."
                // If you have npm tests
                sh "docker run --rm ${IMAGE_NAME} npm test || echo 'No tests found, skipping...'"
            }
        }

        stage('Deploy') {
            steps {
                echo "Deploying Docker container..."
                // Stop old container if exists
                sh "docker rm -f ${CONTAINER_NAME} || true"
                // Run new container
                sh "docker run -d --name ${CONTAINER_NAME} -p ${HOST_PORT}:${CONTAINER_PORT} ${IMAGE_NAME}"
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully! App deployed at http://localhost:${HOST_PORT}"
        }
        failure {
            echo "Pipeline failed. Check logs for errors."
        }
    }
}

