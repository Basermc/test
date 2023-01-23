PROJECT = [['santander-dev']]
SERVER = [['192.168.99.101:8443']]

pipeline {
    agent none
    options {
        timestamps()
        ansiColor('vga')
        buildDiscader(logRotator(numToKeepStr: '50', artifactNumToKeepStr: '50'))
    }
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
