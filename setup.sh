#!/bin/bash
set -e
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

: "${ROOT_MEDIA_FOLDER:?Error: ROOT_MEDIA_FOLDER no está definida en .env}"
: "${ROOT_CONFIG_FOLDER:?Error: ROOT_CONFIG_FOLDER no está definida en .env}"
: "${PUID:?Error: PUID no está definido en .env}"
: "${PGID:?Error: PGID no está definido en .env}"

SERVICE_USER="arr-server"
SERVICE_GROUP="arr-server"

echo "[INFO] Creando usuario/grupo de servicio: $SERVICE_USER ($PUID:$PGID)"
if ! getent group "$SERVICE_GROUP" >/dev/null; then
    sudo groupadd -g "$PGID" "$SERVICE_GROUP"
else
    echo "[INFO] El grupo $SERVICE_GROUP ya existe"
fi
if ! id "$SERVICE_USER" >/dev/null 2>&1; then
    sudo useradd -u "$PUID" -g "$PGID" -r -s /usr/sbin/nologin "$SERVICE_USER"
else
    echo "[INFO] El usuario $SERVICE_USER ya existe"
fi

echo "[INFO] Añadiendo el usuario actual al grupo $SERVICE_GROUP"
sudo usermod -aG "$SERVICE_GROUP" "$(whoami)"

echo "[INFO] Creando la estructura de carpetas de medios en $ROOT_MEDIA_FOLDER"
sudo mkdir -p "$ROOT_MEDIA_FOLDER"/{torrents/{tv,movies,music},media/{tv,movies,music}}
echo "[INFO] Creando la estructura de carpetas de configuración en $ROOT_CONFIG_FOLDER"
sudo mkdir -p "$ROOT_CONFIG_FOLDER"/{radarr,sonarr,lidarr,bazarr,prowlarr,qbittorrent,jellyfin,seerr}

echo "[INFO] Estableciendo propietarios y permisos"
sudo chown -R "$PUID:$PGID" "$ROOT_MEDIA_FOLDER" "$ROOT_CONFIG_FOLDER"
sudo chmod -R a=,a+rX,u+w,g+w "$ROOT_MEDIA_FOLDER" "$ROOT_CONFIG_FOLDER"

echo "[INFO] Hecho."
echo "[INFO] Propietarios:"
ls -ln "$ROOT_MEDIA_FOLDER"
ls -ln "$ROOT_CONFIG_FOLDER"