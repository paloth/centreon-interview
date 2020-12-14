# Source: saule1508
FROM centos:centos7

RUN yum -y install rpm-build redhat-rpm-config make gcc git vi tar unzip rpmlint && yum clean all
#User creation to run rpmbuild
RUN useradd rpmbuild -u 5002 -g users -p rpmbuild
WORKDIR /home/rpmbuild
#Copy file for the build
#RpmBuild script
COPY scripts/build.sh ./build.sh
#File to package
COPY scripts/list_repo.sh ./src/list_repo.sh
#Build spec for rpmbuild
COPY build/build.spec ./build.spec

USER root
RUN chmod +x build.sh

USER rpmbuild
ENV HOME /home/rpmbuild
RUN mkdir -p /home/rpmbuild/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
RUN echo '%_topdir %{getenv:HOME}/rpmbuild' > /home/rpmbuild/.rpmmacros

ENTRYPOINT [ "/home/rpmbuild/build.sh" ]
