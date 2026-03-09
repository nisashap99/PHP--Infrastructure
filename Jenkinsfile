pipeline {
    agent any

    environment {
        REGISTRY = "516861151784.dkr.ecr.us-east-1.amazonaws.com"
        IMAGE_NAME = "php-devops-app"
        CONTAINER_NAME = "php-container"
        PORT = "8082"
        AWS_REGION = "us-east-1"
        IMAGE_TAG = "build-${BUILD_NUMBER}"
    }

    stages {

        stage('Docker Login') {
            steps {
                script{
                    withAWS(region: 'us-east-1', credentials: 'aws-creds') {
                        sh """
                           aws ecr get-login-password --region $AWS_REGION \
                            | docker login --username AWS --password-stdin $REGISTRY
                        """
                    }
                }
            }
        }

        stage('Docker Build Image') {
            steps {
                script{
                    withAWS(region: 'us-east-1', credentials: 'aws-creds') {
                        sh """
                            docker build -t $REGISTRY/$IMAGE_NAME:$IMAGE_TAG .
                        """
                    }
                }
            }
        }

        stage('Docker Push Image to ECR ') {
            steps {
                script{
                    withAWS(region: 'us-east-1', credentials: 'aws-creds') {
                        sh """
                            docker push $REGISTRY/$IMAGE_NAME:$IMAGE_TAG
                        """
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml --validate=false'
                sh 'kubectl apply -f service.yaml --validate=false'
                sh 'kubectl apply -f hpa.yaml --validate=false'

                sh """
                    kubectl set image deployment/php-devops-app \
                    php-container=$REGISTRY/$IMAGE_NAME:$IMAGE_TAG
                    """
                    echo "$IMAGE_TAG"
                }
        }

        /* stage('Deploy Container') {
            steps {
                sh '''
                docker rm -f $CONTAINER_NAME || true
                docker run -d -p 8082:80 --name $CONTAINER_NAME $REGISTRY/$IMAGE_NAME:latest
                docker ps
                '''
            }
        } */

        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
    }

    post {
        success {
            echo "Deployment successful 🚀"
        }
        failure {
            echo "Pipeline failed ❌"
        }
    }
}