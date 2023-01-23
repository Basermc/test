PROJECT = [['santander-dev']]
SERVER = [['192.168.99.101:8443']]

pipeline {
    agent any
    stages {
        stage('Ejecutar script') {
            steps {
                script {
                    sh "bash script.sh  -n ${params.project} -g ${params.group_size} --server=${params.server}"
                }
            }
        }
    }
    parameters {
        string(name: 'project', defaultValue: 'santander-dev', description: 'Nombre del proyecto')
        string(name: 'server', defaultValue: 'localhost:8443', description: 'Nombre del server')
        string(name: 'group_size', defaultValue: '2', description: 'Tamaño del grupo de despliegues')
    }
}
