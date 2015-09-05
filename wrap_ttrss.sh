#!/bin/bash

# Create directories if needed

[[ ! -d /etc/ssl/certs ]] && mkdir -p /etc/ssl/certs
[[ ! -d /etc/ssl/keys ]] && mkdir -p /etc/ssl/keys

if [[ ! -e /etc/ssl/certs/ttrss.cert || -e /etc/ssl/key/ttrss.key ]]; then
	openssl req -x509 -nodes -days 3650 -newkey rsa:4096 \
			-keyout /etc/ssl/keys/ttrss.key \
			-out /etc/ssl/certs/ttrss.cert \
			-batch || { echo "Failed to create the certificate"; exit 1; }
fi

php /configure-db.php

supervisord -c /etc/supervisor/conf.d/supervisord.conf
