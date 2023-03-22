# Oddmuse (Wiki engine) - Docker container
#
# License: MIT
# Author: James Cherti
# URL: https://github.com/jamescherti/docker-oddmuse
#

FROM debian:bullseye

ENV WikiDataDir=/data

RUN DEBIAN_FRONTEND="noninteractive" apt-get -q update && \
    # Upgrade
    DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y \
    -o Dpkg::Options::="--force-confnew" --no-install-recommends && \
    \
    # Install
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y \
    -o Dpkg::Options::="--force-confnew" --no-install-recommends \
    nginx \
    coreutils sudo wget w3m perl libwww-perl libxml-rss-perl diffutils \
    libcgi-pm-perl libnet-whois-parser-perl libnet-ip-perl \
    libhttp-server-simple-cgi-prefork-perl && \
    \
    # Clean
    apt-get -q clean -y && \
    rm -fr /var/lib/apt/lists/* && \
    rm -fr /usr/share/doc && \
    rm -f /var/cache/apt/*.bin

RUN mkdir -p /usr/lib/cgi-bin && \
    wget -O /usr/lib/cgi-bin/current.pl \
        https://git.savannah.nongnu.org/cgit/oddmuse.git/plain/wiki.pl && \
    wget -O /usr/lib/cgi-bin/server.pl \
        https://raw.githubusercontent.com/kensanata/oddmuse/main/stuff/server.pl && \
    DEBIAN_FRONTEND="noninteractive" apt-get remove --purge -y wget

COPY nginx-oddmuse.conf /etc/nginx/sites-available/oddmuse
COPY wiki.pl /usr/lib/cgi-bin/wiki.pl

RUN groupadd --gid "1000" oddmuse && \
    useradd -m --gid oddmuse --uid "1000" --shell /bin/bash oddmuse

RUN chmod 755 /usr/lib/cgi-bin/*.pl && \
    mkdir -p "$WikiDataDir" && \
    chown oddmuse:oddmuse "$WikiDataDir"

VOLUME ["/data"]
EXPOSE 80

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh
CMD ["/sbin/entrypoint.sh"]

CMD ["/sbin/entrypoint.sh"]
