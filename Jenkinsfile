pipeline {
    agent any

    environment {
        IMAGE_NAME = "public.ecr.aws/n9g8r8n8/dextrusui:qa-release-1.6"
        TEMPLATE = "trivy_custom_template.tpl"
        OUTPUT = "dextrusui_qa-release-1.6.html"
    }

    stages {
        stage('Trivy Scan') {
            steps {
                script {
                    sh '''
                    echo "Pulling image..."
                    docker pull ${IMAGE_NAME}

                    echo "Running Trivy scan with custom HTML template..."
                    docker run --rm \
                      --env TRIVY_TIMEOUT=30m \
                      -v /var/run/docker.sock:/var/run/docker.sock \
                      -v $(pwd):/output \
                      aquasec/trivy image \
                      --severity HIGH,CRITICAL \
                      --format template \
                      --template /output/${TEMPLATE} \
                      --output /output/${OUTPUT} \
                      ${IMAGE_NAME}
                    '''
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '*.html', fingerprint: true
        }
    }
}
