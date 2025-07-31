pipeline {
    agent any

    environment {
        BUILD_NUMBER = "${env.BUILD_NUMBER}"
        APP_NAME = 'weather-app'
    }

    options {
        timeout(time: 1, unit: 'HOURS')
        disableConcurrentBuilds()
    }

    stages {
        stage('Clone') {
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/itsik-weiss/weather-app.git',
                    branch: 'main'
                sh 'ls'
                echo 'Repository cloned successfully!'
                sh 'pwd'
            }
        }

        stage('Build') {
            steps {
                echo 'Building Docker image...'
                sh "docker build -t ${APP_NAME}:${BUILD_NUMBER} ."
                sh 'docker images'
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }

        success {
            echo 'Build successful!'
        }

        failure {
            echo 'Build failed!'
        }
    }
}