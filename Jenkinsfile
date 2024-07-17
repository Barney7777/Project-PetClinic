pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID = "587866558777"
        AWS_ECR_REPO_NAME = "petclinic-dev"
        AWS_DEFAULT_REGION = "ap-southeast-2"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/"
        IMAGE_TAG = "${BUILD_NUMBER}"
        SONARSCANNER = 'sonar-scanner'
        SONARSERVER = 'sonar-server'
    }

    stages {
        stage ('clean workspace') {
            steps {
                cleanWs()
            }
        }

        stage ('Checkout Source Code') {
            steps {
                git branch: 'devops-barney', url: 'https://github.com/Barney7777/Project-PetClinic.git'
            }
        }

        // stage ('Snyk Security Scanning') {
        //     environment {
        //         SNYK_INSTALLATION = 'snyk'
        //         SNYK_TOKEN = 'snyk-api-token'
        //     }

        //     steps {
        //         script {
        //             echo "snyk security scanning"
        //             snykSecurity(
        //                 snykInstallation: SNYK_INSTALLATION,
        //                 snykTokenId: SNYK_TOKEN,
        //                 failOnIssues: false, // the build will not fail even if vulnerabilities are detected. 
        //                 monitorProjectOnBuild: true, // Snyk will continuously monitor the project and alert you to any newly discovered vulnerabilities in your dependencies.
        //                 additionalArguments: '--all-projects --d'
        //                 // additionalArguments: '--json --severity-threshold=low --json-file-output=all-vulnerabilities.json'
        //             )
        //         }
        //     }
        // }

        stage ('Build Artifact') {
            steps {
                script {
                    echo "Building jar file"
                    sh 'mvn clean package -DskipTests=true'
                }
            }
        }

        // stage ('Trivy FS Scan') {
        //     steps {
        //         script {
        //             echo "trivy fs scanning"
        //             sh "trivy fs --format table -o trivy-fs-report.html ."
        //         }
        //     }
        // }

        stage ('Code Quality Test') {
            environment {
                scannerHome = tool "${SONARSCANNER}"
            }

            steps {
                 withSonarQubeEnv("${SONARSERVER}"){
                    sh '''${scannerHome}/bin/sonar-scanner \
                   -Dsonar.organization=petclinic-spring-project \
                   -Dsonar.projectKey=petclinic \
                   -Dsonar.sources=. \
                   -Dsonar.host.url=https://sonarcloud.io'''
                 }
            }
        }

        // stage ('Docker Image Build and Tag') {
        //     steps {
        //         script {
        //             echo "docker image building and tagging"
        //             sh "docker build -t ${REPOSITORY_URI}${AWS_ECR_REPO_NAME}:latest ."
        //         }
        //     }
        // }

        // stage ('Trivy Image Scan') {
        //     steps {
        //         script {
        //             sh "trivy image --format table -o trivy-image-report.html ${REPOSITORY_URI}${AWS_ECR_REPO_NAME}:latest"
        //         }
        //     }
        // }

        // stage ('Docker Image Push to ECR') {
        //     steps {
        //         script {
        //             sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${REPOSITORY_URI}"
        //             sh "docker tag ${REPOSITORY_URI}${AWS_ECR_REPO_NAME}:latest ${REPOSITORY_URI}${AWS_ECR_REPO_NAME}:${IMAGE_TAG}"
        //             sh "docker push ${REPOSITORY_URI}${AWS_ECR_REPO_NAME}:${IMAGE_TAG}"
        //             sh "docker push ${REPOSITORY_URI}${AWS_ECR_REPO_NAME}:latest"
        //         }
        //     }
        // }

        // stage ('Push Artifacts to JFrog') {
        //     agent {
        //         // Docker Image for JFrog-CLI
        //         docker {
        //             image 'releases-docker.jfrog.io/jfrog/jfrog-cli-v2:2.2.0'
        //             reuseNode true
        //         }
        //     }
        //     // credentials will take from the Jenkins Environment Credentials
        //     environment {
        //         CI = true 
        //         // if true, disable interative prompts and progress bar
        //         ARTIFACTORY_ACCESS_TOKEN = credentials('jfrog-token')
        //     }
        //     steps {
        //         script {
        //             echo "pushing artifacts to JFrog"
        //             sh 'jfrog rt upload --url http://3.106.143.229:8082/artifactory --access-token ${ARTIFACTORY_ACCESS_TOKEN} target/*.jar petclinic'
        //         }
        //     }
        // } 

        // stage ('Cleanup') {
        //     steps {
        //         script {
        //             sh "docker rmi ${REPOSITORY_URI}${AWS_ECR_REPO_NAME}:latest"
        //             sh "docker rmi ${REPOSITORY_URI}${AWS_ECR_REPO_NAME}:${IMAGE_TAG}"
        //         }
        //     }
        // }
    }
}