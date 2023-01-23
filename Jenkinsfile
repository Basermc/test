pipeline {
    agent any
    stages {
        stage('Ejecutar script') {
            steps {
                script {
                    def group_size = input message: 'Ingrese el tamaño del grupo', parameters: [[$class: 'StringParameterDefinition', defaultValue: '10', description: 'Tamaño del grupo de despliegues', name: 'GROUP_SIZE']
                    ]
                    sh "sh script.sh ${params.NAMESPACE} ${params.PROJECT} ${group_size}"
                }
            }
        }
    }
    parameters {
        string(name: 'GROUP_SIZE', defaultValue: 'default', description: 'tamaño del grupo')
        string(name: 'PROJECT', defaultValue: 'default', description: 'Nombre del proyecto')
    }
}

