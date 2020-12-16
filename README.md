# BUILD RPM

This is about building a rpm inside a container on a jenkins agent.

## RESOURCES

### SCRIPTS

The folder scripts contains shell scripts files

#### LIST_REPOS.SH

This script call the github api to output an organization repositories.  
To use the script launch the command `./list_repo.sh OrganisationName`

Inputs
- Organisation Name (Mandatory)
  - must be the first input provided
- Token (Optional)
  - If you need to execute the script with an authentication to the github api, a application token can be provided

Output

Here is an example of the formatted script output

```
./list_repo.sh organization
organization repositories list

Name                                               Language             License
aws.dynamodb                                       R                    NS
aws.s3                                             R                    NS

NS = Not Specified
```

#### BUILD.SH

This script is the entrypoint of the container environment that build the rpm. It based on the [saule1508 work](http://saule1508.github.io/build-rpm-with-docker/)

It sets up the package before the build:

- Change values in the build.spec with `sed`
- Package the sources in a tar.gz
- Copy the package in the SOURCES directory of the **RPMBUILD** environment 

The build script run the rpmbuild command and copy the artifact into the `/artifcacts` directory
---
### BUILD

The folder build contains the build.spec that describe the information and steps necessary for rpmbuild

The first part describe the information provided to the rpm. This section is pretty explicit but here is the description of some parameters:

-Source0 is the tar.gz prepared for the build. It is stored in the SOURCES directory of the **RPMBUILD** environment
-BuildRoot is the path where rpmbuild while build the package

In the *install* section is a shell script executed at the installation step

The *post* section runs after the installation step.

The *files* section contains all the file include in the rpm (Need to go deeper for this section)

---
### DOCKERFILE

This dockerfile will build the environment to run rpmbuild. It based on the [saule1508 work](http://saule1508.github.io/build-rpm-with-docker/)

After installing the necessary tool in the container (based on centos7) a user is created to run rpmbuild.  
The script and build files are copied into the `/home/rpmbuild/`
The user root is used to run the command `chmod +x` on the build script so rpmbuild user will be able to execute it.  
The build environment for rpmbuild is set in the `$HOME/rpmbuild/` 
The `echo '%_topdir %{getenv:HOME}/rpmbuild' > /home/rpmbuild/.rpmmacros`

The `build.sh` is set as entrypoint. When we run the container the script will be ran automatically.  

---
### JENKINSFILE

The container will be ran by a Jenkins agent and Jenkinsfile describe the pipeline to process.

#### NODE

Node block indicate that the is a scripted pipeline, that can be written in Groovy code

#### TRY / CATCH / FINALLY

**Try** execute the code and if an error occurs **Catch** is executed. Whatever happens **Finally** is executed at the end.

#### STAGES

These block are steps in the pipeline. The steps are executed from the top to the bottom.
In the stages we can write code to execute actions.

- sh are shell command
- docker is a library to execute docker actions in the Jenkins pipeline
  - build will build a docker image from a dockerfile (at the root of the repository)
  - image will run a container form a specified image
    - withRun is the args list to provide to docker run

docker.image block receive the line `c -> sh "docker logs ${c.id}"` where `c` is the container object passed to a shell command to get the container's logs where `${c.id}` is the container's id.

---
## BLOCKING POINTS

RPM build container permission to write into jenkins fs. Not able to copy the rpm artifacts outside the container.

---
## IMPROVMENTS

Build

- Add variable to the build for version, release, changelog

Jenkins

---



Launch local command
```
docker build -t rpm-builder . > /dev/null && docker run --rm -v "$(pwd)"/artifacts:/artifacts -e VERSION=1 -e RELEASE=0 -e PACKAGE="list_repo" --user rpmbuild rpm-builder
```

## SOURCES

- https://rpm-packaging-guide.github.io/#rpm-macros  
- http://saule1508.github.io/build-rpm-with-docker/  
- https://opensource.com/article/18/9/how-build-rpm-packages  
- https://docs.fedoraproject.org/en-US/packaging-guidelines/RPMMacros/  
- https://www.thegeekstuff.com/2015/02/rpm-build-package-example/  
