#!/usr/bin/env bash
set -euo pipefail


# Открыть нужные порты и включить UFW
ufw --force reset
ufw allow 22
ufw allow 443
ufw allow 444
ufw allow 445
ufw allow 446
ufw allow 1080
ufw allow 62050
ufw allow 62051
ufw --force enable
ufw status numbered

# Рабочая папка для ноды (дать права только на сам каталог)
# mkdir -p /var/lib/marzban-node
# chown forge:forge /var/lib/marzban-node
# chmod 755 /var/lib/marzban-node

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

# Небольшая валидация формата (PEM)
if ! head -n1 "$DEST_FILE" | grep -q '-----BEGIN'; then
  echo "Предупреждение: файл $DEST_FILE не похож на PEM (нет заголовка '-----BEGIN')." >&2
fi

echo "Сертификат сохранён в $DEST_FILE"

# Установить Docker (официальный скрипт)
curl -fsSL https://get.docker.com | sh

# ЗАПУСК КОНТЕЙНЕРА (добавлено)
# docker compose up -d
# --- Compose up ---
# Предполагается, что скрипт вызывается из каталога с docker-compose.yml (ты делаешь 'cd Marzban-node' в рецепте).
docker compose pull
docker compose up -d
docker compose ps