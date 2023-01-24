PROJECT = [['santander-dev']]
SERVER = [['192.168.99.101:8443']]

pipeline {
    agent any
    stages {
        stage('Ejecutar script') {
            steps {
                script {
                    sh "bash script.sh  -p ${params.project} -g ${params.group_size}"
                }
            }
        }
    }
    parameters {
        string(name: 'project', defaultValue: 'santander-dev', description: 'Nombre del proyecto')
        string(name: 'group_size', defaultValue: '2', description: 'Tamaño del grupo de despliegues')
    }
}
