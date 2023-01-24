PROJECT = [['santander-dev']]
SERVER = [['192.168.99.101:8443']]

pipeline {
    agent any
    stages {
        stage('Ejecutar script') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'github-secret', variable: 'GITHUB_SECRET')]) {
                      sh "oc login https://192.168.99.101:8443 --token=$JENKINS_TOKEN --insecure-skip-tls-verify"
                      sh "bash script.sh  -p ${params.project} -g ${params.group_size}"
                    }
                }
            }
        }
    }
    parameters {
        string(name: 'project', defaultValue: 'santander-dev', description: 'Nombre del proyecto')
        string(name: 'group_size', defaultValue: '2', description: 'Tamaño del grupo de despliegues')
    }
}


