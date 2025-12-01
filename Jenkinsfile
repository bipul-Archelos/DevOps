pipeline {
    agent any

    stages {
        stage('Pull Code') {
            steps {
                echo 'Pulling code from GitHub...'
                git branch: "main", url:'https://github.com/bipul-Archelos/DevOps.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t testethical/devops-app:${env.BUILD_NUMBER} .'
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
                sh 'docker push testethical/devops-app:${env.BUILD_NUMBER}'
            }
        }
        stage('Deploy to kubernetes'){
            steps {
                sh "kubectl set image deployment/devops-app-deployment devops-container=testethical/devops-app:${env.BUILD_NUMBER}"
                sh "kubectl rollout status deployment/devops-app-deployment"
            }
        }
    }
    post {
        success {
            echo 'Great! Build #${env.BUILD_NUMBER} Successfully Deployed!'
        }
        failure {
            echo 'Pipeline Failed Check logs'
        }
    }
}
