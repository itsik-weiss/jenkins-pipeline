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

        stage('Setup Python') {
            steps {
                echo 'Setting up Python environment...'
                sh '''
                    python3 --version
                    apt-get update
                    apt-get install -y python3-venv python3-pip
                    python3 -m venv venv
                    . venv/bin/activate
                    python3 -m pip install --upgrade pip
                '''
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing dependencies...'
                sh '''
                    . venv/bin/activate
                    python3 -m pip install --no-cache-dir -r requirements.txt
                '''
            }
        }
        
        stage('Run Tests') {
            steps {
                echo 'Running tests...'
                sh '''
                    . venv/bin/activate
                    python3 simple_test.py
                '''
            }
        }

        stage('Build') {
            steps {
                echo 'Building Docker image...'
                sh "docker build -t ${APP_NAME}:${BUILD_NUMBER} ."
                sh 'docker images'
            }
        }

        stage('Security Scan') {
            steps {                
                echo 'Scanning Docker image for vulnerabilities...'
                sh """
                    trivy image --severity HIGH,CRITICAL ${APP_NAME}:${BUILD_NUMBER}
                    trivy image --exit-code 1 --severity HIGH,CRITICAL ${APP_NAME}:${BUILD_NUMBER} || true
                """
            }
        }

        stage('Push to Docker Hub') {
            environment {
                DOCKER_CREDS = credentials('docker-hub-credentials')
                DOCKER_REPO = 'itsikweiss1020/weather-app'
            }
            steps {
                echo 'Pushing image to Docker Hub...'
                sh '''
                    echo $DOCKER_CREDS_PSW | docker login -u $DOCKER_CREDS_USR --password-stdin
                    docker tag ${APP_NAME}:${BUILD_NUMBER} ${DOCKER_REPO}:${BUILD_NUMBER}
                    docker tag ${APP_NAME}:${BUILD_NUMBER} ${DOCKER_REPO}:latest
                    docker push ${DOCKER_REPO}:${BUILD_NUMBER}
                    docker push ${DOCKER_REPO}:latest
                    docker logout
                '''
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