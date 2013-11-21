#!/bin/bash
if [ -z $1 ]; then
  echo "usage: $0 directory"
  exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Searching in php files [001]..."
find $1 -type f -name *.php | xargs -d "\n" -n1 -P8 grep -liFf "$DIR/db/001.txt"

echo "Searching possibilities in php files [101]..."
find $1 -type f -name *.php | xargs -d "\n" -n1 -P8 grep -liFf "$DIR/db/101.txt" | grep -Fvf "$DIR/db/101x.txt"

echo "Searching for bad js files..."
find $1 -type f -name *.js | xargs -d "\n" -n1 -P8 grep -li "^<?php"

echo "Searching in js files [201]..."
find $1 -type f -name *.js | xargs -d "\n" -n1 -P8 grep -liFf "$DIR/db/201.txt"

echo "Searching in htaccess..."
find $1 -type f -name .htaccess | xargs -d "\n" -n1 -P8 grep -li "RewriteCond %{HTTP_USER_AGENT} !"

echo "Finished!"