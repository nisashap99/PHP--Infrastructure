// 

pipeline {
    agent any

    environment {
        IMAGE_NAME = "php-devops-app"
        CONTAINER_NAME = "php-container"
        PORT = "8082"

        AWS_REGION = "us-east-1"
        ACCOUNT_ID = "516861151784"

        ECR_REPO = "${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/php-devops-app"
    }

    stages { 

        stage('Docker Build') {
            steps {
                script {
                    withAWS(region: 'us-east-1', credentials: 'aws-creds') {
                        sh """
                        aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com

                        docker build -t ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com/php-devops-app:latest .

                        docker push ${ACC_ID}.dkr.ecr.us-east-1.amazonaws.com/php-devops-app:latest
                        """
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                docker run -d -p $PORT:80 --name $CONTAINER_NAME $ECR_REPO:latest
                '''
            }
        }

    }

    post {
        success {
            echo "Deployment successful🚀"
        }
        failure {
            echo "Pipeline failed ❌"
        }
    }
}