pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/mafid456/retail-banking.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'chmod +x mvnw'
                sh './mvnw clean package -DskipTests'
            }
        }


        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t spring-boot-app:latest ."
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                // For default docker-compose.yml
                sh 'docker-compose down'
                sh 'docker-compose up -d --build'
                
                // 👉 If you want environment-based:
                // sh 'docker-compose -f docker-compose.dev.yml up -d --build'
                // sh 'docker-compose -f docker-compose.prod.yml up -d --build'
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful!"
        }
        failure {
            echo "❌ Deployment failed!"
        }
    }
}
