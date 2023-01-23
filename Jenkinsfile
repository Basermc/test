pipeline {
    agent any
    stages {
        stage('Ejecutar script') {
            steps {
                script {
                    sh "bash script.sh  -n ${params.PROJECT} -g ${params.GROUP_SIZE}"
                }
            }
        }
    }
    parameters {
        string(name: 'PROJECT', defaultValue: 'default', description: 'Nombre del proyecto')
        string(name: 'SERVER', defaultValue: 'default', description: 'Nombre del server')
        string(name: 'GROUP_SIZE', defaultValue: '10', description: 'Tamaño del grupo de despliegues')
    }
}
