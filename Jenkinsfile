PROJECT = [['santander-dev']]
SERVER = [['192.168.99.101:8443']]

pipeline {
    agent any
    stages {
        stage('Ejecutar script') {
            steps {
                script {
                    sh "oc login https://192.168.99.101:8443 --token=eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJzYW50YW5kZXItZGV2Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImplbmtpbnMtdG9rZW4tcjlrYzkiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC5uYW1lIjoiamVua2lucyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjM4OGU5YjVkLTkzN2UtMTFlZC1hMDUyLTA4MDAyN2U3ZTU3ZiIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDpzYW50YW5kZXItZGV2OmplbmtpbnMifQ.NxeOejGnh6nWI8NkmEEFvaQNPEkHM4Px-uRdrODQHmy27YIiiaqp5obDYUmiTcLe5j7IgM32N6U_p208fBMZ157RIoD1EZze61tesq-XhZzhUWaN-ylsLOs8Etu__Uxark6JITupE3HjawEHzhM1Wx2KpQOUrN6T5iBnHyEgOnwOmw6KdzknBwKh7H2PaNvrjsiAy0617Qb_TzzYSeE4uNRBjd9yTceqF9xHkWxhDUmMTiUHRUMoMQxLzDkytDIlXpX8J-AYfVzsw1agEiF-3iIKVc2kJsorV_yJR3hvstBN_KpE-m1V5TKJqCQWaVp66Hds9FeB8YjhYCK5k_uYQA --insecure-skip-tls-verify"
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

