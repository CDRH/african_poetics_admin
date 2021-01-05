#!/bin/bash

set -eu

# Notes
# Variables left unquoted when list of tables of 'for' loop
# and passed to mysqldump, so expanded & not treated as one long string

# Options
PROJECT_DIR="/var/local/www/rails/african_poetics-in_the_news"
QUIET=0
SUBDIR="db_dump"

# get database configuration
source "${PROJECT_DIR}/lib/tasks/config.sh"

readonly BACKUP_DIR="${PROJECT_DIR}/${SUBDIR}"
readonly QUIET
readonly SUBDIR


echo "Preparing backup directory"

rm -rf "${BACKUP_DIR}"

# Prep directory
umask 007  # 770 dir permissions
mkdir -p "${BACKUP_DIR}"

umask 117  # 660 file permissions

echo "Preparing log.txt"

if [[ ${QUIET} -eq 1 ]]; then
  # Redirect stderr to screen, stdout to log file
  exec 2>&1 >"${BACKUP_DIR}/log.txt"
fi

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

