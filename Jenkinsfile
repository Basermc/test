pipeline {
    agent any
    parameters{
        string(
            name: "namespace",
            defaultValue:"",
            description:"",
            )
        int(
            name: "group_size",
            defaultValue:"",
            description:"",
            )
        string(
            name: "project",
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
