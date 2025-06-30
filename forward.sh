#!/bin/bash

# Konfigurasi
SSH_USER="root"
SSH_HOST="134.199.197.80"
LOCAL_PORT="443"
POOL_HOST="ru.hashvault.pro"
POOL_PORT="443"

# Jalankan forwarding
ssh -N -L ${LOCAL_PORT}:${POOL_HOST}:${POOL_PORT} ${SSH_USER}@${SSH_HOST}
