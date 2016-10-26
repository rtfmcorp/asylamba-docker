#!/bin/bash

mysql=(mysql -u root )

if [ ! -z "$MYSQL_ROOT_PASSWORD" ]; then
    mysql+=( -p"$MYSQL_ROOT_PASSWORD" )
fi

IFS=',' read -a dbs <<< "$MYSQL_DATABASES"

if [ ${#dbs[@]} -gt 0 ]; then
  for db in "${dbs[@]}"
  do
    if [ "$db" ]; then
      echo create database $db
      echo "CREATE DATABASE IF NOT EXISTS \`$db\` ;" | "${mysql[@]}"
    fi
  done

  if [ "${dbs[0]}" ]; then
    mysql+=( "${dbs[0]}" )
  fi
fi

if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
  if [ ${#dbs[@]} -gt 0 ]; then
    for db in "${dbs[@]}"
    do
      if [ "$db" ]; then
        echo "GRANT ALL ON \`"$db"\`.* TO '"$MYSQL_USER"'@'%' ;" | "${mysql[@]}"
      fi
    done
  fi

  echo 'FLUSH PRIVILEGES ;' | "${mysql[@]}"
fi
