# 📦 Інструкція з використання Nexus Prover Installer

Цей файл містить інструкції для запуску встановлювального скрипта `install.sh`, що автоматизує встановлення Nexus Prover на Ubuntu 22.04+ через Docker.

---

## ✅ Вимоги

* Працююча система Ubuntu 22.04 або новіша
* Встановлений Docker:

  ```bash
  sudo apt install docker.io -y
  sudo systemctl enable --now docker
  ```
* Встановлений `git`:

  ```bash
  sudo apt install git -y
  ```

---

## ⬇️ Варіанти встановлення скрипта

### 🔹 ВАРІАНТ 1 — через Git (повна копія репозиторію)

```bash
git clone https://github.com/estet008/nexus-prover-installer.git
cd nexus-prover-installer
bash install.sh
```

🔸 Підходить, якщо хочеш зберегти README, інструкції, оновлювати скрипт, змінювати налаштування тощо.

---

### 🔹 ВАРІАНТ 2 — одноразове встановлення через curl

```bash
curl -fsSL https://raw.githubusercontent.com/estet008/nexus-prover-installer/main/install.sh | bash
```

🔸 Підходить для швидкого запуску, без збереження додаткових файлів локально.

---

## 📊 Перевірка логів

```bash
docker logs -f nexus-instance
```

---

## 🔁 Команди керування службою

```bash
sudo systemctl status nexus-docker-prover
sudo systemctl restart nexus-docker-prover
sudo systemctl stop nexus-docker-prover
```

---

## 💡 Порада

Щоб змінити `NODE_ID` — просто перезапустіть `install.sh` і введіть новий.

---

## 🔗 Корисні ресурси

* Nexus: [https://nexus.xyz](https://nexus.xyz)
* Dashboard: [https://app.nexus.xyz](https://app.nexus.xyz)
* Документація: [https://docs.nexus.xyz](https://docs.nexus.xyz)
* Підтримка: [Discord Nexus](https://discord.gg/nexusxyz)

---

## 💙 Слава Україні!

