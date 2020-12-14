#!/bin/bash

cd /home/rpmbuild
if [ ! -f ./build.spec ]; then
    echo Sorry, can not find rpm spec file
    exit 1
fi
cp build.spec $HOME/rpmbuild/SPECS
# here I patch the spec file to feed it with the version and the release and the date
# sed -i -e "s/##VERSION##/${VERSION}/" -e "s/##RELEASE##/${RELEASE}/" /home/rpmbuild/rpmbuild/SPECS/${PACKNAME}.spec
# sed -i -e "s/##DATE##/$(date +\"%a %b %d %Y\")/" /home/rpmbuild/rpmbuild/SPECS/${PACKNAME}.spec

# prepare a tar.gz file with the sources and copy it  to the SOURCES directory
tar -zcf listrepo.tar.gz ./src
cp listrepo.tar.gz $HOME/rpmbuild/SOURCES/

# then execute the rpmbuild command
cd $HOME/rpmbuild

ls -al

rpmbuild -ba ./SPECS/build.spec
# copy the rpms to the artifact directory, for jenkins.
if [[ -d /artifacts ]]; then
    cp ./RPMS/noarch/*.rpm /artifacts/
fi
