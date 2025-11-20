pipeline {
    agent any

    stages {
        stage('Pull Code') {
            steps {
                echo 'Pulling code from GitHub...'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t devops-app .'
            }
        }

        stage('Tag Docker Image') {
            steps {
                sh 'docker tag devops-app testethical/devops-app:v1'
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-pass', variable:'PASSWORD')]) {
                    sh 'echo "$PASSWORD" | docker login -u testethical --password-stdin'
                }
                sh 'docker push testethical/devops-app:v1'
            }
        }
    }
    post {
        success {
            echo 'Docker CI/CD Pipeline SUCCESS'
        }
        failure {
            echo 'Pipeline Failed!'
        }
    }
}
