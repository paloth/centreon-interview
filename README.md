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
