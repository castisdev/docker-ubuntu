# Pull base image
FROM ubuntu:20.04

LABEL org.opencontainers.image.source https://github.com/castisdev/docker-ubuntu

ARG DEBIAN_FRONTEND=noninteractive

# Install
RUN apt update; apt install -y apt-utils; apt install -y \
  sudo \
  wget \
  build-essential \
  unzip \
  libssl-dev \
  libicu-dev \
  git \
  subversion \
  tar \
  libboost-dev \
  uuid-dev \
  valgrind \
  libcurl4-openssl-dev \
  curl \
  xz-utils \
  file \
  vim \
  sysstat \
  psmisc \
  libgoogle-perftools-dev \
  iproute2 \
  net-tools \
  ccache \
  libunwind-dev; \
  apt clean

ADD install_cmake3211.sh /script/
RUN /script/install_cmake3211.sh

ADD install_boost177.sh /script/
RUN /script/install_boost177.sh
ENV Boost_DIR /usr/local/boost_1_77_0

RUN apt install -y libcrypto++-dev; apt clean

ADD install_googletest1110.sh /script/
RUN /script/install_googletest1110.sh

RUN apt install -y python3-pip python2; apt clean; pip3 install -U websocket-client

RUN pip3 install gcovr cpplint

ADD install_cppcheck25.sh /script/
RUN /script/install_cppcheck25.sh

RUN apt install -y zsh; chsh -s /usr/bin/zsh; sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

RUN apt install -y ninja-build

ADD install_ffmpeg44.sh /script/
RUN /script/install_ffmpeg44.sh

# set timezone
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

# ctail
RUN wget -O - https://raw.githubusercontent.com/castisdev/ctail/master/install.sh --no-check-certificate | bash

# Set environment variables
ENV HOME /root

# Define default command
CMD ["zsh"]
