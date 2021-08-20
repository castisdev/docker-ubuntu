#!/bin/bash -e
set -x #echo on
apt -y install libbz2-dev valgrind-dbg; apt clean
cd ~
wget -nv --no-check-certificate https://boostorg.jfrog.io/artifactory/main/release/1.77.0/source/boost_1_77_0.tar.gz
tar xzf boost_1_77_0.tar.gz
cd boost_1_77_0

./bootstrap.sh --prefix=/usr/local/boost_1_77_0
./b2 --without-python -j$(nproc) install

./bootstrap.sh --prefix=/usr/local/boost_1_77_0_valgrind
./b2 --without-python -j$(nproc) valgrind=on install

cd ~
rm -rf boost_*
