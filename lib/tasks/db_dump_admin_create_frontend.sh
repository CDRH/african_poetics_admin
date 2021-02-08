#!/bin/bash

set -eu

# Options
TASK_DIR=$(dirname $(realpath $0))
PROJECT_DIR=$(dirname $(dirname $TASK_DIR))
SUBDIR="db_dump"
BACKUP_DIR="${PROJECT_DIR}/${SUBDIR}"

# get database configuration
source "${TASK_DIR}/config.sh"

echo "Preparing backup directory"

rm -rf "${BACKUP_DIR}"
umask 007  # 770 dir permissions
mkdir -p "${BACKUP_DIR}"
umask 117  # 660 file permissions

echo "Preparing mysql tables"

innodb_tables="$(mysql -u ${USER} -p${PSWD} -e "SELECT table_name FROM information_schema.tables WHERE table_schema = '${DB_FROM}' AND engine = 'InnoDB';")"

# Removing "table_name" column header from string
innodb_tables="${innodb_tables#table_name}"

echo "Add dump/create/use statements"
echo "DROP DATABASE ${DB_TO};" >> "${BACKUP_DIR}/${DB_TO}.sql"
echo "CREATE DATABASE ${DB_TO};" >> "${BACKUP_DIR}/${DB_TO}.sql"
echo "USE ${DB_TO};" >> "${BACKUP_DIR}/${DB_TO}.sql"

mysqldump -u ${USER} -p${PSWD} --single-transaction "${DB_FROM}" ${innodb_tables} >> "${BACKUP_DIR}/${DB_TO}.sql"

# now that copy of admin database has been created, drop and create frontend database

mysql -u ${USER} -p${PSWD} ${DB_TO} < "${BACKUP_DIR}/${DB_TO}.sql"
