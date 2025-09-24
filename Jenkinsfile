pipeline {
  agent any
  environment {
    IMAGE = "nodejs-demo-app:${env.BUILD_NUMBER}"
  }
  stages {
    stage('Checkout') {
      steps {
        // Replace URL below with your repository URL if you use a different one
        git branch: 'main', url: 'https://github.com/your-username/nodejs-demo-app.git'
      }
    }
    stage('Build') {
      steps {
        echo 'Building Docker image...'
        sh 'docker build -t $IMAGE .'
      }
    }
    stage('Test') {
      steps {
        echo 'Running tests inside container...'
        sh 'docker run --rm $IMAGE npm test'
      }
    }
    stage('Deploy') {
      steps {
        echo 'Deploying container (host port 8081 -> container 8080)...'
        sh '''
          docker rm -f nodejs-demo || true
          docker run -d --name nodejs-demo -p 8081:8080 $IMAGE
        '''
      }
    }
  }
  post {
    always {
      echo "Build finished with status: ${currentBuild.currentResult}"
    }
  }
}
