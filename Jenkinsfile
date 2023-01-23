pipeline {
    agent any
    parameters {
        string(name: 'NAMESPACE', defaultValue: 'default', description: 'Nombre del namespace')
        string(name: 'PROJECT', defaultValue: 'default', description: 'Nombre del proyecto')
        int(name: 'GROUP_SIZE', defaultValue: 10, description: 'Tamaño del grupo de despliegues')
    }
    stages {
        stage('Ejecutar script') {
            steps {
                script {
                    sh "sh script.sh ${params.NAMESPACE} ${params.PROJECT} ${params.GROUP_SIZE}"
                }
            }
        }
    }
}
