Name: listrepo
Summary: list repositories from a Github organization
Version: 1.0.0
Release: 1%{?dist}

License: GPL
Packager: Paul LOUIS THERESE
URL: https://docs.com

Requires: bash
BuildArch: noarch


%description
This a rpm test to deploy a script that list all visible repository in a Github organization

%prep
%setup -q -n %{name}-%{version}

%build
#Nothing to do 

%install
# TODO
mkdir -p %{buildroot}/%{_bindir}
install -m 0755 %{name} %{buildroot}/%{_bindir}/%{name}

%files
scripts/lsi_repo.sh

%check
#
%changelog
#
