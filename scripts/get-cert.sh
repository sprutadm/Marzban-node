#!/usr/bin/env bash
set -euo pipefail


cd /home/forge/Marzban-node

CERT_URL="http://46.101.135.141/crt/for.py"
DEST_DIR="/var/lib/marzban-node"
DEST_FILE="${DEST_DIR}/ssl_client_cert.pem"

mkdir -p "$DEST_DIR"
chown forge:forge "$DEST_DIR"
chmod 755 "$DEST_DIR"

TMP_FILE=$(mktemp)

# Скачиваем во временный файл
curl -fsSL "$CERT_URL" -o "$TMP_FILE"

# Переименовываем как нужно
mv "$TMP_FILE" "$DEST_FILE"

# Выставляем владельца и права
chown forge:forge "$DEST_FILE"
chmod 640 "$DEST_FILE"


# Проверки
if [[ ! -s "$DEST_FILE" ]]; then
  echo "Ошибка: файл не существует или пустой: $DEST_FILE" >&2
  exit 1
fi


echo "Сертификат сохранён в $DEST_FILE"