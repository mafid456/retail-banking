pipeline {
    agent any

    environment {
        APP_NAME = "spring-boot-app"
        DOCKER_IMAGE = "${APP_NAME}:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                // Use GitHub HTTPS + Personal Access Token (PAT)
                git branch: 'master',
                    url: 'https://github.com/mafid456/retail-banking.git',
                    credentialsId: '6458f8e2-dc29-49bd-917d-59904b026f0e'   // <-- Add this in Jenkins Credentials
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
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                // Default compose file
                sh 'docker-compose down'
                sh 'docker-compose up -d --build'

                // 👉 If you want branch-based deployment:
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
        always {
            echo "🏁 Pipeline finished."
        }
    }
}
