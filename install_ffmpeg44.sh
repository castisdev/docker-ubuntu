#!/bin/bash -e
set -x #echo on
apt -y install libxml2-dev libsdl2-dev libasound2-dev libxv-dev libx11-dev libxext-dev autoconf automake libtool yasm nasm bzip2; apt clean
cd ~
wget -nv --no-check-certificate https://ffmpeg.org/releases/ffmpeg-4.4.tar.bz2
tar xf ffmpeg-4.4.tar.bz2
cd ffmpeg-4.4

./configure --enable-libxml2 --enable-shared
make install -j$(nproc)
echo "/usr/local/lib" >> /etc/ld.so.conf.d/ffmpeg.conf
ldconfig

cd ~
rm -rf ffmpeg-4.4*
