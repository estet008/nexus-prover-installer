#!/bin/bash

set -e

# ---------------------------
# Nexus Prover Installer (Ubuntu 22.04+)
# Підтримка через Docker з glibc >=2.39
# ---------------------------

# Запит Node ID у користувача
read -p "🔢 Введіть ваш NODE ID: " NODE_ID
NODE_ID=$(echo "$NODE_ID" | tr -d '[:space:]' | sed 's/[^a-zA-Z0-9_-]//g')

# Перевірка на порожній ввід
if [[ -z "$NODE_ID" ]]; then
  echo "❌ Помилка: Node ID не може бути порожнім або містити недійсні символи"
  exit 1
fi

IMAGE_NAME="nexus-prover-$NODE_ID"

# Крок 1: Підготовка директорії
mkdir -p ~/nexus-prover && cd ~/nexus-prover

# Крок 2: Створення Dockerfile
cat <<EOF > Dockerfile
FROM ubuntu:24.04

RUN apt update && apt install -y \
    curl unzip ca-certificates \
    libssl-dev libcurl4-openssl-dev \
    tzdata

RUN useradd -ms /bin/bash prover
USER prover
WORKDIR /home/prover

RUN mkdir -p /home/prover/.nexus/bin
RUN curl -L https://cli.nexus.xyz/ | sh

COPY entrypoint.sh /home/prover/entrypoint.sh
RUN chmod +x /home/prover/entrypoint.sh

ENTRYPOINT ["/home/prover/entrypoint.sh"]
EOF

# Крок 3: Створення скрипта запуску в контейнері
cat <<EOF > entrypoint.sh
#!/bin/bash

NODE_ID=\${NODE_ID:-"$NODE_ID"}

/home/prover/.nexus/bin/nexus-network start --node-id \$NODE_ID
EOF

# Крок 4: Побудова Docker-образу
sudo docker build -t $IMAGE_NAME .

# Крок 5: Створення системного сервісу для автозапуску після перезавантаження
SERVICE_NAME="nexus-docker-prover"
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"

sudo tee $SERVICE_FILE > /dev/null <<EOF
[Unit]
Description=Nexus Prover Docker Container
After=docker.service
Requires=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker start -a nexus-instance
ExecStop=/usr/bin/docker stop -t 2 nexus-instance

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME

# Крок 6: Запуск контейнера
sudo docker run -d --restart unless-stopped \
  --name nexus-instance \
  -e NODE_ID=$NODE_ID \
  $IMAGE_NAME

# Крок 7: Готово
echo "✅ Nexus Prover встановлено і запущено в Docker-контейнері!"
echo "🔁 Перевірити логи: docker logs -f nexus-instance"
echo "🛑 Зупинити: docker stop nexus-instance"
echo "♻️ Перезапустити: docker restart nexus-instance"
echo "🧷 Автозапуск контейнера налаштовано як systemd-сервіс: $SERVICE_NAME"
echo "👉 NODE ID був зчитаний під час встановлення. Щоб змінити — перезапустіть скрипт."
echo "💙 Слава Україні!"
echo

echo "📌 Команди для керування автозапуском (systemd):"
echo "🔍 Статус:     sudo systemctl status $SERVICE_NAME"
echo "🟢 Запуск:     sudo systemctl start $SERVICE_NAME"
echo "🔴 Зупинка:    sudo systemctl stop $SERVICE_NAME"
echo "♻️ Перезапуск: sudo systemctl restart $SERVICE_NAME"
echo "🚫 Вимкнути автозапуск: sudo systemctl disable $SERVICE_NAME"
