# Обновление пакетов
apt-get update -y
apt-get dist-upgrade -y

# Установка утилит
apt-get install -y ufw mc htop rsync curl socat git

# Дать forge право sudo без пароля (drop-in)
echo 'forge ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/forge
chown root:root /etc/sudoers.d/forge
chmod 0440 /etc/sudoers.d/forge
visudo -c

# # Открыть нужные порты и включить UFW
# ufw --force reset
# ufw allow 22
# ufw allow 443
# ufw allow 444
# ufw allow 445
# ufw allow 446
# ufw allow 1080
# ufw allow 62050
# ufw allow 62051
# ufw --force enable
# ufw status numbered

# Клонировать репозиторий ноды
cd /home/forge
git clone https://github.com/sprutadm/Marzban-node
cd Marzban-node

# Установить Docker (официальный скрипт)
# curl -fsSL https://get.docker.com | sh

# Рабочая папка для ноды (дать права только на сам каталог)
# mkdir -p /var/lib/marzban-node
# chown forge:forge /var/lib/marzban-node
# chmod 755 /var/lib/marzban-node

# СКАЧАТЬ КЛИЕНТСКИЙ СЕРТИФИКАТ (добавлено)
bash ./fetch-cert.sh

# # ЗАПУСК КОНТЕЙНЕРА (добавлено)
# docker compose up -d

# Если на сервере есть папка панели, разрешить forge менять только сам каталог (файлы не трогаем)
#[ -d /var/lib/marzban ] && chown forge:forge /var/lib/marzban && chmod 755 /var/lib/marzban || true



