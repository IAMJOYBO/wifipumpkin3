#!/bin/bash
eval "$(conda shell.bash hook)"
conda activate wifi
wp3 --xpulp " \
set ssid IAMJOYBO; \
set interface wlan0; \
set proxy captiveflask; \
set captiveflask.DarkLogin true; \
ignore pydns_server; \
start
"
