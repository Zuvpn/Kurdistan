#!/usr/bin/env bash
set -e

APP="KURDISTAN WireGuard PRO"
VERSION="3.1.0"

BASE_DIR="/etc/kurdistan"
PROFILES_DIR="$BASE_DIR/profiles"
TELEGRAM_FILE="$BASE_DIR/telegram.conf"
CRON_FILE="/etc/cron.d/kurdistan-wg"
WG_DIR="/etc/wireguard"

mkdir -p $PROFILES_DIR $WG_DIR

require_root() {
  if [[ $EUID -ne 0 ]]; then
    echo "Run with sudo"
    exit 1
  fi
}

send_telegram() {
  [[ -f "$TELEGRAM_FILE" ]] || return
  source "$TELEGRAM_FILE"
  curl -s -X POST "https://api.telegram.org/bot${TOKEN}/sendMessage"     -d chat_id="${CHATID}"     -d text="$1" > /dev/null 2>&1
}

install_deps() {
  apt update -y
  apt install -y wireguard-tools curl whiptail
}

create_profile() {
  read -p "Interface name (wg0): " IFACE
  read -p "Local Tunnel IP (10.0.0.1): " LOCAL_IP
  read -p "Peer Tunnel IP (10.0.0.2): " PEER_IP
  read -p "Listen Port (51820): " PORT
  read -p "Peer Public Key: " PEER_KEY
  read -p "Endpoint (IP:PORT): " ENDPOINT

  PRIV=$(wg genkey)
  PUB=$(echo $PRIV | wg pubkey)

cat > $WG_DIR/$IFACE.conf <<EOF
[Interface]
Address = $LOCAL_IP/32
ListenPort = $PORT
PrivateKey = $PRIV

[Peer]
PublicKey = $PEER_KEY
AllowedIPs = $PEER_IP/32
Endpoint = $ENDPOINT
PersistentKeepalive = 25
EOF

  chmod 600 $WG_DIR/$IFACE.conf
  systemctl enable wg-quick@$IFACE
  systemctl restart wg-quick@$IFACE

  echo "Local PublicKey: $PUB"
}

setup_telegram() {
  read -p "Bot Token: " TOKEN
  read -p "Chat ID: " CHATID
  echo "TOKEN=$TOKEN" > $TELEGRAM_FILE
  echo "CHATID=$CHATID" >> $TELEGRAM_FILE
}

install_cron() {
cat > $CRON_FILE <<EOF
*/5 * * * * root systemctl restart wg-quick@wg0
0 9 * * * root echo "Daily WG check" | wall
EOF
}

menu() {
while true; do
clear
echo "$APP v$VERSION"
echo "1) Install Dependencies"
echo "2) Create WireGuard Profile"
echo "3) Configure Telegram"
echo "4) Install Monitoring (Cron)"
echo "5) Exit"
read -p "Select: " opt
case $opt in
1) install_deps ;;
2) create_profile ;;
3) setup_telegram ;;
4) install_cron ;;
5) exit ;;
esac
done
}

require_root
menu
