pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mafid456/your-repo.git'
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
                // Default deployment
                sh 'docker-compose down'
                sh 'docker-compose up -d --build'
                
                // 👉 Or use branch-based deployment:
                // if (env.BRANCH_NAME == 'dev') {
                //     sh 'docker-compose -f docker-compose.dev.yml up -d --build'
                // } else {
                //     sh 'docker-compose -f docker-compose.prod.yml up -d --build'
                // }
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
