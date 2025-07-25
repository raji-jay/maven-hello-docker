pipeline {
    agent any

    environment {
        IMAGE_NAME = 'rajijay/maven-hello-world:latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'dockerhub-creds', url: 'https://github.com/raji-jay/maven-hello-docker.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %IMAGE_NAME% ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',        
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    bat """
                        echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin
                        docker push %IMAGE_NAME%
                    """
                }
            }
        }

        stage('Clean Up') {
            steps {
               
                bat "docker rmi %IMAGE_NAME%"
            }
        }
    }
}


