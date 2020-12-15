pipeline {
    agent none
    stages {
        stage('Setup'){
            steps{
                echo 'Setup environment'
                mkdir artifacts
            }
        }
        stage('Build') {
            steps {
                echo 'Building container'
                docker.build("rpm-build")
            }
        }
        stage('Test') {
            agent {
                docker { 
                    image 'rpm-build'
                    args '-v "$(pwd)"/artifacts:/artifacts'
                    args '-e VERSION=1'
                    args '-e RELEASE=0'
                    args '-e PACKAGE="list_repo"'
                    args '--user rpmbuild'
                 }
            }
            steps {
                echo 'Running building container..'
            }
        }
        stage('Deploy') {
            steps {
                ls -al artifacts/
            }
        }
    }
}

