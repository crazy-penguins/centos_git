#!/bin/bash
yum -q updateinfo
yum -y -q install dh-autoreconf curl-devel expat-devel gettext-devel \
  openssl-devel perl-devel zlib-devel zip wget make
yum -y -q install asciidoc xmlto docbook2X
mkdir -p /u/downloads
version=${1:-"2.20.1"}
printf "Building git %s\n" "${version}"
pushd /u/downloads
filename="/u/downloads/git-${version}.tgz"
printf "downloading source bundle\n"
wget -q "https://www.kernel.org/pub/software/scm/git/git-${version}.tar.gz" -O "${filename}" ;
pdir="/u/git-${version}"
mkdir -p "${pdir}"
pushd "${pdir}"
printf "untarring bundle\n"
tar xzf $filename --strip-components=1
printf "\e[32mbuilding!\e[0m\n"
make configure
./configure --prefix=/usr
make all doc
popd
popd
