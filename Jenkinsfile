node {
    try {
        stage('Clone repository') {
            /* Let's make sure we have the repository cloned to our workspace */
            checkout scm
        }

        stage('Setup') {
            /* Let's make sure we have the repository cloned to our workspace */
            echo 'Setup environment'
            sh 'if [ ! -d artifacts ]; then mkdir artifacts; fi'
            sh 'ls -al'
        }

        stage('Build image') {
            /* This builds the actual image; synonymous to
            * docker build on the command line */
            echo 'Building container'
            docker.build("rpm-build")
        }

        stage('Test image') {
            /* Ideally, we would run a test framework against our image.
            * For this example, we're using a Volkswagen-type approach ;-) */
            docker.image('rpm-build:latest').withRun('-v artifacts/:/home/rpmbuild/artifacts -e VERSION=1 -e RELEASE=0 -e PACKAGE="list_repo" --user rpmbuild'){c -> sh "docker logs ${c.id}"}    
        }
    }
    catch (e) {
        echo 'This will run only if failed'
        throw e
    }
    finally {
        sh 'ls -al artifacts'
        sh 'rm -rf artifacts'
     }
}
