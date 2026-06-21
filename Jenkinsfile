pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'vallivamsi'
        IMAGE_TAG = 'v1'
        DOCKERHUB_CREDS = 'dockerhub-creds'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/pravallikavamsi/Cloudcart-Microservices.git'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${DOCKERHUB_CREDS}",
                    usernameVariable: 'DOCKER_USERNAME',
                    passwordVariable: 'DOCKER_PASSWORD'
                )]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                    '''
                }
            }
        }

        stage('Build Frontend Image') {
            steps {
                sh '''
                    docker build -t $DOCKERHUB_USER/cloudcart-frontend:$IMAGE_TAG frontend
                '''
            }
        }

        stage('Build Backend Microservice Images') {
            steps {
                sh '''
                    SERVICES="api-gateway auth-service user-service product-service inventory-service cart-service order-service payment-service shipping-service notification-service review-service"

                    for SERVICE in $SERVICES
                    do
                        echo "Building $SERVICE image..."
                        docker build -t $DOCKERHUB_USER/cloudcart-$SERVICE:$IMAGE_TAG services/$SERVICE
                    done
                '''
            }
        }

        stage('Push Frontend Image') {
            steps {
                sh '''
                    docker push $DOCKERHUB_USER/cloudcart-frontend:$IMAGE_TAG
                '''
            }
        }

        stage('Push Backend Microservice Images') {
            steps {
                sh '''
                    SERVICES="api-gateway auth-service user-service product-service inventory-service cart-service order-service payment-service shipping-service notification-service review-service"

                    for SERVICE in $SERVICES
                    do
                        echo "Pushing $SERVICE image..."
                        docker push $DOCKERHUB_USER/cloudcart-$SERVICE:$IMAGE_TAG
                    done
                '''
            }
        }
    }

    post {
        always {
            sh '''
                docker logout || true
            '''
        }

        success {
            echo 'All CloudCart Docker images built and pushed successfully.'
        }

        failure {
            echo 'Build or push failed. Check Dockerfile path, image name, or Docker Hub credentials.'
        }
    }
}
