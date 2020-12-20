Name: {{package}}
Summary: list repositories from a Github organization
Version: {{version}}
Release: {{release}}
License: GPL
Packager: Paul LOUIS THERESE
URL: https://docs.com
Requires: bash
Requires: jq
Requires: curl
BuildArch: noarch
Source0: %{name}.tar.gz
BuildRoot: %(mktemp -ud %{_tmppath}/%{name}_%{version}-%{release}-XXXXXX)

%description
This a rpm test to deploy, %{name}, a script that list all visible repository in a Github organization

%install
rm -rf %{buildroot}
install -d $RPM_BUILD_ROOT/%{name}
cp -r $HOME/src  $RPM_BUILD_ROOT/%{name}

%post
echo " "
echo "install done, you can execute the %{name} scripts"

%files
/
