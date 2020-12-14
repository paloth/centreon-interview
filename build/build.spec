Name: listrepo
Summary: list repositories from a Github organization
Version: 1
Release: 1

License: GPL
Packager: Paul LOUIS THERESE
URL: https://docs.com

Requires: bash
BuildArch: noarch
Source0: %{name}.tar.gz
BuildRoot: %(mktemp -ud %{_tmppath}/%{name}_%{version}-%{release}-XXXXXX)

%description
This a rpm test to deploy, %{name}, a script that list all visible repository in a Github organization

%prep


%install
rm -rf %{buildroot}
install -d $RPM_BUILD_ROOT/opt/mypackage
cp -r $HOME/src  $RPM_BUILD_ROOT/opt/mypackage

%clean
rm -rf %{buildroot}

%post
echo " "
echo "install done, you can execute the install.sh scripts"

%files
%defattr(754,oracle,oinstall,754)
%dir /opt/mypackage
/opt/mypackage

%attr(750,oracle,oinstall) /opt/mypackage/install.sh
