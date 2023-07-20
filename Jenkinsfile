pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        KUBECONFIG_ID = 'my-kubeconfig'
    }
    stages {
        stage('Build Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'my-aws-creds', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh '''
                     aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 434991223403.dkr.ecr.us-east-1.amazonaws.com
                     docker build -t ngnix .
                     docker tag ngnix:latest 434991223403.dkr.ecr.us-east-1.amazonaws.com/ngnix:latest
                     docker push 434991223403.dkr.ecr.us-east-1.amazonaws.com/ngnix:latest
                    '''
                }
            }
        }
        stage('Deploy to EKS') {
            steps {
                withAWS(credentials: 'my-aws-creds') {
                    withCredentials([file(credentialsId: "${KUBECONFIG_ID}", variable: 'KUBECONFIG')]) {
                        sh "kubectl delete deployment.apps/deployment-2048 -n game-2048"
                        sh "kubectl delete service/service-2048 -n game-2048"
                        sh "kubectl delete ingress/ingress-2048 -n game-2048"
                        sh "kubectl apply -f 2048_full.yaml"
                    }
                }
            }
        }
    }
}
