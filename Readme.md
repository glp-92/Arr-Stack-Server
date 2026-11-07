# Sobre el Stack ARR

El Stack ARR proporciona un servidor multimedia completo con todos sus elementos interconectados para automatizar tareas como seleccionar películas, descargarlas automáticamente, obtener subtítulos, gestionar el almacenamiento y más.

Para la configuración inicial de los servicios [consulta esta pequeña guía](./Primeros-pasos.md)

## Documentación

Es altamente recomendable leer la documentación para entender qué hace cada servicio:

[Justificación del uso de DNS conocidos sobre VPN](https://wiki.servarr.com/en/vpn)

[Configuración de la estructura de carpetas para contenedores Docker. VER PERMISOS](https://trash-guides.info/File-and-Folder-Structure/How-to-set-up/Docker/)

[Guía útil para el primer inicio](https://github.com/automation-avenue/arr-new)

## Configuración de QBittorrent para el ancho de banda

Aplica las siguientes reglas en `qBittorrent` para asegurar que el ancho de banda sea estable en la red local:

1. `Tools` -> `Options` -> `Connection` -> `Peer connection protocol` -> `TCP`
2. `Tools` -> `Options` -> `Speed` -> establece 1250 KiB/s en subida y 2500 KiB/s en descarga. Marca `Apply rate limit to all connections`
3. `Tools` -> `Options` -> `BitTorrent` -> marca `Torrent Queueing` y establece `Maximum active downloads` = 1, `Maximum active uploads` = 1, `Maximum active torrents` = 2

## Descripción de los servicios

- `QBitTorrent` cliente torrent para descargas P2P.
- `Radarr` automatiza la gestión de la biblioteca de películas.
- `Sonarr` automatiza la gestión de series de TV.
- `Lidarr` automatiza la gestión de música.
- `Bazarr` automatiza la descarga de subtítulos.
- `Prowlarr` conecta Radarr/Sonarr con qBittorrent y SABnzbd.
- `Flaresolverr` resuelve automáticamente los captchas de Cloudflare.
- `Jellyfin` servidor multimedia que proporciona la interfaz para ver el contenido.
- `Seerr` automatización de descargas centralizada en este servidor para todo el contenido; utiliza las API de `Sonarr` y `Radarr`.

## Configuración de los directorios principales

[Este script](./setup.sh) automatiza la creación de usuarios y directorios. Se crean cuentas de servicio para ejecutar los contenedores, evitando así el uso de `root`.