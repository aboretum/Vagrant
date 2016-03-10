#!/bin/sh
export HTTP_PROXY=""
export HTTPS_PROXY=""

export GIT_REPO_DATABASE="https://github.com/NostalriusTBC/Database.git"
export GIT_REPO_CORE="https://github.com/NostalriusTBC/Core.git"
export GIT_REPO_SCRIPTS="https://github.com/NostalriusTBC/Scripts.git"
export MYSQL_SERVER_ROOT_PASS="root"
export INSTALL_PREFIX="/home/vagrant"
export VAGRANT_VM_CORES=`nproc`
export CORES_FOR_MAKE=`echo "$VAGRANT_VM_CORES * 3 / 2" |bc`
export CORE_DIRECTORY="/vagrant/emulator"
export DATABASE_DIRECTORY="/vagrant/database"
export VAGRANT_SCRIPTS_DIR="/vagrant"