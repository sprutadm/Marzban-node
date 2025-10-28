# # Обновление пакетов
apt-get update -y
apt-get dist-upgrade -y

# Ждем завершения всех обновлений
while fuser /var/lib/dpkg/lock >/dev/null 2>&1 || fuser /var/lib/apt/lists/lock >/dev/null 2>&1; do
    echo "Waiting for apt to finish..."
    sleep 1
done

# # Установка утилит
apt-get install -y ufw mc rsync curl socat git jq net-tools unzip

# Еще раз проверяем завершение apt операций
while fuser /var/lib/dpkg/lock >/dev/null 2>&1 || fuser /var/lib/apt/lists/lock >/dev/null 2>&1; do
    echo "Waiting for apt to finish..."
    sleep 1
done

# # Дать forge право sudo без пароля (drop-in)
echo 'forge ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/forge
chown root:root /etc/sudoers.d/forge
chmod 0440 /etc/sudoers.d/forge
visudo -c

# Даем системе немного стабилизироваться после установки пакетов
sleep 2

# Клонировать репозиторий ноды
cd /home/forge
# Проверяем, не существует ли уже репозиторий
if [ -d "Marzban-node" ]; then
    echo "Directory Marzban-node already exists, removing it..."
    rm -rf Marzban-node
fi
git clone https://github.com/sprutadm/Marzban-node
chown -R forge:forge /home/forge/Marzban-node
cd Marzban-node

# Проверяем, что репозиторий успешно склонирован
if [ ! -d "scripts" ]; then
    echo "Error: Failed to clone repository or scripts directory not found"
    exit 1
fi

bash scripts/ufw-ports.sh
bash scripts/get-cert.sh
bash scripts/marzban-node-local.sh install
