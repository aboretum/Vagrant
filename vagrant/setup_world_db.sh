#!/bin/sh
# This script outputs queries to be executed to create a clean database

cd "$DATABASE_DIRECTORY/Current_Release"
# -- Current Release - FullDB
cat Full_DB/TBCDB_1.4.0_cmangos-tbc_s1982_SD2-TBC_s2720.sql
# -- Current Release - Updates
export SQL_TMP_DIR="$INSTALL_PREFIX/ToBeApplied.tmp"
rm -rf "$SQL_TMP_DIR"
mkdir "$SQL_TMP_DIR"
cp Updates/*corepatch_mangos*.sql Updates/*updatepack*.sql "$SQL_TMP_DIR" # cross partitions ln not supported
cat "$SQL_TMP_DIR"/*.sql
# -- Latest updates
cd "$DATABASE_DIRECTORY/"
cat Updates/*.sql
cat Updates/Custom_Data/*.sql
