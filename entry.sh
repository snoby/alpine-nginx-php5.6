#!/bin/bash


#
# Now let the system start up as normal
#
/usr/bin/php-fpm

/usr/sbin/nginx &

while [ "$END" == '' ]; do
  sleep 2
  trap "END=1" INT TERM
done

echo "Shutting Down..."

trap 'kill $( pgrep -P $$ | tr "\n" " " )' SIGINT SIGTERM EXIT
