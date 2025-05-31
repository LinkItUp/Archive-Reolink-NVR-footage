# NVR Komprimierungs- und Umbenennungsskript / NVR Compression & Renaming Script

## 📝 Beschreibung / Description

Dieses Shell-Skript wurde für Systeme wie TrueNAS und Reolink NVRs entwickelt, um automatisch:

- Video-Dateien (.mp4) in verständliche Namen umzubenennen
- Kameraordner, die älter als 24 Stunden sind, zu komprimieren
- Ursprungsordner nach erfolgreicher Komprimierung zu löschen

This shell script is designed for systems like TrueNAS and Reolink NVRs to automatically:

- Rename `.mp4` video files into human-readable format
- Compress camera folders older than 24 hours
- Delete original folders after successful compression

## ⚙️ Voraussetzungen / Requirements

- Unix-/TrueNAS-kompatible Umgebung
- Standard-Tools: `find`, `tar`, `xz`, `mv`, `basename`

## 🔧 Konfiguration / Configuration

Öffne das Skript (`compress_nvr_dirs.sh`) und passe Folgendes an:

Open the script (`compress_nvr_dirs.sh`) and adjust the following:

```sh
BASE_DIR="/your/path/here"  # Dein Verzeichnis mit NVR-Daten / Your NVR data directory
XZ_THREADS=8                # Anzahl der Threads für Komprimierung / Compression thread count
```

Kamera-Mapping anpassen / Customize camera name mapping:

```sh
get_camera_name() {
  case "$1" in
    "NVR_00") echo "Flur" ;;   # Hallway
    "NVR_01") echo "Lager" ;;  # Storage
    *) echo "$1" ;;            # fallback
  esac
}
```

## ▶️ Verwendung / Usage

1. Skript ausführbar machen / Make the script executable:
   ```sh
   chmod +x compress_nvr_dirs.sh
   ```

2. Manuell starten / Run manually:
   ```sh
   ./compress_nvr_dirs.sh
   ```

3. Per Cronjob automatisieren / Schedule via cron:
   ```sh
   0 2 * * * /your/path/to/compress_nvr_dirs.sh >> /var/log/nvr.log 2>&1
   ```

## 📦 Ergebnis / Result

- Umbenannte Video-Dateien wie: `Flur 17.58-27.05.25.mp4`
- Komprimierte Archive im Format: `Ordnername.tar.xz`

## 📄 Lizenz / License

MIT – Nutzung auf eigene Gefahr / Use at your own risk