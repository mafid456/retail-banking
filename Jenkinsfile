pipeline {
    agent any

    environment {
        IMAGE_NAME = "retail-banking-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/mafid456/retail-banking.git',
                    branch: 'master',
                    credentialsId: 'd3458c5c-6909-4e55-bd0e-db9a20ca9253'
            }
        }

        stage('Build JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Run Container') {
            steps {
                sh """
                docker rm -f ${IMAGE_NAME} || true
                docker run -d --name ${IMAGE_NAME} -p 8081:8081 ${IMAGE_NAME}:latest
                """
            }
        }
    }
}
