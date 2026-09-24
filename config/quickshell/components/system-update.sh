#!/usr/bin/env bash

set -u

# ============================================================
# CORES
# ============================================================

GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
GRAY='\033[0;90m'
RESET='\033[0m'

# ============================================================
# FUNÇÕES
# ============================================================

ask_yes() {
    local question="$1"

    read -r -p "$question [S/n]: " answer

    case "${answer,,}" in
        n|nao|não)
            return 1
            ;;
        *)
            return 0
            ;;
    esac
}

section() {
    echo
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${CYAN}$1${RESET}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

# ============================================================
# INÍCIO
# ============================================================

clear

echo -e "${CYAN}"
echo "============================================================"
echo "              ATUALIZAÇÃO DO SISTEMA"
echo "============================================================"
echo -e "${RESET}"

echo
echo -e "Kernel em execução: ${GREEN}$(uname -r)${RESET}"

# ============================================================
# 1. PACMAN
# ============================================================

section "1. Atualização dos pacotes Pacman"

if ask_yes "Executar atualização do Pacman?"; then
    sudo pacman -Syu
else
    echo -e "${YELLOW}Atualização do Pacman ignorada.${RESET}"
fi

# ============================================================
# 2. YAY / AUR
# ============================================================

section "2. Atualização dos pacotes AUR"

if command -v yay >/dev/null 2>&1; then

    if ask_yes "Executar atualização dos pacotes AUR via yay?"; then
        yay -Sua
    else
        echo -e "${YELLOW}Atualização AUR ignorada.${RESET}"
    fi

else
    echo -e "${GRAY}yay não está instalado. Etapa ignorada.${RESET}"
fi

# ============================================================
# 3. FLATPAK
# ============================================================

section "3. Atualização dos Flatpaks"

if command -v flatpak >/dev/null 2>&1; then

    if ask_yes "Executar atualização dos Flatpaks?"; then
        flatpak update
    else
        echo -e "${YELLOW}Atualização Flatpak ignorada.${RESET}"
    fi

else
    echo -e "${GRAY}Flatpak não está instalado. Etapa ignorada.${RESET}"
fi

# ============================================================
# 4. VERIFICAÇÃO DE DEPENDÊNCIAS
# ============================================================

section "4. Verificação de dependências"

echo "Executando verificação..."
sudo pacman -Dk

# ============================================================
# 5. PACOTES ÓRFÃOS
# ============================================================

section "5. Pacotes órfãos"

orphans="$(pacman -Qdtq 2>/dev/null || true)"

if [[ -n "$orphans" ]]; then

    echo "Pacotes órfãos encontrados:"
    echo
    pacman -Qdt

    echo

    if ask_yes "Remover os pacotes órfãos?"; then
        sudo pacman -Rns $orphans
    else
        echo -e "${YELLOW}Remoção dos órfãos ignorada.${RESET}"
    fi

else
    echo -e "${GREEN}Nenhum pacote órfão encontrado.${RESET}"
fi

# ============================================================
# 6. CACHE DO PACMAN
# ============================================================

section "6. Cache de pacotes antigos"

if command -v paccache >/dev/null 2>&1; then

    echo "Pacotes que serão mantidos/limpos:"
    paccache -d

    echo

    if ask_yes "Limpar versões antigas do cache?"; then
        sudo paccache -r
    else
        echo -e "${YELLOW}Limpeza do cache ignorada.${RESET}"
    fi

else
    echo -e "${GRAY}paccache não está disponível.${RESET}"
fi

# ============================================================
# 7. VERIFICAÇÃO FINAL
# ============================================================

section "7. Verificação final"

echo
echo "Kernel em execução:"
echo -e "${GREEN}$(uname -r)${RESET}"

echo
echo "Kernel instalado:"
pacman -Q linux 2>/dev/null || true

echo
echo "Pacotes órfãos restantes:"

remaining_orphans="$(pacman -Qdtq 2>/dev/null || true)"

if [[ -n "$remaining_orphans" ]]; then
    pacman -Qdt
else
    echo -e "${GREEN}Nenhum.${RESET}"
fi

echo
echo -e "${GREEN}============================================================${RESET}"
echo -e "${GREEN}                 PROCESSO CONCLUÍDO${RESET}"
echo -e "${GREEN}============================================================${RESET}"

echo
read -r -p "Pressione Enter para fechar..."
