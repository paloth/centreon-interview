#!/bin/bash

cd /home/rpmbuild
if [ ! -f ./build.spec ]; then
    echo Sorry, can not find rpm spec file
    exit 1
fi

cp build.spec $HOME/rpmbuild/SPECS
# here I patch the spec file to feed it with the version and the release and the date
sed -i $HOME/rpmbuild/SPECS/build.spec \
    -e "s/{{package}}/${PACKAGE}/g" \
    -e "s/{{version}}/${VERSION}/g" \
    -e "s/{{release}}/${RELEASE}/g"
# -e "s/{{date}}/$(date +\"%a %b %d %Y\")/" \

# prepare a tar.gz file with the sources and copy it  to the SOURCES directory
tar -zcf ${PACKAGE}.tar.gz ./src
cp ${PACKAGE}.tar.gz $HOME/rpmbuild/SOURCES/

# then execute the rpmbuild command
cd $HOME/rpmbuild

rpmbuild -ba ./SPECS/build.spec
# copy the rpms to the artifact directory, for jenkins.
if [[ -d $HOME/artifacts ]]; then
    cp ./RPMS/noarch/${PACKAGE}*.rpm $HOME/artifacts/
fi
