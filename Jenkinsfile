pipeline {
    agent any
    stages {
        stage('Ejecutar script') {
            steps {
                script {
                    def group_size = input message: 'Ingrese el tamaño del grupo', parameters: [
                        [$class: 'IntegerParameterDefinition', defaultValue: 10, description: 'Tamaño del grupo de despliegues', name: 'GROUP_SIZE']
                    ]
                    sh "sh bash.sh ${group_size}"
                }
            }
        }
    }
}


