pipeline {
    agent any
    stages {
        stage('Ejecutar script') {
            steps {
                script {
                    def group_size = input message: 'Ingrese el tamaño del grupo', parameters: [[$class: 'StringParameterDefinition', defaultValue: '10', description: 'Tamaño del grupo de despliegues', name: 'GROUP_SIZE']
                    ]
                    sh "sh script.sh -i ${params.NAMESPACE} -p ${params.PROJECT} -g ${group_size}"
                }
            }
        }
    }
    parameters {
        string(name: 'PROJECT', defaultValue: 'default', description: 'Nombre del proyecto')
        string(name: 'NAMESPACE', defaultValue: 'default', description: 'Nombre del namespace')
    }
}
