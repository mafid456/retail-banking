pipeline {
    agent {
        docker {
            image 'maven:3.9.9-eclipse-temurin-17'
            args '-v /root/.m2:/root/.m2' // optional: cache Maven dependencies
        }
    }

    environment {
        APP_NAME = 'my-app'
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone your repo
                git 'https://github.com/your-repo/project.git'
            }
        }

        stage('Build') {
            steps {
                // Run Maven build inside the container
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build') {
            steps {
                // Build your Docker image using your multi-stage Dockerfile
                sh 'docker build -t ${APP_NAME} .'
            }
        }

        stage('Docker Run (optional)') {
            steps {
                // Run container (for testing)
                sh 'docker run -d -p 8081:8081 ${APP_NAME}'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished'
        }
    }
}
