PROJECT = [['santander-dev']]
SERVER = [['192.168.99.101:8443']]

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
        string(name: 'PROJECT', defaultValue: 'santander-dev', description: 'Nombre del proyecto')
        string(name: 'SERVER', defaultValue: 'localhost:8443', description: 'Nombre del server')
        string(name: 'GROUP_SIZE', defaultValue: '2', description: 'Tamaño del grupo de despliegues')
    }
}
