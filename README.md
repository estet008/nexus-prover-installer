# nexus-prover-installer
Автоматизований інсталятор Nexus Prover через Docker
# Nexus Prover Installer

Цей репозиторій містить скрипт автоматизованого встановлення **Nexus Prover** у середовищі Ubuntu 22.04+ із використанням **Docker** та glibc >=2.39.

---

## ⚙️ Що робить скрипт:

* Запитує у користувача `NODE_ID`
* Створює необхідні Docker-файли (Dockerfile та entrypoint)
* Встановлює Nexus CLI всередині контейнера Ubuntu 24.04
* Створює systemd-сервіс для автозапуску після перезавантаження
* Запускає Nexus Prover у Docker-контейнері

---

## 🚀 Швидкий запуск

```bash
curl -fsSL https://raw.githubusercontent.com/<your-username>/nexus-prover-installer/main/install.sh | bash
```

📌 Замініть `<your-username>` на свій GitHub логін.

---

## 🛠 Системні вимоги

* Ubuntu 22.04+
* Docker встановлений і запущений
* Доступ до root (через `sudo`)

---

## 🔁 Команди для керування системною службою

```bash
sudo systemctl status nexus-docker-prover     # Перевірити статус
sudo systemctl start nexus-docker-prover      # Запустити вручну
sudo systemctl stop nexus-docker-prover       # Зупинити
sudo systemctl restart nexus-docker-prover    # Перезапустити
sudo systemctl disable nexus-docker-prover    # Вимкнути автозапуск
```

---

## 💬 Питання або проблеми?

* Перевірте [https://docs.nexus.xyz](https://docs.nexus.xyz)
* Напишіть у [офіційний Discord Nexus](https://discord.gg/nexusxyz)

---

## 💙 Слава Україні!
