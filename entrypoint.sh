#!/usr/bin/env bash
! [ -f /etc/apache2/envvars.default ] && cp /etc/apache2/envvars /etc/apache2/envvars.default
cp /etc/apache2/envvars.default /etc/apache2/envvars
# shellcheck disable=SC2154
echo "export WikiDataDir=$WikiDataDir" >>/etc/apache2/envvars
exec apache2ctl -D FOREGROUND
