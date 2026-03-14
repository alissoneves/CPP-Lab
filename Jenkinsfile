pipeline {
    agent { label 'cpp-agent' }

    environment {
        NEXUS_USER = 'admin'
        NEXUS_PASS = '36a9f786-236d-488e-bc77-1694375f34a3'
        NEXUS_URL  = 'http://localhost:8081/repository/cpp-artifacts'
    }

    stages {

        stage('Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/alissoneves/CPP-Lab.git'
            }
        }

        stage('Build') {
            steps {
                sh '''
                rm -rf build
                mkdir build
                cd build
                cmake ..
                make
                '''
            }
        }

        stage('Test') {
            steps {
                sh 'cd build && ctest'
            }
        }

        stage('Upload Artifact') {
            steps {
                sh '''
                # encontra executáveis no build
                BINARIES=$(find build -type f -executable)

                # envia cada um para o Nexus com versionamento
                for FILE in $BINARIES; do
                    BASENAME=$(basename $FILE)
                    echo "Uploading $FILE as ${BASENAME}-build${BUILD_NUMBER}"
                    curl -u $NEXUS_USER:$NEXUS_PASS --upload-file $FILE $NEXUS_URL/${BASENAME}-build${BUILD_NUMBER}
                done
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline finalizada com sucesso! Artifacts enviados para Nexus."
        }
        failure {
            echo "Pipeline falhou. Verifique logs para detalhes."
        }
    }
}
