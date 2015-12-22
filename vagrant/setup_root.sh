#!/bin/sh
# This script should be executed by the root user
. /vagrant/config.sh

# Setup required packages
apt-get update
# MySQL server
echo "mysql-server mysql-server/root_password password $MYSQL_SERVER_ROOT_PASS" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $MYSQL_SERVER_ROOT_PASS" | debconf-set-selections
apt-get install -y mysql-server
# Other packages
apt-get install -y p7zip-full build-essential htop gcc g++ automake git-core autoconf make patch cmake libmysql++-dev mysql-server libtool libssl-dev binutils zlibc libc6 libbz2-dev clang

# Download sources/DB from github - do not overwrite existing ones
cd /vagrant

if [ ! -d "database" ]; then
    git clone "$GIT_REPO_DATABASE" database
fi

if [ ! -d "emulator" ]; then
    git clone "$GIT_REPO_CORE" emulator
fi
cd emulator
git submodule init
git submodule update
cd ..

cd emulator/src
if [ ! -d "scriptdev2" ]; then
    git clone "$GIT_REPO_SCRIPTS" scriptdev2
fi
