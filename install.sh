#!/bin/bash
# GitSync KDE — Installer Linux
# Scarica l'ultima versione e la configura per l'avvio automatico

set -e

REPO="GabryXnLab/git-sync-kde-releases"
INSTALL_DIR="$HOME/.local/bin"
AUTOSTART_DIR="$HOME/.config/autostart"
APPS_DIR="$HOME/.local/share/applications"
BINARY_NAME="gitsync-kde"
BINARY_PATH="$INSTALL_DIR/$BINARY_NAME"

echo "╔══════════════════════════════════════╗"
echo "║     GitSync KDE — Installer           ║"
echo "╚══════════════════════════════════════╝"

# Dipendenze
if ! command -v curl &>/dev/null; then
    echo "ERRORE: curl non trovato. Installa curl e riprova."
    exit 1
fi

# Recupera l'ultima versione
echo "Recupero ultima versione disponibile..."
LATEST=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" \
    | grep '"tag_name"' | head -1 | cut -d'"' -f4)

if [ -z "$LATEST" ]; then
    echo "ERRORE: impossibile recuperare l'ultima versione. Controlla la connessione."
    exit 1
fi

echo "Ultima versione: $LATEST"

DOWNLOAD_URL="https://github.com/$REPO/releases/download/$LATEST/$BINARY_NAME"

# Download
echo "Download in corso..."
mkdir -p "$INSTALL_DIR"
curl -fsSL --progress-bar -o "$BINARY_PATH" "$DOWNLOAD_URL"
chmod +x "$BINARY_PATH"

echo "Binario installato in: $BINARY_PATH"

# Desktop entry condiviso
DESKTOP_CONTENT="[Desktop Entry]
Name=GitSync KDE
Comment=Monitor Sincronizzazione Repository Git
Exec=$BINARY_PATH
Icon=git-gui
Terminal=false
Type=Application
Categories=Development;
StartupNotify=false
X-GNOME-Autostart-enabled=true
X-KDE-autostart-after=panel"

# Autostart KDE / GNOME
echo "Configurazione avvio automatico..."
mkdir -p "$AUTOSTART_DIR"
echo "$DESKTOP_CONTENT" > "$AUTOSTART_DIR/git-sync-kde.desktop"
chmod 644 "$AUTOSTART_DIR/git-sync-kde.desktop"

# Voce nel launcher applicazioni
mkdir -p "$APPS_DIR"
echo "$DESKTOP_CONTENT" > "$APPS_DIR/git-sync-kde.desktop"
chmod 644 "$APPS_DIR/git-sync-kde.desktop"
update-desktop-database "$APPS_DIR" 2>/dev/null || true

# PATH hint
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo "Nota: $INSTALL_DIR non è nel tuo PATH."
    echo "Aggiungi questa riga a ~/.bashrc o ~/.zshrc:"
    echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
fi

echo ""
echo "✓ GitSync KDE $LATEST installato con successo!"
echo "  Avvia subito con: $BINARY_PATH"
echo "  Oppure cerca 'GitSync' nel launcher applicazioni."
