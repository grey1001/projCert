pipeline {
    agent {
        label 'agent1'
    }
    tools {
        jdk 'myjava'
        ansible 'ansible'
    }
    environment {
        DOCKER_IMAGE_NAME = "greyabiwon/edureka-devops"
    }
    stages {
        stage("Checkout Source") {
            steps {
                git url: 'https://github.com/grey1001/projCert.git'
            }
        }
        stage('Execute playbook') {
            steps {
                echo 'Installing Docker on agent'
                ansiblePlaybook(
                    become: true,
                    credentialsId: 'ansiblemaster',
                    disableHostKeyChecking: true,
                    installation: 'ansible',
                    inventory: '/etc/ansible/hosts',
                    playbook: '/home/user2/playbook.yml'
                )
            }
        }
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    def app = docker.build(DOCKER_IMAGE_NAME)
                    app.inside {
                        sh 'echo Hello, World!'
                    }
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
    }
}
