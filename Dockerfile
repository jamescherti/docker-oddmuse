# Oddmuse (Wiki engine) - Docker container
#
# License: MIT
# Author: James Cherti
# URL: https://github.com/jamescherti/docker-oddmuse
#

FROM debian:bullseye-slim
LABEL Description="Docker image for Oddmuse (Wiki engine)"
LABEL org.opencontainers.image.authors="James Cherti"

ENV WikiDataDir=/data
ENV ODDMUSE_URL_PATH=/wiki

RUN DEBIAN_FRONTEND="noninteractive" apt-get -q update && \
    DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y \
    -o Dpkg::Options::="--force-confnew" --no-install-recommends && \
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y \
    -o Dpkg::Options::="--force-confnew" --no-install-recommends \
    apache2 \
    coreutils sudo wget w3m perl libwww-perl libxml-rss-perl diffutils \
    libcgi-pm-perl libnet-whois-parser-perl libnet-ip-perl \
    libhttp-server-simple-cgi-prefork-perl && \
    apt-get -q clean -y && \
    rm -fr /var/lib/apt/lists/* && \
    rm -fr /usr/share/doc && \
    rm -f /var/cache/apt/*.bin

RUN wget -O /usr/lib/cgi-bin/wiki.pl \
        https://git.savannah.nongnu.org/cgit/oddmuse.git/plain/wiki.pl

RUN groupadd --gid "1000" oddmuse && \
    useradd -m --gid oddmuse --uid "1000" --shell /bin/bash oddmuse
    mkdir -p "$WikiDataDir" && \
    chown oddmuse:oddmuse "$WikiDataDir" && \
    chmod 755 /usr/lib/cgi-bin/*.pl && \
    rm -f /etc/apache2/sites-enabled/* && \
    a2enmod cgid && \
    a2ensite oddmuse

COPY apache2-oddmuse.conf /etc/apache2/sites-available/oddmuse.conf

VOLUME ["/data"]
EXPOSE 80

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh
WORKDIR /data
CMD ["/sbin/entrypoint.sh"]
