pipeline {
    agent { label 'cpp-agent' }
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
    }
}
