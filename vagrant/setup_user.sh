#!/bin/sh
# This script should be executed by a basic (non root) user
. /vagrant/config.sh

echo "---- SERVER WILL BE SETTED UP IN $INSTALL_PREFIX"
# create mysql users
cd /vagrant/emulator/sql/create
echo "---- RESETING DATABASES / USERS"
cat db_drop_mysql.sql | mysql -uroot --force -p"$MYSQL_SERVER_ROOT_PASS" mysql
echo "FLUSH PRIVILEGES;" | mysql -uroot --force -p"$MYSQL_SERVER_ROOT_PASS" mysql
echo "---- CREATING MYSQL USERS"
cat db_create_mysql.sql | mysql -uroot -p"$MYSQL_SERVER_ROOT_PASS"
echo "FLUSH PRIVILEGES;" | mysql -uroot --force -p"$MYSQL_SERVER_ROOT_PASS" mysql
cd /vagrant/emulator/sql/base
mysql -uroot -p"$MYSQL_SERVER_ROOT_PASS" characters < characters.sql
mysql -uroot -p"$MYSQL_SERVER_ROOT_PASS" realmd < realmd.sql

# import database
echo "---- IMPORTING DATABASE"
# @TODO: Move this to the Database git repo ?
cd /vagrant/database/Current_Release
# -- Current Release - FullDB
cat Full_DB/TBCDB_1.4.0_cmangos-tbc_s1982_SD2-TBC_s2720.sql | mysql -uroot -p"$MYSQL_SERVER_ROOT_PASS" mangos
# -- Current Release - Updates
export SQL_TMP_DIR="$INSTALL_PREFIX/ToBeApplied.tmp"
rm -rf "$SQL_TMP_DIR"
mkdir "$SQL_TMP_DIR"
cp Updates/*corepatch_mangos*.sql Updates/*updatepack*.sql "$SQL_TMP_DIR" # cross partitions ln not supported
cat "$SQL_TMP_DIR"/*.sql | mysql -uroot -p"$MYSQL_SERVER_ROOT_PASS" mangos
# -- Latest updates
cd /vagrant/database/
cat Updates/*.sql | mysql -uroot -p"$MYSQL_SERVER_ROOT_PASS" mangos

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
cmake -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" /vagrant/emulator
make -j"$CORES_FOR_MAKE" install # Only 2 cores on the Vagrant !

# Setup config if not already done
cd "$INSTALL_PREFIX/etc"

if [ ! -e "mangosd.conf" ]; then
    cp mangosd.conf.dist mangosd.conf
    echo "DataDir = \"/vagrant/data\"" >> mangosd.conf
fi

if [ ! -e "realmd.conf" ]; then
    cp realmd.conf.dist realmd.conf
fi
