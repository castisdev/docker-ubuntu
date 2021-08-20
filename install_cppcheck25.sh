#!/bin/bash -e
set -x #echo on
cd ~
apt -y install bzip2; apt clean
wget -nv --no-check-certificate --content-disposition https://github.com/danmar/cppcheck/archive/2.5.tar.gz
tar xf cppcheck-2.5.tar.gz
cd cppcheck-2.5
mkdir build;cd build;cmake ..;make install -j$(nproc)
cd ~
rm -rf cppcheck*
