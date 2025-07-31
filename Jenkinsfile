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
                sh 'git clone https://github.com/itsik-weiss/weather-app.git'
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building the application...'
                sh 'docker build -t ${APP_NAME}:${BUILD_NUMBER} .'
                echo 'Build completed successfully!'
                sh 'docker images'
                // sh 'docker rmi ${APP_NAME}:${BUILD_NUMBER} || true'
            }
        }
        
        // stage('Test') {
        //     parallel {
        //         stage('Unit Tests') {
        //             steps {
        //                 echo 'Running unit tests...'
                        
        //                 // Add your unit test commands here
        //                 // Examples:
        //                 // sh 'npm test'
        //                 // sh 'mvn test'
        //                 // sh 'python -m pytest tests/unit/'
                        
        //                 echo 'Unit tests completed!'
        //             }
        //             post {
        //                 always {
        //                     // Publish test results if available
        //                     // publishTestResults testResultsPattern: 'test-results.xml'
        //                     echo 'Unit test results processed'
        //                 }
        //             }
        //         }
                
        //         stage('Integration Tests') {
        //             steps {
        //                 echo 'Running integration tests...'
                        
        //                 // Add your integration test commands here
        //                 // Examples:
        //                 // sh 'npm run test:integration'
        //                 // sh 'mvn verify'
        //                 // sh 'python -m pytest tests/integration/'
                        
        //                 echo 'Integration tests completed!'
        //             }
        //         }
        //     }
        // }
        
        // stage('Code Quality') {
        //     steps {
        //         echo 'Running code quality checks...'
                
        //         // Add your code quality tools here
        //         // Examples:
        //         // sh 'npm run lint'
        //         // sh 'sonar-scanner'
        //         // sh 'eslint src/'
                
        //         echo 'Code quality checks completed!'
        //     }
        // }
        
        // stage('Security Scan') {
        //     steps {
        //         echo 'Running security scans...'
                
        //         // Add your security scanning tools here
        //         // Examples:
        //         // sh 'npm audit'
        //         // sh 'snyk test'
        //         // sh 'bandit -r src/'
                
        //         echo 'Security scans completed!'
        //     }
        // }
        
        // stage('Package') {
        //     steps {
        //         echo 'Packaging the application...'
                
        //         // Add your packaging commands here
        //         // Examples:
        //         // sh 'npm run build'
        //         // sh 'mvn package'
        //         // sh 'docker build -t ${APP_NAME}:${BUILD_NUMBER} .'
                
        //         echo 'Application packaged successfully!'
        //     }
        // }
        
        // stage('Deploy to Staging') {
        //     when {
        //         anyOf {
        //             branch 'develop'
        //             branch 'main'
        //             branch 'master'
        //         }
        //     }
        //     steps {
        //         echo 'Deploying to staging environment...'
                
        //         // Add your staging deployment commands here
        //         // Examples:
        //         // sh 'kubectl apply -f k8s/staging/'
        //         // sh 'ansible-playbook deploy-staging.yml'
        //         // sh 'docker-compose -f docker-compose.staging.yml up -d'
                
        //         echo 'Deployment to staging completed!'
        //     }
        // }
        
        // stage('Smoke Tests') {
        //     when {
        //         anyOf {
        //             branch 'develop'
        //             branch 'main'
        //             branch 'master'
        //         }
        //     }
        //     steps {
        //         echo 'Running smoke tests on staging...'
                
        //         // Add your smoke test commands here
        //         // Examples:
        //         // sh 'curl -f http://staging.example.com/health'
        //         // sh 'npm run test:smoke'
        //         // sh 'python smoke_tests.py'
                
        //         echo 'Smoke tests completed successfully!'
        //     }
        // }
        
    //     stage('Deploy to Production') {
    //         when {
    //             branch 'main'
    //         }
    //         steps {
    //             script {
    //                 // Add approval step for production deployment
    //                 def deployToProduction = input(
    //                     id: 'deployToProduction',
    //                     message: 'Deploy to production?',
    //                     parameters: [
    //                         choice(
    //                             choices: ['No', 'Yes'],
    //                             description: 'Choose whether to deploy to production',
    //                             name: 'DEPLOY_TO_PROD'
    //                         )
    //                     ]
    //                 )
                    
    //                 if (deployToProduction == 'Yes') {
    //                     echo 'Deploying to production environment...'
                        
    //                     // Add your production deployment commands here
    //                     // Examples:
    //                     // sh 'kubectl apply -f k8s/production/'
    //                     // sh 'ansible-playbook deploy-production.yml'
    //                     // sh 'docker-compose -f docker-compose.production.yml up -d'
                        
    //                     echo 'Deployment to production completed!'
    //                 } else {
    //                     echo 'Production deployment skipped by user choice.'
    //                 }
    //             }
    //         }
    //     }
    // }
    
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
}
