pipeline {
    agent { label 'cpp-agent' }

    environment {
        // Credenciais do Nexus
        NEXUS_USER = 'admin'
        NEXUS_PASS = 'Caldo1234' 
        
        // Endereço do Registry Docker (Porta 5001 que abrimos)
        DOCKER_REGISTRY = '127.0.0.1:5001'
        IMAGE_NAME = 'cpp-lab-app'
        IMAGE_TAG  = "${env.BUILD_NUMBER}"
        
        // Mantemos a URL antiga se você ainda quiser o backup do binário puro
        NEXUS_RAW_URL = 'http://localhost:8081/repository/cpp-artifacts'
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/alissoneves/CPP-Lab.git'
            }
        }

        stage('Test') {
            steps {
                sh 'cd build && ctest'
            }
        }

        stage('Docker Login') {
    steps {
        sh "echo ${NEXUS_PASS} | docker login ${DOCKER_REGISTRY} -u ${NEXUS_USER} --password-stdin"
    }
}

        stage('Docker Build & Push') {
            steps {
                script {
                    // 1. Constrói a imagem Docker. 
                    // O ponto (.) indica que o Dockerfile está na raiz do projeto.
                    sh "docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} ."
                    sh "docker tag ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"

                    // 2. Envia para o repositório Docker do Nexus
                    sh "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Kubernetes Deploy') {
            steps {
                script {
                    // Este comando atualiza o Deployment no Kubernetes para usar a nova imagem.
                    // Nota: O deployment 'cpp-app' precisa ter sido criado manualmente uma vez antes.
                    sh "kubectl set image deployment/cpp-lab cpp-lab=${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }

    post {
        success {
            echo "Sucesso! Imagem v${IMAGE_TAG} disponível no Nexus e Deploy realizado."
        }
        failure {
            echo "A pipeline falhou. Verifique se o Docker está logado e o Nexus está online."
        }
    }
}