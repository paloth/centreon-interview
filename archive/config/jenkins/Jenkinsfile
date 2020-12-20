node {
    try {
        stage('Clone repository') {
            checkout scm
        }

        stage('Setup') {
            echo 'Setup environment'
            sh 'if [ ! -d artifacts ]; then mkdir artifacts; fi'
        }

        stage('Build Container') {
            echo 'Building container for RPM builder'
            docker.build("rpm-build")
        }

        stage('Build RPM') {
            echo 'Start container for RPM builder'
            docker.image('rpm-build:latest').withRun('-v "$(pwd)"/artifacts/:/artifacts -e VERSION=1 -e RELEASE=0 -e PACKAGE="list_repo" --user 0'){
                c -> sh "docker logs ${c.id}"
            }    
        }
    }
    catch (e) {
        echo 'An error occured'
        throw e
    }
    finally {
        sh 'ls -al artifacts/'
        sh 'rm -rf artifacts'
     }
}
