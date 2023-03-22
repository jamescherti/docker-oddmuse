#!/usr/bin/perl
# License: MIT
# Author: James Cherti
# URL: https://github.com/jamescherti/docker-oddmuse

package OddMuse;
$DataDir = $_ENV{'WikiDataDir'};
do '/usr/lib/cgi-bin/current.pl';
