#!/usr/bin/env bash
# License: MIT
# Author: James Cherti
# URL: https://github.com/jamescherti/docker-oddmuse

if ! [ -f /etc/apache2/envvars.default ]; then
    cp /etc/apache2/envvars /etc/apache2/envvars.default
fi

cp /etc/apache2/envvars.default /etc/apache2/envvars

{
    echo 'export APACHE_RUN_GROUP=oddmuse'
    echo 'export APACHE_RUN_USER=oddmuse'
    # shellcheck disable=SC2154
    echo "export WikiDataDir=$WikiDataDir"
} >>/etc/apache2/envvars

exec apache2ctl -D FOREGROUND
