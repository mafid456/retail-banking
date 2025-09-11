pipeline {
    agent any

    tools {
        // Use Maven installed in Jenkins (Manage Jenkins → Tools → Maven installations)
        maven 'Maven-3.9'
        jdk 'jdk17'
    }

    environment {
        IMAGE_NAME = "retail-banking-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/mafid456/retail-banking.git',
                    branch: 'master',
                    credentialsId: 'b921b256-4f38-4a28-9fd1-f6010a954546'
            }
        }

        stage('Build JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:latest ."
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // Stop old container if running
                    sh """
                    docker rm -f ${IMAGE_NAME} || true
                    docker run -d --name ${IMAGE_NAME} -p 8081:8081 ${IMAGE_NAME}:latest
                    """
                }
            }
        }
    }
}
