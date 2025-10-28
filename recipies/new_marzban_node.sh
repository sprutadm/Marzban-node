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



# Клонировать репозиторий ноды
cd /home/forge
git clone https://github.com/sprutadm/Marzban-node
cd Marzban-node


# bash ./fetch-cert.sh
cd /home/forge/Marzban-node/scripts

bash ./ufw-ports.sh
bash ./get-sert.sh




