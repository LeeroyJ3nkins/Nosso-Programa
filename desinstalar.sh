#!/bin/bash

# ========================================================
# 1. AUTO-PERMISSÃO
# ========================================================
chmod +x "$0" 2>/dev/null

# ========================================================
# 2. TRUQUE DE ABRIR JANELA (Para você ver o que acontece)
# ========================================================
if [ ! -t 0 ]; then
    if command -v x-terminal-emulator > /dev/null; then
        x-terminal-emulator -e "$0"
        exit
    elif command -v gnome-terminal > /dev/null; then
        gnome-terminal -- "$0"
        exit
    elif command -v xterm > /dev/null; then
        xterm -e "$0"
        exit
    fi
fi

# ========================================================
# 3. A REMOÇÃO
# ========================================================
echo "  Procurando o Nosso Programa no sistema..."

ARQUIVO_ALVO="$HOME/.local/share/applications/Nosso_Programa.desktop"

if [ -f "$ARQUIVO_ALVO" ]; then
    rm "$ARQUIVO_ALVO"
    update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null
    echo " SUCESSO: O ícone foi removido do menu."
else
    echo "️  AVISO: O arquivo não foi encontrado no menu."
    echo "   (Pode ser que já tenha sido apagado antes)."
fi

echo ""
echo "---------------------------------------------------"
read -p "Pressione [ENTER] para fechar..."
