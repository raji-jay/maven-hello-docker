pipeline {
    agent any

    environment {
        IMAGE_NAME = 'rajyjay/maven-hello-world'
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github_java', url: 'https://github.com/goelvijay/MavenHelloWorld.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %IMAGE_NAME% ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    bat 'echo %PASSWORD% | docker login -u %USERNAME% --password-stdin'
                    bat 'docker push %IMAGE_NAME%'
                }
            }
        }

        stage('Clean Up') {
            steps {
                bat 'docker rmi %IMAGE_NAME%'
            }
        }
    }
}
