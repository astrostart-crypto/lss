#!/bin/bash

# Скрипт для настройки Arch Linux

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Проверка, что это Arch Linux
if ! [ -f /etc/arch-release ]; then
    echo -e "${RED}Этот скрипт предназначен только для Arch Linux!${NC}"
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

# Включение multilib (для 32-битных приложений)
echo -e "${YELLOW}Включение multilib...${NC}"
sudo sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
sudo pacman -Sy
check_success

# Установка yay (AUR helper)
echo -e "${YELLOW}Установка yay...${NC}"
sudo pacman -S --needed --noconfirm base-devel git
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si --noconfirm
cd ~
check_success

# Установка драйверов и базового ПО
echo -e "${YELLOW}Установка драйверов и базового ПО...${NC}"
sudo pacman -S --noconfirm \
    mesa vulkan-intel vulkan-radeon nvidia nvidia-utils \
    pulseaudio pulseaudio-alsa alsa-utils \
    networkmanager nm-connection-editor network-manager-applet \
    bluez bluez-utils blueman \
    xorg xorg-xinit xorg-server \
    noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-liberation \
    firefox chromium \
    libreoffice-fresh \
    gimp inkscape \
    vlc mpv \
    neofetch htop
check_success

# Установка графических окружений (выбор пользователя)
echo -e "${YELLOW}Установка графических окружений...${NC}"
read -p "Установить GNOME? (y/n): " install_gnome
if [[ $install_gnome =~ ^[Yy]$ ]]; then
    sudo pacman -S --noconfirm gnome gnome-extra gdm
    sudo systemctl enable gdm
fi

read -p "Установить KDE Plasma? (y/n): " install_kde
if [[ $install_kde =~ ^[Yy]$ ]]; then
    sudo pacman -S --noconfirm plasma kde-applications sddm
    sudo systemctl enable sddm
fi

read -p "Установить XFCE? (y/n): " install_xfce
if [[ $install_xfce =~ ^[Yy]$ ]]; then
    sudo pacman -S --noconfirm xfce4 xfce4-goodies lightdm lightdm-gtk-greeter
    sudo systemctl enable lightdm
fi
check_success

# Установка Docker
echo -e "${YELLOW}Установка Docker...${NC}"
sudo pacman -S --noconfirm docker docker-compose
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
check_success

# Установка разработческих инструментов
echo -e "${YELLOW}Установка разработческих инструментов...${NC}"
sudo pacman -S --noconfirm \
    base-devel cmake gcc clang llvm \
    nodejs npm yarn \
    go rust \
    jdk-openjdk jre-openjdk \
    postgresql mysql \
    php php-apache php-gd php-sqlite \
    ruby python-virtualenv
check_success

# Включение сервисов
echo -e "${YELLOW}Включение сервисов...${NC}"
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
check_success

echo -e "${GREEN}Настройка Arch Linux завершена!${NC}"#!/bin/bash

# Скрипт для настройки Arch Linux

# Цвета для вывода
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Проверка, что это Arch Linux
if ! [ -f /etc/arch-release ]; then
    echo -e "${RED}Этот скрипт предназначен только для Arch Linux!${NC}"
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

# Включение multilib (для 32-битных приложений)
echo -e "${YELLOW}Включение multilib...${NC}"
sudo sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf
sudo pacman -Sy
check_success

# Установка yay (AUR helper)
echo -e "${YELLOW}Установка yay...${NC}"
sudo pacman -S --needed --noconfirm base-devel git
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si --noconfirm
cd ~
check_success

# Установка драйверов и базового ПО
echo -e "${YELLOW}Установка драйверов и базового ПО...${NC}"
sudo pacman -S --noconfirm \
    mesa vulkan-intel vulkan-radeon nvidia nvidia-utils \
    pulseaudio pulseaudio-alsa alsa-utils \
    networkmanager nm-connection-editor network-manager-applet \
    bluez bluez-utils blueman \
    xorg xorg-xinit xorg-server \
    noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-dejavu ttf-liberation \
    firefox chromium \
    libreoffice-fresh \
    gimp inkscape \
    vlc mpv \
    neofetch htop
check_success

# Установка графических окружений (выбор пользователя)
echo -e "${YELLOW}Установка графических окружений...${NC}"
read -p "Установить GNOME? (y/n): " install_gnome
if [[ $install_gnome =~ ^[Yy]$ ]]; then
    sudo pacman -S --noconfirm gnome gnome-extra gdm
    sudo systemctl enable gdm
fi

read -p "Установить KDE Plasma? (y/n): " install_kde
if [[ $install_kde =~ ^[Yy]$ ]]; then
    sudo pacman -S --noconfirm plasma kde-applications sddm
    sudo systemctl enable sddm
fi

read -p "Установить XFCE? (y/n): " install_xfce
if [[ $install_xfce =~ ^[Yy]$ ]]; then
    sudo pacman -S --noconfirm xfce4 xfce4-goodies lightdm lightdm-gtk-greeter
    sudo systemctl enable lightdm
fi
check_success

# Установка Docker
echo -e "${YELLOW}Установка Docker...${NC}"
sudo pacman -S --noconfirm docker docker-compose
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
check_success

# Установка разработческих инструментов
echo -e "${YELLOW}Установка разработческих инструментов...${NC}"
sudo pacman -S --noconfirm \
    base-devel cmake gcc clang llvm \
    nodejs npm yarn \
    go rust \
    jdk-openjdk jre-openjdk \
    postgresql mysql \
    php php-apache php-gd php-sqlite \
    ruby python-virtualenv
check_success

# Включение сервисов
echo -e "${YELLOW}Включение сервисов...${NC}"
sudo systemctl enable NetworkManager
sudo systemctl enable bluetooth
check_success

echo -e "${GREEN}Настройка Arch Linux завершена!${NC}"
