#!/bin/bash
if [ -z $1 ]; then
  echo "usage: $0 directory"
  exit 1
fi

echo "Searching in php files [001]..."
find $1 -type f -name *.php | xargs -d "\n" -n1 -P8 grep -liFf "./db/001.txt"

echo "Preparing filelist..."
rm /tmp/av-php.tmp
find $1 -type f -name *.php > /tmp/av-php.tmp
echo "Searching in php files [6]..."
xargs -d "\n" -n1 -P8 grep -li 'lzw_decompress(' < /tmp/av-php.tmp
echo "Searching in php files [7]..."
xargs -d "\n" -n1 -P8 grep -lie 'TrustlinkClient\|SAPE_base\|SAPE_client' < /tmp/av-php.tmp
echo "Searching in php files [10]..."
xargs -d "\n" -n1 -P8 grep -lie "base64_decode([\"']" < /tmp/av-php.tmp
rm /tmp/av-php.tmp

echo "Searching in htaccess..."
find $1 -type f -name .htaccess -exec grep -li "RewriteCond %{HTTP_USER_AGENT} !" {} \;

echo "Finished!"