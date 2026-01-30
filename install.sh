#!/bin/bash

# ========================================================
# 1. PREPARAÇÃO E AUTO-PERMISSÃO
# ========================================================
# Garante que o script seja executável agora e no futuro
chmod +x "$0" 2>/dev/null

# ========================================================
# 1.1 VERIFICAÇÃO DE DEPENDÊNCIAS (MODO UNIVERSAL)
# ========================================================
MISSING_DEPS=0

# Verifica se GCC (compilador) e MAKE estão instalados
if ! command -v gcc >/dev/null 2>&1 || ! command -v make >/dev/null 2>&1; then
    echo "️  Atenção: Compilador (GCC/Make) não encontrado."
    MISSING_DEPS=1
fi

# Verifica se APLAY (Som) está instalado
if ! command -v aplay >/dev/null 2>&1; then
    echo "️  Atenção: Sistema de som ALSA (aplay) não encontrado."
    MISSING_DEPS=1
fi

if [ $MISSING_DEPS -eq 1 ]; then
    echo "---------------------------------------------------"
    echo " O sistema precisa instalar ferramentas para rodar a revolução."
    echo " Será solicitada sua senha de administrador (sudo) para instalar:"
    echo "   -> gcc, make, alsa-utils"
    echo "---------------------------------------------------"
    
    # ----------------------------------------------------
    # DETECÇÃO DE DISTRO E INSTALAÇÃO AUTOMÁTICA
    # ----------------------------------------------------
    
    # 1. Debian, Ubuntu, Mint, Kali, antiX, Pop!_OS
    if command -v apt >/dev/null 2>&1; then
        echo " Sistema detectado: Debian/Ubuntu family (apt)"
        sudo apt update && sudo apt install -y build-essential alsa-utils

    # 2. Fedora, RHEL, CentOS, AlmaLinux
    elif command -v dnf >/dev/null 2>&1; then
        echo " Sistema detectado: Fedora family (dnf)"
        sudo dnf install -y gcc make alsa-utils
    
    # 3. Arch Linux, Manjaro, EndeavourOS
    elif command -v pacman >/dev/null 2>&1; then
        echo " Sistema detectado: Arch family (pacman)"
        # --needed evita reinstalar o que já existe
        sudo pacman -S --noconfirm --needed base-devel alsa-utils

    # 4. OpenSUSE
    elif command -v zypper >/dev/null 2>&1; then
        echo " Sistema detectado: OpenSUSE (zypper)"
        sudo zypper install -y -t pattern devel_basis
        sudo zypper install -y alsa-utils

    # 5. Gentoo (Para os bravos)
    elif command -v emerge >/dev/null 2>&1; then
        echo "️ Sistema detectado: Gentoo (emerge)"
        # Gentoo users geralmente já têm gcc/make, mas garantimos o alsa
        sudo emerge --ask --noreplace media-libs/alsa-lib media-sound/alsa-utils sys-devel/gcc sys-devel/make

    # 6. Void Linux
    elif command -v xbps-install >/dev/null 2>&1; then
        echo " Sistema detectado: Void Linux (xbps)"
        sudo xbps-install -Sy base-devel alsa-utils

    # 7. Alpine Linux (Raro em desktop, mas possível)
    elif command -v apk >/dev/null 2>&1; then
        echo "️ Sistema detectado: Alpine Linux (apk)"
        sudo apk add build-base alsa-utils

    # 8. Fallback (Não encontrou gerenciador conhecido)
    else
        echo " ERRO: Não consegui identificar seu gerenciador de pacotes."
        echo "   Por favor, instale manualmente: gcc, make e alsa-utils."
        read -p "Pressione [ENTER] para sair..."
        exit 1
    fi
    
    # Verifica se deu certo após a tentativa de instalação
    if [ $? -ne 0 ]; then
        echo " Falha na instalação das dependências."
        read -p "Pressione [ENTER] para sair..."
        exit 1
    fi
    
    echo " Dependências instaladas com sucesso!"
fi

# ========================================================
# 2. COMPILAÇÃO
# ========================================================
echo " Compilando o código..."
make --quiet
if [ $? -ne 0 ]; then
    echo " Erro fatal na compilação. Verifique os erros acima."
    read -p "Enter para sair..."
    exit 1
fi

# ========================================================
# 3. INSTALAÇÃO NO MENU DO SISTEMA
# ========================================================
echo "🚀 Instalando no Menu de Aplicativos..."

CAMINHO_ATUAL=$(pwd)
ARQUIVO_DESKTOP="Nosso_Programa.desktop"
PASTA_SISTEMA="$HOME/.local/share/applications"

# Garante que a pasta existe
mkdir -p "$PASTA_SISTEMA"

cat > "$PASTA_SISTEMA/$ARQUIVO_DESKTOP" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Nosso Programa
Comment=Hino e Bandeira da União Soviética
Exec=$CAMINHO_ATUAL/app_soviet
Icon=$CAMINHO_ATUAL/icone.png
Terminal=true
Categories=Utility;
EOF

chmod +x "$PASTA_SISTEMA/$ARQUIVO_DESKTOP"
# Tenta marcar como confiável (Gnome/Ubuntu)
gio set "$PASTA_SISTEMA/$ARQUIVO_DESKTOP" metadata::trusted true 2>/dev/null
# Atualiza banco de dados
update-desktop-database "$PASTA_SISTEMA" 2>/dev/null

echo "✅ Sucesso! Instalado no menu."

# ========================================================
# 4. PREPARA O DESINSTALADOR
# ========================================================
# Deixa o desinstalador pronto para o futuro
if [ -f "desinstalar.sh" ]; then
    chmod +x "desinstalar.sh"
fi

# ========================================================
# 5. EXECUÇÃO DE TESTE
# ========================================================
echo " Rodando para testar..."

# Verifica se está rodando no terminal ou clique
if [ ! -t 0 ]; then
    if command -v x-terminal-emulator > /dev/null; then
        x-terminal-emulator -e "$0"
        exit
    elif command -v gnome-terminal > /dev/null; then
        gnome-terminal -- "$0"
        exit
    else
        xterm -e "$0"
        exit
    fi
fi

./app_soviet

echo ""
echo "---------------------------------------------------"
read -p "Pressione [ENTER] para apagar este instalador..."

# ========================================================
# 6. AUTO-DESTRUIÇÃO
# ========================================================
rm -- "$0"
