# GitSync KDE — Releases

> Binari precompilati di [GitSync KDE](https://github.com/GabryXnLab/git-sync-kde) per Linux e Windows.

GitSync KDE è un'applicazione desktop che monitora le tue repository Git e mantiene tutto sincronizzato in background, con integrazione nativa in KDE Dolphin e notifiche di sistema.

---

## Installazione rapida

### Linux

```bash
curl -sSL https://raw.githubusercontent.com/GabryXnLab/git-sync-kde-releases/master/install.sh | bash
```

Lo script installa il binario in `~/.local/bin/gitsync-kde` e configura l'avvio automatico.

### Windows

Apri PowerShell come utente normale ed esegui:

```powershell
irm https://raw.githubusercontent.com/GabryXnLab/git-sync-kde-releases/master/install.ps1 | iex
```

Lo script installa il binario in `%LOCALAPPDATA%\gitsync-kde\` e aggiunge l'avvio automatico al registro.

---

## Installazione manuale

Scarica il binario dalla pagina [Releases](https://github.com/GabryXnLab/git-sync-kde-releases/releases):

| Piattaforma | File            |
|-------------|-----------------|
| Linux       | `gitsync-kde`   |
| Windows     | `gitsync-kde.exe` |

### Linux (manuale)
```bash
chmod +x gitsync-kde
mv gitsync-kde ~/.local/bin/
gitsync-kde
```

### Windows (manuale)
Esegui direttamente `gitsync-kde.exe`. Al primo avvio verrà chiesto di configurare la cartella root dei repository.

---

## Aggiornamenti automatici

L'applicazione verifica automaticamente la disponibilità di nuove versioni all'avvio (al massimo una volta ogni 24 ore). Quando è disponibile un aggiornamento, apparirà una notifica nel tray e un'opzione nel menu contestuale per installarlo.

---

## Requisiti di sistema

| Piattaforma | Requisiti |
|-------------|-----------|
| Linux       | glibc 2.31+ (Ubuntu 20.04 / Debian 11 o superiore) |
| Windows     | Windows 10 o superiore (x64) |

> **Nota:** il binario è autocontenuto — non è necessario installare Python o altre dipendenze.

---

## Segnalare problemi

Per segnalare bug o richiedere funzionalità, apri una issue in questo repository.
