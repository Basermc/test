pipeline {
    agent none
    options {
        timestamps()
        ansiColor('vga')
        buildDiscarder(logRotator(numToKeepStr: '50', artifactNumToKeepStr: '50'))
    }
    parameters {
        string(
            name: "STASK",
            defaultValue: "" ,
            description: "Git Comments or Task ID",
        )
        choice(
            name: 'ENVIROMENT',
            choices: ['pre-uat','pre-stg','pro'],
            description: 'Enviroment to Deploy',
        )
        choice(
            name: 'SELECTOR',
            choices: ['local','global'],
            description: 'Region to Deploy Restart',
        )
        choice(
            name: 'INTERVAL',
            choices: ['3','5','15','30','45','60'],
            description: 'Time interval in seconds of each restart of Deplpoyments',
        )
        string(
            name: "LABEL",
            defaultValue: "template=bwce" ,
            description: 'Label selector zone=ita,zone=global, app_name=usa-recruiting-infor-application, "app_name in (usa-recruiting-infor-application,deu-inbound-loga-application)" ',
        )
    }
    stages {
        stage('Approve Deploy') {
            agent none
            options {
                skipDefaultCheckout true
                ansiColor('vga')
            }
            steps {
                echo "\033[36m Approve Deploy on ${ENVIROMENT.toUpperCase()}? \033[0m"
                script{
                    currentBuild.displayName = "#$BUILD_NUMBER Restart ${STASK} on ${ENVIROMENT.toUpperCase()} in ${SELECTOR} PaaS"
                    currentBuild.description = "Restart ${STASK} for ${LABEL} pods in ${ENVIROMENT.toUpperCase()} on ${SELECTOR} PaaS"
                }
                input message: 'Approve Deploy ?', submitter: approvers
            }
        }
        stage('Select Enviroment Vars') {
            agent {
                node {
                    label 'base'
                }
            }
            options {
                skipDefaultCheckout true
                ansiColor('vga')
            }
            steps {
                script {
					(INDEX_REGION,ENV_DEPLOY,APP_CONFIG_PROFILE) = environmentSelector()
					PROJECT_NEW = PROJECT[INDEX_REGION]
					TOKEN_NEW = TOKEN[INDEX_REGION]
					OSE3_DEPLOY_REGION = PROJECT_URL[INDEX_REGION]
                    if (SELECTOR =='global'){
                        index_enviroment= 1
                        echo "\n \033[36m This is a global enviroment \033[0m \n"
                    }
                    else{
                        index_enviroment= 0
                        echo "\n \033[36m This is a local enviroment \033[0m \n"
                    }
					if (ENVIROMENT == 'payroll'){
                        OSE3_DEPLOY_PROJECT = PROJECT_NEW
                        OSE3_TOKEN_PROJECT = TOKEN_NEW
                        if (SELECTOR==local){
                            echo "\033[44m Restart in Payroll only global Region \033[0m"
                        }
                        else{
                            echo "\033[31m You only restart global PaaS in Payroll enviroment. \033[0m"
                            currentBuild.result = 'ABORTED'
                            error('\033[31m You only restart global PaaS in Payroll enviroment\033[0m')
                        }
                    }
                    else {
                    OSE3_DEPLOY_PROJECT = PROJECT_NEW[index_enviroment]
                    OSE3_TOKEN_PROJECT = TOKEN_NEW[index_enviroment]
                    }
                }
            }
		}
        stage('Download k8s bin') {
            agent {
                node {
                    label 'ansible'
                }
            }
            options {
                ansiColor('vga')
            }
            steps {
                sh "ansible-playbook -i inventories/custom oc-util.yml --limit localhost -e \"propeties_path='${env.WORKSPACE}'\" "
                sh "./oc version"
//                 sh "./helm version"
                script{
//                    if (ENVIROMENT == 'pre-stg' && SELECTOR == 'global' ){
//                        OSE3_DEPLOY_REGION= ["api.gsc04.gsc.pre.cn1.paas.cloudcenter.corp:6443"]
//                    }
                    for (int i = 0; i < OSE3_DEPLOY_REGION.size() ; ++i) {
                        withCredentials([string(credentialsId: OSE3_TOKEN_PROJECT[i], variable: 'token')]) {
                            sh "bash script.sh -s ${OSE3_DEPLOY_REGION[i]} -t ${token.trim()} -p ${OSE3_DEPLOY_PROJECT} -i ${INTERVAL} -l ${LABEL}"
                        }
                    }
                     try{
                        withCredentials([
                            string(credentialsId: SNOW_PASS , variable: 'snow_password'),
                            sshUserPrivateKey(credentialsId: 'snow-python-api-key', keyFileVariable: 'SSH_KEY1')
                        ])
                        {
                            sh ("ansible-playbook -i inventories/custom snow-util.yml --tags 'state,stask' -e \" git_hub_file=$SSH_KEY1 password=$snow_password snow_path=${env.WORKSPACE} stask=${env.STASK} stask_flag=true \" ")
                        }
                    }
                    catch (err){
                        echo "\033[31m Wrong STASK NUMBER $RLS. \033[0m"
                        currentBuild.result = 'ABORTED'
                        error('\033[31m The requested STASK number is not correct. \033[0m')
                    }
                }
            }
            post {
                always {
//                     input message: 'Approve Deploy on Production?',
//                     parameters: [
//                         [$class: 'ChoiceParameterDefinition', description:'Select Version of Artifact',
//                             name:'artifact', choices: "1.0\n1.2\n1.3\n1.4\n1.5"
//                         ],
//                         [$class: 'ChoiceParameterDefinition', description:'Select Properties Version',
//                             name:'properties', choices: "1.36\n1.26\n1.48\n1.96\n1.33"
//                         ]
//                     ]
//                     echo properties
//                     echo artifact
// 	                emailext attachmentsPattern: 'pod.log', attachLog: true,
// 	                    body: 'Check configuartion for deployment',
// 	                    from: 'onehr-workday@gruposantander.com', subject: 'test', to:'carlos.rodriguezvergel@ust.com'
                    cleanWs()
                }
            }
        }
        stage('Approve Deploy to PRO') {
            agent none
            options {
                skipDefaultCheckout true
                ansiColor('vga')
            }
            when {
                expression {
                    ENVIROMENT == 'pre-stg'
                }
            }
            steps {
                script{
                    echo "\033[36m Approve Deploy  on Production? \033[0m "
                    env.PROSTASK = input message: 'Approve Deploy on Production?', submitter: approvers,
                                    parameters: [string(defaultValue: '',
                                                description: 'Number of STASK in PRO',
                                                name: 'PRO-STASK')]
                }
                 build(job: JOB_NAME, parameters: [
                        string(name: 'SELECTOR', value: SELECTOR),
                        string(name: 'INTERVAL', value: INTERVAL),
						string(name: 'STASK', value: "${env.PROSTASK}"),
                        string(name: 'LABEL', value: LABEL),
                        string(name: 'ENVIROMENT', value: 'pro'),
						], propagate: true
				)
            }
        }
	}
}
