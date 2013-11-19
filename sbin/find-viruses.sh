#!/bin/bash
if [ -z $1 ]; then
  echo "usage: $0 directory"
  exit 1
fi

echo "Preparing filelist..."
rm /tmp/av-php.tmp
find $1 -type f -name *.php > /tmp/av-php.tmp
echo "Searching in php files [1]..."
xargs -d "\n" grep -li "eval(gzin" < /tmp/av-php.tmp
echo "Searching in php files [2]..."
xargs -d "\n" grep -li "eval(base64" < /tmp/av-php.tmp
echo "Searching in php files [3]..."
xargs -d "\n" grep -li "Vvedite hash" < /tmp/av-php.tmp
echo "Searching in php files [4]..."
xargs -d "\n" grep -li 'preg_replace("\/\.\*\/"' < /tmp/av-php.tmp
echo "Searching in php files [5]..."
xargs -d "\n" grep -l '$auth_pass' < /tmp/av-php.tmp
rm /tmp/av-php.tmp

echo "Searching in htaccess..."
find $1 -type f -name .htaccess -exec grep -li "RewriteCond %{HTTP_USER_AGENT} !" {} \;
