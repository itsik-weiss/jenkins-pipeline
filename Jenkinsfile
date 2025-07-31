pipeline {
    agent any
    
    environment {
        BUILD_NUMBER = "${env.BUILD_NUMBER}"
        APP_NAME = "weather-app"
    }
    
    options {
        timeout(time: 1, unit: 'HOURS')
        disableConcurrentBuilds()
    }
    
    stages {
        stage('git clone') {
            steps {
                echo 'Cloning the weather app repository...'
                checkout([$class: 'GitSCM', branches: [[name: '*/main']],
                    userRemoteConfigs: [[url: 'https://github.com/itsik-weiss/weather-app.git']]])
                sh 'pwd'
                sh 'ls'
                sh 'cd weather-app && git checkout main'
                echo 'Repository cloned successfully!'
                sh 'pwd'
                sh 'ls'
                
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'docker build -t ${APP_NAME}:${BUILD_NUMBER} .'
                echo 'Build completed successfully!'
                sh 'docker images'
            }
        }
        
        
        }
    }
    
    post {
        always {
            echo 'Pipeline execution completed.'
            
            // Clean up workspace
            cleanWs()
        }
        
        success {
            echo 'Pipeline executed successfully!'
            
            // Add success notifications here
            // Examples:
            // emailext body: 'Build successful!', subject: 'Jenkins Build Success', to: 'team@example.com'
            // slackSend channel: '#ci-cd', color: 'good', message: "Build #${BUILD_NUMBER} succeeded"
        }
        
        failure {
            echo 'Pipeline failed!'
            
            // Add failure notifications here
            // Examples:
            // emailext body: 'Build failed!', subject: 'Jenkins Build Failure', to: 'team@example.com'
            // slackSend channel: '#ci-cd', color: 'danger', message: "Build #${BUILD_NUMBER} failed"
        }
        
        unstable {
            echo 'Pipeline is unstable!'
            
            // Add unstable notifications here
        }
        
        aborted {
            echo 'Pipeline was aborted!'
            
            // Add aborted notifications here
        }
    }
