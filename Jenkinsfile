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
         bat 'docker build -t rajijay/maven-hello-world:latest .'
    }
}

        stage('Push to Docker Hub') {
            steps {
               withCredentials([string(credentialsId: 'dockerhub-creds', variable: 'DOCKERHUB_PASSWORD')]) {
    bat """
        echo %DOCKERHUB_PASSWORD% | docker login -u rajijay --password-stdin
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
