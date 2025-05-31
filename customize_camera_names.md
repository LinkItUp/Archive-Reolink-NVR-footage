# Anleitung zur Anpassung der Kamera-Namen / Guide for Customizing Camera Names

## DEUTSCH

Öffne die Funktion `get_camera_name()` im Skript `compress_nvr_dirs.sh`:

```sh
get_camera_name() {
  case "$1" in
    "NVR_00") echo "Flur" ;;
    "NVR_01") echo "Lager" ;;
    *) echo "$1" ;;
  esac
}
```

Füge neue Kameras hinzu, z. B.:

```sh
"NVR_02") echo "Eingang" ;;
"NVR_03") echo "Garage" ;;
```

## ENGLISH

Open the `get_camera_name()` function in `compress_nvr_dirs.sh`:

```sh
get_camera_name() {
  case "$1" in
    "NVR_00") echo "Flur" ;;
    "NVR_01") echo "Lager" ;;
    *) echo "$1" ;;
  esac
}
```

Add new cameras like this:

```sh
"NVR_02") echo "Entrance" ;;
"NVR_03") echo "Garage" ;;
```