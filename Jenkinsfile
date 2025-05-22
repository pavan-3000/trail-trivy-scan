pipeline {
    agent any

    environment {
        IMAGE_NAME = "public.ecr.aws/n9g8r8n8/dextrusui:qa-release-1.6"
        TEMPLATE_FILE = "trivy_custom_template.tpl"
        REPORT_FILE = "dextrusui_qa-release-1.6.html"
    }

    stages {
        stage('Trivy Vulnerability Scan') {
            steps {
                echo "Scanning image: ${IMAGE_NAME}"
                sh '''
                # Ensure template is in the current directory
                if [ ! -f "${TEMPLATE_FILE}" ]; then
                  echo "ERROR: Template file not found: ${TEMPLATE_FILE}"
                  exit 1
                fi

                docker pull ${IMAGE_NAME}

                docker run --rm \
                    --env TRIVY_TIMEOUT=30m \
                    -v /var/run/docker.sock:/var/run/docker.sock \
                    -v $(pwd):/output \
                    aquasec/trivy image \
                    --severity HIGH,CRITICAL \
                    --format template \
                    --template "/output/${TEMPLATE_FILE}" \
                    --output "/output/${REPORT_FILE}" \
                    ${IMAGE_NAME}
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '*.html', fingerprint: true
        }
    }
}
