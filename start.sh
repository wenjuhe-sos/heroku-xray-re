#!/bin/sh

# configs
# caddy
mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "User-agent: *\nDisallow: /" > /usr/share/caddy/robots.txt
wget -qO  /usr/share/caddy/index.html $CADDYIndex
wget -qO- $CONFIGCADDY | sed -e "s/\$AUUID/$AUUID/g" > /caddy.json

# xray
wget -qO- $CONFIGXRAY | sed -e "s/\$AUUID/$AUUID/g" -e "s/\$PORT/$PORT/g" > /xray.json

# start
caddy start --config /caddy.json
/xray -config /xray.json
