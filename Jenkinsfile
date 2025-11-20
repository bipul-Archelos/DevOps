pipeline {
    agent any

    stages {
        stage('Pull Code') {
            steps {
                echo "Pulling code from GitHub..."
            }
        }

        stage('Build'){
            steps{
                echo "Building the project..."
                sh 'echo Build Stage Completed'
            }
        }

        stage('Test'){
            steps {
                echo "Running tests..."
                sh 'echo ALl test passed!'
            }
        }

        stage('Deploy'){
            steps {
                echo "Deploying Application..."
                sh 'echo Application Deployed Successfully'
            }
        }

    }
    post {
        success {
            echo "Pipeline SUCCESS!"
        }
        failure {
            echo "Pipeline Failed!"
        }
    }
}