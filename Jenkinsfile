pipeline {
    agent {
        docker {
            image 'maven:3.9.9-eclipse-temurin-21'
            args '-v /root/.m2:/root/.m2'  // Cache Maven dependencies
        }
    }

    environment {
        APP_NAME = "spring-boot-app"
        DOCKER_IMAGE = "${APP_NAME}:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/mafid456/your-repo.git',
                    credentialsId: '6458f8e2-dc29-49bd-917d-59904b026f0e'   // Jenkins credentials for GitHub PAT
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'chmod +x mvnw'
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            agent any   // Switch back to Jenkins host (needs Docker installed)
            steps {
                sh "docker build -t ${DOCKER_IMAGE} ."
            }
        }

        stage('Deploy with Docker Compose') {
            agent any
            steps {
                sh 'docker-compose down'
                sh 'docker-compose up -d --build'
                
                // 👉 Optional: branch-based deployment
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
