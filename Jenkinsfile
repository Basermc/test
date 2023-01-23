pipeline {
    agent any
    stages {
        stage('Ejecutar script') {
            steps {
                script {
                    sh "bash script.sh -i ${params.NAMESPACE} -p ${params.PROJECT} -g ${params.GROUP_SIZE}"
                }
            }
        }
    }
    parameters {
        string(name: 'PROJECT', defaultValue: 'default', description: 'Nombre del proyecto')
        string(name: 'NAMESPACE', defaultValue: 'default', description: 'Nombre del namespace')
        string(name: 'GROUP_SIZE', defaultValue: '10', description: 'Tamaño del grupo de despliegues')
    }
}
