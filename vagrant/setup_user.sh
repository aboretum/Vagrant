#!/bin/sh
# This script should be executed by a basic (non root) user
cd /vagrant/
. ./config_import.sh

#echo "---- SERVER WILL BE SETTED UP IN $INSTALL_PREFIX"
## create mysql users
#cd "$CORE_DIRECTORY/sql/create"
#echo "---- RESETING DATABASES / USERS"
#cat db_drop_mysql.sql | mysql -uroot --force -p"$MYSQL_SERVER_ROOT_PASS" mysql
#echo "FLUSH PRIVILEGES;" | mysql -uroot --force -p"$MYSQL_SERVER_ROOT_PASS" mysql
#echo "---- CREATING MYSQL USERS"
#cat db_create_mysql.sql | mysql -uroot -p"$MYSQL_SERVER_ROOT_PASS"
#echo "FLUSH PRIVILEGES;" | mysql -uroot --force -p"$MYSQL_SERVER_ROOT_PASS" mysql
#cd "$CORE_DIRECTORY/sql"
#mysql -uroot -p"$MYSQL_SERVER_ROOT_PASS" characters < characters.sql
#mysql -uroot -p"$MYSQL_SERVER_ROOT_PASS" realmd < logon.sql
#
## import database
#echo "---- IMPORTING WORLD DATABASE"
#cd "$VAGRANT_SCRIPTS_DIR"
#. ./setup_world_db.sh | mysql -uroot -p"$MYSQL_SERVER_ROOT_PASS" mangos


echo "---- BUILDING SERVER FROM SOURCE"
# build server
cd "$INSTALL_PREFIX"
if [ ! -d "build" ]; then
    mkdir "build"
fi
if [ ! -d "logs" ]; then
    mkdir "logs"
fi

cd build
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
sudo cmake -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" /vagrant/emulator
sudo make -j"$CORES_FOR_MAKE" # Only 2 cores on the Vagrant !

# Setup config if not already done
cd "$INSTALL_PREFIX/etc"

if [ ! -e "mangosd.conf" ]; then
    cp mangosd.conf.dist mangosd.conf
    echo "DataDir = \"/vagrant/data\"" >> mangosd.conf
fi

if [ ! -e "realmd.conf" ]; then
    cp realmd.conf.dist realmd.conf
fi
