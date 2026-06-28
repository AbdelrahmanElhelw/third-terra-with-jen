pipeline {
    agent any

    parameters {
        choice(
            name: 'ENVIRONMENT',
            choices: ['test', 'stage', 'prod'],
            description: 'Select the environment'
        )
    }

    stages {

        stage('Terraform Plan') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'AWS_CRED'
                ]]) {
                sh """
                    terraform init
                    terraform plan -var-file=${params.ENVIRONMENT}.tfvars
                """
            }
        }

        stage('Manual Approval') {
            steps {
                input(
                    message: "Apply Terraform changes to ${params.ENVIRONMENT}?",
                    ok: "Approve"
                )
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }

        aborted {
            echo 'Pipeline was aborted!'
        }

        always {
            echo 'Pipeline finished.'
        }
    }
}
