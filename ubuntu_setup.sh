#!/bin/bash

# Скрипт для настройки Ubuntu

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Проверка, что это Ubuntu
if ! [ -f /etc/debian_version ] || ! grep -q "Ubuntu" /etc/os-release; then
    echo -e "${RED}Этот скрипт предназначен только для Ubuntu!${NC}"
    exit 1
fi

# Функция для проверки выполнения команды
check_success() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Успешно!${NC}"
    else
        echo -e "${RED}Ошибка!${NC}"
        exit 1
    fi
}

# Добавление репозиториев
echo -e "${YELLOW}Добавление репозиториев...${NC}"
sudo add-apt-repository -y universe
sudo add-apt-repository -y multiverse
sudo add-apt-repository -y restricted
check_success

# Установка драйверов и базового ПО
echo -e "${YELLOW}Установка драйверов и базового ПО...${NC}"
sudo apt install -y \
    ubuntu-restricted-extras \
    libavcodec-extra \
    gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi \
    mesa-utils vulkan-utils \
    pulseaudio alsa-utils \
    network-manager nm-connection-editor \
    bluez blueman \
    fonts-noto fonts-noto-cjk fonts-noto-color-emoji fonts-dejavu fonts-liberation \
    firefox chromium-browser \
    libreoffice \
    gimp inkscape \
    vlc mpv \
    neofetch htop
check_success

# Установка графических окружений (выбор пользователя)
echo -e "${YELLOW}Установка графических окружений...${NC}"
read -p "Установить GNOME? (y/n): " install_gnome
if [[ $install_gnome =~ ^[Yy]$ ]]; then
    sudo apt install -y ubuntu-gnome-desktop
fi

read -p "Установить KDE Plasma? (y/n): " install_kde
if [[ $install_kde =~ ^[Yy]$ ]]; then
    sudo apt install -y kubuntu-desktop
fi

read -p "Установить XFCE? (y/n): " install_xfce
if [[ $install_xfce =~ ^[Yy]$ ]]; then
    sudo apt install -y xubuntu-desktop
fi
check_success

# Установка Snap и Flatpak
echo -e "${YELLOW}Установка Snap и Flatpak...${NC}"
sudo apt install -y snapd flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
check_success

# Установка Docker
echo -e "${YELLOW}Установка Docker...${NC}"
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $USER
check_success

# Установка разработческих инструментов
echo -e "${YELLOW}Установка разработческих инструментов...${NC}"
sudo apt install -y \
    build-essential cmake gcc clang llvm \
    nodejs npm \
    golang rustc cargo \
    default-jdk default-jre \
    postgresql mysql-server \
    php apache2 libapache2-mod-php php-mysql php-gd php-sqlite3 \
    ruby python3-venv python3-pip
check_success

echo -e "${GREEN}Настройка Ubuntu завершена!${NC}"
