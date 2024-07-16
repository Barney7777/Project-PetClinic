pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID = "587866558777"
        AWS_ECR_REPO_NAME = "petclinic-dev"
        AWS_DEFAULT_REGION = "ap-southeast-2"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage ('clean workspace') {
            steps {
                cleanWs()
            }
        }

        stage ('Checkout Source Code') {
            steps {
                git branch: 'prod', url: 'https://github.com/Barney7777/triptribe-frontend.git'
            }
        }
    }
}