#!/usr/bin/env bash
# License: MIT
# Author: James Cherti
# URL: https://github.com/jamescherti/docker-oddmuse

set -e
set -u

# Execute nginx
cd /
rm -f /etc/nginx/sites-enabled/*
ln -sf /etc/nginx/sites-available/oddmuse /etc/nginx/sites-enabled/oddmuse
/usr/sbin/nginx -g 'daemon on; master_process on;' &

# Execute server.pl
ERRNO=0
echo "[ENV] WikiDataDir: $WikiDataDir"
echo "Starting Oddmuse..."
echo "nginx: You can connect to the HTTP server at http://0.0.0.0:80/"
sudo -i -u oddmuse -g oddmuse --preserve-env=WikiDataDir /usr/lib/cgi-bin/server.pl /usr/lib/cgi-bin/wiki.pl 8080 "$WikiDataDir" >/dev/null || ERRNO="$?"
if [[ $ERRNO -ne 0 ]]; then
    echo "[ERROR] 'server.pl' exited with status $ERRNO"
fi
exit "$ERRNO"
