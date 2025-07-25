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
        docker build -t rajijay/maven-hello-world:latest .
    }
}

        stage('Push to Docker Hub') {
            steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            bat """
                echo %PASSWORD% | docker login -u %USERNAME% --password-stdin
                docker push rajijay/maven-hello-world:latest
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
