# Build RPM

This is about building a rpm inside a container on a jenkins agent.

## Resources

### Scripts

The folder scripts contains shell scripts files

#### list_repo.sh

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

#### build.sh

This script is the entrypoint of the container environment that build the rpm. It based on the [saule1508 work](http://saule1508.github.io/build-rpm-with-docker/)

It sets up the package before the build:

- Change values in the build.spec with `sed`
- Package the sources in a tar.gz
- Copy the package in the SOURCES directory of the **RPMBUILD** environment 

The build script run the rpmbuild command and copy the artifact into the `/artifcacts` directory

### Build

The folder build contains the build.spec that describe the information and steps necessary for rpmbuild

The first part describe the information provided to the rpm. This section is pretty explicit but here is the description of some parameters:

-Source0 is the tar.gz prepared for the build. It is stored in the SOURCES directory of the **RPMBUILD** environment
-BuildRoot is the path where rpmbuild while build the package

In the *install* section is a shell script executed at the installation step

The *post* section runs after the installation step.

The *files* section contains all the file include in the rpm (Need to go deeper for this section)

### Dockerfile



RPM BUILD
```
%prep
%setup -q -n doesn't work
```

Launch local command
```
docker build -t rpm-builder . > /dev/null && docker run --rm -v "$(pwd)"/artifacts:/artifacts -e VERSION=1 -e RELEASE=0 -e PACKAGE="list_repo" --user rpmbuild rpm-builder
```

Sources

https://rpm-packaging-guide.github.io/#rpm-macros
http://saule1508.github.io/build-rpm-with-docker/
https://opensource.com/article/18/9/how-build-rpm-packages
https://docs.fedoraproject.org/en-US/packaging-guidelines/RPMMacros/
