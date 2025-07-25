pipeline {
    agent any

    environment {
        IMAGE_NAME = 'rajyjay/maven-hello-world'
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
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            bat """
                echo %PASSWORD% | docker login -u %USERNAME% --password-stdin
                docker push rajeshwari.mercu/maven-hello-world
            """
            }
         }
        }

        stage('Clean Up') {
            steps {
                bat 'docker rm %IMAGE_NAME%'
            }
        }
    }
}
