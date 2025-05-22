pipeline {
    agent any

    stages {
        stage('Scan dextrusui Image') {
            steps {
                sh '''
                docker pull public.ecr.aws/n9g8r8n8/dextrusui:qa-release-1.6
                docker run --rm --env TRIVY_TIMEOUT=30m \
                    -v /var/run/docker.sock:/var/run/docker.sock \
                    -v $(pwd):/output \
                    -v $(pwd)/custom-html.tpl:/custom-html.tpl \
                    aquasec/trivy image \
                    --severity HIGH,CRITICAL \
                    --format template \
                    --template "@/custom-html.tpl" \
                    --output /output/dextrusui:qa-release-1.6.html \
                    public.ecr.aws/n9g8r8n8/dextrusui:qa-release-1.6
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
