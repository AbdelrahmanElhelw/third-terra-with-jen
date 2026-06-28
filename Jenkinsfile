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
                withCredentials([
                    usernamePassword(
                        credentialsId: 'AWS',
                        usernameVariable: 'AWS_ACCESS_KEY_ID',
                        passwordVariable: 'AWS_SECRET_ACCESS_KEY'
            )
        ]) {
                sh """
                    terraform init
                    terraform plan --var-file=${params.ENVIRONMENT}.tfvars
                """
            }
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
            emailext(
            to: 'abdoelhelw5@gmail.com',
            subject: "Build Result: ${currentBuild.currentResult}",
            body: """
            Job: ${env.JOB_NAME}
            Build: #${env.BUILD_NUMBER}
            Environment: ${params.ENVIRONMENT}
            Result: ${currentBuild.currentResult}
            """
        )
    }
        }
    }
}

