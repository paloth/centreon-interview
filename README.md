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
