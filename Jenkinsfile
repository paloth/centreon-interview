pipeline {
    agent any
    stages {
        stage('Build') {
            agent {
                docker { image 'rpmbuild/centos7' }
            }
            steps {
                echo 'Building..'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
