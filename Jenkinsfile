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
            steps {
                script {
                    def app = docker.image(DOCKER_IMAGE_NAME)
                    docker.withRegistry('https://registry.hub.docker.com', '0aee2bc9-4266-4bf6-8106-1bb49fbc3ea0') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        
        stage('Deploy Container') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', '0aee2bc9-4266-4bf6-8106-1bb49fbc3ea0') {
                        def app = docker.image(DOCKER_IMAGE_NAME)
                        // Additional deployment steps
                    }
                }
            }
        }
    }
}
