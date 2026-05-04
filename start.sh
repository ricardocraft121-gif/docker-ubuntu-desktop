#!/bin/bash

echo "🛠️ 1. Preparando entorno en contenedor vacío..."
mkdir -p /var/run/tailscale
mkdir -p /var/cache/tailscale
mkdir -p /var/lib/tailscale

echo "⚙️ 2. Arrancando el motor de Tailscale (tailscaled)..."
tailscaled \
  --tun=userspace-networking \
  --socks5-server=localhost:1055 \
  --state=/var/lib/tailscale/tailscaled.state &

sleep 5

echo "🔑 3. Autenticando la máquina en la red privada..."
# ¡TOKEN DIRECTO AQUÍ! Reemplaza con tu token real
tailscale up --authkey="tskey-auth-PON_TU_CLAVE_AQUI" --hostname=railway-proxy

PORT="${PORT:-2222}"
echo "✅ 4. TÚNEL ACTIVO: Escuchando en el puerto TCP $PORT de Railway"

exec socat TCP-LISTEN:${PORT},fork,reuseaddr EXEC:"nc -X 5 -x 127.0.0.1:1055 github-vps 22"
