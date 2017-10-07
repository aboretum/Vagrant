#!/bin/sh
# This script should be executed by the root user
cd /vagrant
. ./config_import.sh

# Setup required packages
apt-get update
# MySQL server
echo "---- INSTALLING MYSQL SERVER"
echo "mysql-server mysql-server/root_password password $MYSQL_SERVER_ROOT_PASS" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_SERVER_ROOT_PASS" | debconf-set-selections
apt-get install -y mysql-server
# Other packages
echo "---- INSTALLING MISC PACKAGES NEEDED FOR COMPILATION AND EMULATOR EXECUTION"
apt-get install -y p7zip-full build-essential htop gcc g++ automake git-core autoconf make patch cmake libmysql++-dev mysql-server libtool libssl-dev binutils zlibc libc6 libbz2-dev clang

echo "---- FIXING POSSIBLE TIMEZONE PROBLEMS TO AVOID MAKE ERRORS"
echo "$SYSTEM_TIMEZONE" | sudo tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt-get update -qq
sudo apt-get install -qq g++-6
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-6 90
g++   --version
g++-6 --version

sudo apt-get install -y libtbb-dev
export TBB_ROOT_DIR=/usr/include/tbb/

apt-get install -qq libace-dev
export ACE_ROOT=/usr/include/ace/

# Download sources/DB from github - do not overwrite existing ones
cd /vagrant

#echo "---- CLONING (IF NEEDED) GIT REPOSITORIES"
#if [ ! -d "database" ]; then
#    git clone "$GIT_REPO_DATABASE" database
#fi

if [ ! -d "emulator" ]; then
    git clone "$GIT_REPO_CORE" emulator
fi
cd emulator
git submodule init
git submodule update
cd ..
