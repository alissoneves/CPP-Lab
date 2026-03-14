pipeline {
    agent { label 'cpp-agent' }

    environment {
        NEXUS_URL = "http://localhost:8081/repository/cpp-artifacts"
        NEXUS_USER = "admin"
        NEXUS_PASS = "36a9f786-236d-488e-bc77-1694375f34a3 "
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
                curl -u $NEXUS_USER:$NEXUS_PASS \
                --upload-file build/cpp-lab \
                $NEXUS_URL/app-build$BUILD_NUMBER
                '''
            }
        }

    }
}
