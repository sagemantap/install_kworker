#!/bin/bash

# Konfigurasi
SSH_USER="root"
SSH_HOST="your_droplet_ip"
LOCAL_PORT="3333"
POOL_HOST="eth.pool.example.com"
POOL_PORT="4444"

# Jalankan forwarding
ssh -N -L ${LOCAL_PORT}:${POOL_HOST}:${POOL_PORT} ${SSH_USER}@${SSH_HOST}
