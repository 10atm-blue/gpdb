#!/bin/bash

set -x

# Install needed packages. Please add to this list if you discover additional prerequisites.
sudo yum install -y epel-release
sudo yum install -y \
    apr-devel \
    bison \
    bzip2-devel \
    cmake3 \
    mlocate \
    glibc-common \
    flex \
    gcc \
    gcc-c++ \
    krb5-devel \
    libcurl-devel \
    libevent-devel \
    libkadm5 \
    libyaml-devel \
    libxml2-devel \
    perl-ExtUtils-Embed \
    python-devel \
    python-paramiko \
    python-pip \
    python-psutil \
    python-setuptools \
    readline-devel \
    xerces-c-devel \
    zlib-devel

sudo pip install --upgrade pip
sudo pip install lockfile conan

#  link cmake3 to cmake
sudo ln -sf ../../bin/cmake3 /usr/local/bin/cmake
# sudo sh -c "echo '/usr/local/lib' >> /etc/ld.so.conf"
# sudo sh -c "/usr/local/lib64' >> /etc/ld.so.conf"
# sudo echo "/usr/local/lib" >> /etc/ld.so.conf
# sudo echo "/usr/local/lib64" > /etc/ld.so.conf
# echo /usr/local/lib > /etc/ld.so.conf.d/libc.conf

#sudo bash -c 'echo -e "/usr/local/lib\n/usr/local/lib64\n/usr/local" > /etc/ld.so.conf.d/libc.conf'


updatedb


# install packages needed to build and run GPDB
sudo yum -y groupinstall "Development tools"
sudo yum -y install ed
sudo yum -y install net-tools
sudo yum -y install readline-devel
sudo yum -y install zlib-devel
sudo yum -y install curl-devel
sudo yum -y install bzip2-devel
sudo yum -y install python-devel
sudo yum -y install apr-devel
sudo yum -y install libevent-devel
sudo yum -y install openssl-libs openssl-devel
sudo yum -y install libyaml libyaml-devel
sudo yum -y install htop
sudo yum -y install perl-Env
sudo yum -y install ccache
sudo yum -y install libffi-devel
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo pip install psutil lockfile paramiko setuptools
rm get-pip.py

# Misc
sudo yum -y install vim mc psmisc
sudo yum -y reinstall glibc-common

# GCC
sudo yum -y install centos-release-scl
sudo yum-config-manager --enable rhel-server-rhscl-7-rpms
sudo yum -y install devtoolset-6
sudo yum -y update scl-utils
bash -c 'echo -e "source scl_source enable devtoolset-6" >> ~/.bash_profile'
scl enable devtoolset-6 bash
source scl_source enable devtoolset-6
# source /opt/rh/devtoolset-6/enable
# echo 'source scl_source enable devtoolset-6' >> ~/.bash_profile
gcc --version


sudo chown -R vagrant:vagrant /usr/local








