pipeline {
    agent any
    stages {
        stage('Input Parameters') {
            steps {
                script {
                    def namespace = input message: 'Enter the namespace:', parameters: [string(defaultValue: 'default')]
                    def project = input message: 'Enter the project:', parameters: [string(defaultValue: 'myproject')]
                    def group_size = input message: 'Enter the group size:', parameters: [string(defaultValue: '3')]
                }
            }
        }
        stage('Run Bash Script') {
            steps {
                sh ' bash run_script.sh ${params.NAMESPACE} ${params.PROJECT} ${group_size}'
            }
        }
    }
}
