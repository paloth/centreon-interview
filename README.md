# centreon-interview

RPM BUILD
```
%prep
%setup -q -n doesn't work
```

Launch local command
```
docker build -t rpm-builder . > /dev/null && docker run --rm -v "$(pwd)"/artifacts:/artifacts -e VERSION=1 -e RELEASE=0 -e PACKAGE="list_repo" --user rpmbuild rpm-builder
```

Doc

https://rpm-packaging-guide.github.io/#rpm-macros
http://saule1508.github.io/build-rpm-with-docker/
https://opensource.com/article/18/9/how-build-rpm-packages
https://docs.fedoraproject.org/en-US/packaging-guidelines/RPMMacros/
