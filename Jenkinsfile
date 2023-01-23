pipeline {
    agent any
    parameters{
        string(
            name: "namespace",
            defaultValue:"",
            description:"",
            )
    }
    stages {

        stage('Ejecutar script') {
            steps {
                sh 'bash script.sh'
            }
        }
    }
}
