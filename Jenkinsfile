pipeline {
    agent {
        label 'agent1'
    }
    tools {
        ansible 'ansible'
    }
    environment {
        DOCKER_IMAGE_NAME = "greyabiwon/edureka-devops"
    }
    stages {
        stage("Clone Source") {
            steps {
                git url: 'https://github.com/grey1001/projCert.git'
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
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
    }
}
