pipeline {
agent any

```
environment {
    REGISTRY = "180935779261.dkr.ecr.us-east-1.amazonaws.com"
    IMAGE_NAME = "php-devops-app"
    CONTAINER_NAME = "php-container"
    PORT = "8082"
    AWS_REGION = "us-east-1"
    IMAGE_TAG = "build-${BUILD_NUMBER}"
}

stages {

    stage('Docker Login') {
        steps {
            script {
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
            sh """
            docker build -t $REGISTRY/$IMAGE_NAME:$IMAGE_TAG .
            """
        }
    }

    stage('Docker Push Image to ECR') {
        steps {
            sh """
            docker push $REGISTRY/$IMAGE_NAME:$IMAGE_TAG
            """
        }
    }

    stage('Deploy to Kubernetes') {
        steps {
            sh '''
            kubectl apply -f deployment.yaml --validate=false
            kubectl apply -f service.yaml --validate=false
            '''

            sh """
            kubectl set image deployment/php-app \
            php-app=$REGISTRY/$IMAGE_NAME:$IMAGE_TAG
            """

            sh 'echo Deploying image tag: $IMAGE_TAG'
        }
    }

    stage('Clean Workspace') {
        steps {
            cleanWs()
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
```

}
