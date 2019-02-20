#!/bin/bash

# Listen for network connections
sed -i \
	-e "s,^Listen localhost.*$,Listen 631," \
	/etc/cups/cupsd.conf

# Allow remote connections
sed -i \
	-e "/<Location \/>/,/<\/Location>/{/<\/Location>/i\ \ Allow all
}" \
	/etc/cups/cupsd.conf

# Allow remote admin
sed -i \
	-e "/<Location \/admin>/,/<\/Location>/{/<\/Location>/i\ \ Allow all
}" \
	-e "/<Location \/admin\/conf>/,/<\/Location>/{/<\/Location>/i\ \ Allow all
}" \
	-e "/<Location \/admin\/log>/,/<\/Location>/{/<\/Location>/i\ \ Allow all
}" \
	/etc/cups/cupsd.conf

# Disable browsing
sed -i \
	-e "s,^Browsing.*,Browsing On," \
	/etc/cups/cupsd.conf

# Allow host<->container proxying
printf "ServerAlias *\n" >> /etc/cups/cupsd.conf

# Log to file, not to journal
printf "ErrorLog /var/log/cups/error_log\n" >> /etc/cups/cupsd.conf
