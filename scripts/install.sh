#!/usr/bin/env bash

set -euo pipefail

# ============================================================
# gfm-dotfiles
# Bootstrap do Arch Linux + Hyprland + Quickshell
# ============================================================

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"

PACMAN_LIST="$REPO_DIR/packages/pacman.txt"
AUR_LIST="$REPO_DIR/packages/aur.txt"
APPS_LIST="$REPO_DIR/packages/apps.txt"

CONFIG_DIR="$REPO_DIR/config"
LOCAL_DIR="$REPO_DIR/local"

# ============================================================
# USUÁRIO / PRIVILÉGIOS
# ============================================================

if [[ "$EUID" -eq 0 ]]; then
    echo "ERRO: execute este instalador como usuário normal."
    echo
    echo "Exemplo:"
    echo "  ./scripts/install.sh"
    echo
    echo "O instalador utiliza sudo quando necessário."
    exit 1
fi

if ! command -v sudo >/dev/null 2>&1; then
    echo "ERRO: sudo não está instalado."
    echo
    echo "O bootstrap precisa de sudo para instalar pacotes"
    echo "e habilitar os serviços do sistema."
    exit 1
fi

TARGET_USER="$USER"
TARGET_HOME="$HOME"
SUDO="sudo"

if [[ -z "$TARGET_HOME" || ! -d "$TARGET_HOME" ]]; then
    echo "ERRO: HOME inválido:"
    echo "$TARGET_HOME"
    exit 1
fi

# ============================================================
# INFORMAÇÕES
# ============================================================

echo
echo "=============================================="
echo " gfm-dotfiles"
echo "=============================================="
echo
echo "Repositório : $REPO_DIR"
echo "Usuário     : $TARGET_USER"
echo "HOME        : $TARGET_HOME"
echo

# ============================================================
# FUNÇÕES
# ============================================================

read_packages() {
    local file="$1"

    grep -Ev \
        '^[[:space:]]*(#|$)' \
        "$file" || true
}

install_pacman_list() {
    local file="$1"

    mapfile -t packages < <(read_packages "$file")

    if [[ "${#packages[@]}" -eq 0 ]]; then
        return
    fi

    echo
    echo "==> Instalando pacotes oficiais..."
    "$SUDO" pacman -S --needed --noconfirm "${packages[@]}"
}

# ============================================================
# PACMAN
# ============================================================

if [[ ! -f "$PACMAN_LIST" ]]; then
    echo "ERRO: arquivo não encontrado:"
    echo "$PACMAN_LIST"
    exit 1
fi

install_pacman_list "$PACMAN_LIST"

# ============================================================
# APLICAÇÕES
# ============================================================

if [[ -f "$APPS_LIST" ]]; then
    install_pacman_list "$APPS_LIST"
fi

# ============================================================
# AUR / YAY
# ============================================================

if [[ -f "$AUR_LIST" ]]; then

    mapfile -t aur_packages < <(read_packages "$AUR_LIST")

    if [[ "${#aur_packages[@]}" -gt 0 ]]; then

        if ! command -v yay >/dev/null 2>&1; then

            echo
            echo "==> yay não encontrado."
            echo "==> Preparando ambiente para o AUR..."

            "$SUDO" pacman -S --needed --noconfirm \
                base-devel \
                git

            YAY_BUILD_DIR="$(mktemp -d)"

            trap 'rm -rf "$YAY_BUILD_DIR"' EXIT

            echo
            echo "==> Obtendo yay..."

            git clone \
                https://aur.archlinux.org/yay.git \
                "$YAY_BUILD_DIR/yay"

            cd "$YAY_BUILD_DIR/yay"

            echo
            echo "==> Compilando e instalando yay..."

            makepkg -si --noconfirm

            cd "$REPO_DIR"

            rm -rf "$YAY_BUILD_DIR"
            trap - EXIT
        fi

        echo
        echo "==> Instalando pacotes AUR..."

        yay -S --needed --noconfirm "${aur_packages[@]}"
    fi
fi

# ============================================================
# CONFIGURAÇÕES
# ============================================================

echo
echo "==> Instalando configurações..."

mkdir -p \
    "$TARGET_HOME/.config/hypr" \
    "$TARGET_HOME/.config/quickshell"

cp -a \
    "$CONFIG_DIR/hypr/." \
    "$TARGET_HOME/.config/hypr/"

cp -a \
    "$CONFIG_DIR/quickshell/." \
    "$TARGET_HOME/.config/quickshell/"

# ============================================================
# EXECUTÁVEIS LOCAIS
# ============================================================

if [[ -d "$LOCAL_DIR/bin" ]]; then

    echo
    echo "==> Instalando executáveis locais..."

    mkdir -p "$TARGET_HOME/.local/bin"

    for file in "$LOCAL_DIR/bin"/*; do
        [[ -f "$file" ]] || continue

        install -Dm755 \
            "$file" \
            "$TARGET_HOME/.local/bin/$(basename "$file")"
    done
fi

# ============================================================
# PERMISSÕES
# ============================================================

echo
echo "==> Ajustando proprietário dos arquivos..."

"$SUDO" chown -R \
    "$TARGET_USER":"$(id -gn "$TARGET_USER")" \
    "$TARGET_HOME/.config/hypr" \
    "$TARGET_HOME/.config/quickshell" \
    "$TARGET_HOME/.local/bin"

# ============================================================
# SERVIÇOS
# ============================================================

echo
echo "==> Habilitando serviços..."

"$SUDO" systemctl enable NetworkManager.service
"$SUDO" systemctl enable bluetooth.service
"$SUDO" systemctl enable gdm.service

# ============================================================
# FINALIZAÇÃO
# ============================================================

echo
echo "=============================================="
echo " Instalação concluída."
echo "=============================================="
echo
echo "Configurações:"
echo "  $TARGET_HOME/.config/hypr"
echo "  $TARGET_HOME/.config/quickshell"
echo
echo "Executáveis:"
echo "  $TARGET_HOME/.local/bin"
echo
echo "Serviços habilitados:"
echo "  NetworkManager"
echo "  bluetooth"
echo "  gdm"
echo
echo "Reinicie o sistema para iniciar pelo GDM."
echo
