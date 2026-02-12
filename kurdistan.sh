#!/usr/bin/env bash
set -e

BASE_DIR="/etc/kurdistan"
SYSTEMD_DIR="/etc/systemd/system"
BACKUP_DIR="/etc/kurdistan/backups"
STATE_DIR="/etc/kurdistan/state"
TELEGRAM_FILE="/etc/kurdistan/telegram.conf"

mkdir -p $BASE_DIR $BACKUP_DIR $STATE_DIR

require_root() {
  if [[ $EUID -ne 0 ]]; then
    echo "Run with sudo"
    exit 1
  fi
}

# ================= TELEGRAM =================

send_telegram() {
  if [[ -f "$TELEGRAM_FILE" ]]; then
    source $TELEGRAM_FILE
    MSG="$1"
    curl -s -X POST "https://api.telegram.org/bot${TOKEN}/sendMessage" \
      -d chat_id="${CHATID}" \
      -d text="$MSG" > /dev/null
  fi
}

setup_telegram() {
  TOKEN=$(whiptail --inputbox "Telegram Bot Token:" 10 60 3>&1 1>&2 2>&3)
  CHATID=$(whiptail --inputbox "Telegram Chat ID:" 10 60 3>&1 1>&2 2>&3)
  echo "TOKEN=$TOKEN" > $TELEGRAM_FILE
  echo "CHATID=$CHATID" >> $TELEGRAM_FILE
  chmod 600 $TELEGRAM_FILE
}

# =============== PROFILE MGMT ===============

create_profile() {
  NAME=$(whiptail --inputbox "Profile Name:" 10 60 3>&1 1>&2 2>&3)
  CMD=$(whiptail --inputbox "ExecStart Command:" 12 80 3>&1 1>&2 2>&3)

  echo "$CMD" > "$BASE_DIR/$NAME.conf"

  cat > "$SYSTEMD_DIR/kurdistan-$NAME.service" <<EOF
[Unit]
Description=Kurdistan Profile - $NAME
After=network-online.target

[Service]
Type=simple
ExecStart=$CMD
Restart=always
RestartSec=3
LimitNOFILE=1048576
StandardOutput=append:/var/log/kurdistan-$NAME.log
StandardError=append:/var/log/kurdistan-$NAME.log

[Install]
WantedBy=multi-user.target
EOF

  systemctl daemon-reload
  systemctl enable --now kurdistan-$NAME
}

list_profiles() {
  ls $BASE_DIR 2>/dev/null | sed 's/.conf//'
}

# =============== UPTIME =====================

get_uptime() {
  NAME=$1
  START=$(systemctl show -p ActiveEnterTimestamp kurdistan-$NAME | cut -d= -f2)
  [[ -z "$START" ]] && echo "N/A" && return

  START_TS=$(date -d "$START" +%s)
  NOW_TS=$(date +%s)
  DIFF=$((NOW_TS - START_TS))

  echo "$((DIFF/3600))h $(( (DIFF%3600)/60 ))m"
}

# =============== HEALTHCHECK ================

healthcheck() {
  NAME=$1
  STATE_FILE="$STATE_DIR/$NAME.down"

  if systemctl is-active --quiet kurdistan-$NAME; then
    rm -f $STATE_FILE
  else
    if [[ ! -f "$STATE_FILE" ]]; then
      touch $STATE_FILE
      LOG=$(tail -n 20 /var/log/kurdistan-$NAME.log 2>/dev/null)
      send_telegram "🚨 $NAME DOWN!\n\nLast Logs:\n$LOG"
    fi
    systemctl restart kurdistan-$NAME
  fi
}

# =============== DAILY REPORT ===============

daily_report() {
  REPORT="📊 Daily Kurdistan Report\n\n"

  for NAME in $(list_profiles); do
    if systemctl is-active --quiet kurdistan-$NAME; then
      STATUS="✅ Active"
    else
      STATUS="❌ Down"
    fi

    UPTIME=$(get_uptime $NAME)
    REPORT+="• $NAME → $STATUS | Uptime: $UPTIME\n"
  done

  send_telegram "$REPORT"
}

# =============== CRON SETUP =================

install_cron() {
cat > /etc/cron.d/kurdistan-monitor <<EOF
*/5 * * * * root /usr/local/bin/kurdistan monitor
0 9 * * * root /usr/local/bin/kurdistan daily
EOF
chmod 644 /etc/cron.d/kurdistan-monitor
}

# =============== COMMAND HANDLER ============

if [[ "$1" == "monitor" ]]; then
  for NAME in $(list_profiles); do
    healthcheck $NAME
  done
  exit
fi

if [[ "$1" == "daily" ]]; then
  daily_report
  exit
fi

# =============== MENU =======================

main_menu() {
  while true; do
    OPTION=$(whiptail --title "KURDISTAN PRO v2" --menu "Select Option" 20 70 12 \
    "1" "Create Profile" \
    "2" "Remove Profile" \
    "3" "Show Uptime" \
    "4" "Configure Telegram" \
    "5" "Install Monitoring (Cron)" \
    "6" "Backup Profiles" \
    "7" "Restore Backup" \
    "0" "Exit" \
    3>&1 1>&2 2>&3)

    case $OPTION in
      1) create_profile ;;
      2)
        NAME=$(whiptail --inputbox "Profile Name:" 10 60 3>&1 1>&2 2>&3)
        systemctl disable --now kurdistan-$NAME 2>/dev/null || true
        rm -f $SYSTEMD_DIR/kurdistan-$NAME.service
        rm -f $BASE_DIR/$NAME.conf
        ;;
      3)
        NAME=$(whiptail --inputbox "Profile Name:" 10 60 3>&1 1>&2 2>&3)
        whiptail --msgbox "Uptime: $(get_uptime $NAME)" 8 40
        ;;
      4) setup_telegram ;;
      5) install_cron ;;
      6)
        FILE="$BACKUP_DIR/backup-$(date +%F-%H%M).tar.gz"
        tar -czf $FILE $BASE_DIR
        whiptail --msgbox "Backup Saved:\n$FILE" 10 60
        ;;
      7)
        FILE=$(ls $BACKUP_DIR | whiptail --menu "Select Backup" 20 60 10 $(ls $BACKUP_DIR) 3>&1 1>&2 2>&3)
        tar -xzf $BACKUP_DIR/$FILE -C /
        ;;
      0) exit ;;
    esac
  done
}

require_root
main_menu