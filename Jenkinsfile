pipeline {
    agent {
        label 'agent1'
    }
    tools {
        ansible 'ansible'
    }
    environment {
        DOCKER_IMAGE_NAME = "greyabiwon/edureka-devops"
        CONTAINER_NAME = "my-container"
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
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        
        stage('Deploy Container') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        def app = docker.image(DOCKER_IMAGE_NAME)
                        def container = app.run("-d", "--name", CONTAINER_NAME)
                        // Additional deployment steps
                    }
                }
            }
        }
    }
}
