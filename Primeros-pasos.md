# Configuración Inicial del Stack ARR

Primero, ejecuta `docker compose up` sin el modo desacoplado (-d) para ver los errores en consola.

## Cliente de Descargas QBittorrent

La primera vez, la interfaz web se inicia con credenciales proporcionadas en la terminal, verifícalas:

1. `docker logs containerid` => listable con `docker ps`, busca el usuario admin y la contraseña.
2. `http://localhost:8080` => inicia sesión con el usuario admin y la contraseña.
3. Cambiar el inicio de sesión de la web UI => `Tools` => `Options` => `Web UI` => modifica el usuario y la contraseña.
4. Panel izquierdo => `Categories` => clic derecho en `All` => `Add category` 3 veces (para películas, series y música). Ten en cuenta que estos nombres deberán coincidir con los gestores de contenido:
   - Category: `movies` / Save Path: `movies`
   - Category: `tv` / Save Path: `tv`
   - Category: `music` / Save Path: `music`
5. `Tools` => `Options` => `Downloads` => `Saving Management`
   - Default torrent management mode: `Automatic`
   - When torrent category changed: `Relocate torrent`
   - When default save path changed: `Switch affected torrents to manual mode`
   - When category save path changed: `Switch affected torrents to manual mode`
   - Default save path: `/data/torrents`

## Indexador Prowlarr

La primera vez requerirá configurar un inicio de sesión => elige autenticación por formulario (login page).

1. `http://localhost:9696`
2. `Settings` => `Download clients` => `+` => elige `qBittorrent`.
3. Desmarca `Use SSL` ya que no está configurado.
4. Host: `qbittorrent` / Port: `8080` / Username & Password: los mismos que configuraste en qBittorrent.
5. Haz clic en `Test` para asegurar que la conexión se establece y luego en `Save`.
 
Se necesitan indexadores para poder realizar las descargas de torrents. Ve a la pestaña de indexadores y añade algunos. Puedes consultar en internet cuáles son mejores para cada caso.

## Gestor de Películas Radarr

La primera vez requerirá configurar un inicio de sesión => elige autenticación por formulario (login page).

1. `http://localhost:7878`
2. `Settings` => `Media management` => `Add Root Folder` => `/data/media/movies`
3. `Show Advanced` => `Importing` => marca `Use Hardlinks instead of Copy`.
4. Marca `Delete empty movie folders during disk scan`.
5. Marca `Import Extra Files` y añade `srt,sub,nfo`.
6. `Settings` => `Download clients` => `+` => elige qBittorrent y rellena el formulario como en Prowlarr pero :red_circle: cambia `Category` a `movies` (debe coincidir exactamente con las categorías especificadas en qBittorrent).
7. Haz la prueba con `Test` y guarda los cambios con `Save`.
8. `Settings` => `General` => copia el contenido de `API Key`.
9. Ve a Prowlarr => `Settings` => `Apps` => `+` => `Radarr` => pega la `API Key`.
10. En Prowlarr, cambia `Prowlarr Server` => `http://prowlarr:9696` y `Radarr Server` => `http://radarr:7878`.
11. Haz la prueba con `Test` y guarda con `Save`.

## Gestor de Series Sonarr

La primera vez requerirá configurar un inicio de sesión => elige autenticación por formulario (login page).

1. `http://localhost:8989`
2. `Settings` => `Media management` => `Add Root Folder` => `/data/media/tv`
3. `Show Advanced` => `Importing` => marca `Use Hardlinks instead of Copy`.
4. Marca `Delete empty series folders during disk scan`.
5. Marca `Import Extra Files` y añade `srt,sub,nfo`.
6. `Settings` => `Download clients` => `+` => elige qBittorrent y rellena el formulario como en Prowlarr pero :red_circle: cambia `Category` a `tv` (debe coincidir exactamente con las categorías especificadas en qBittorrent).
7. Haz la prueba con `Test` y guarda los cambios con `Save`.
8. `Settings` => `General` => copia el contenido de `API Key`.
9. Ve a Prowlarr => `Settings` => `Apps` => `+` => `Sonarr` => pega la `API Key`.
10. En Prowlarr, cambia `Prowlarr Server` => `http://prowlarr:9696` y `Sonarr Server` => `http://sonarr:8989`.
11. Haz la prueba con `Test` y guarda con `Save`.

## Gestor de Música Lidarr

La primera vez requerirá configurar un inicio de sesión => elige autenticación por formulario (login page).

1. `http://localhost:8686`
2. `Settings` => `Media management` => `Add Root Folder` => `/data/media/music`
3. `Settings` => `Download clients` => `+` => elige qBittorrent y rellena el formulario como en Prowlarr pero :red_circle: cambia `Category` a `music` (debe coincidir exactamente con las categorías especificadas en qBittorrent).
4. Haz la prueba con `Test` y guarda los cambios con `Save`.
5. `Settings` => `General` => copia el contenido de `API Key`.
6. Ve a Prowlarr => `Settings` => `Apps` => `+` => `Lidarr` => pega la `API Key`.
7. En Prowlarr, cambia `Prowlarr Server` => `http://prowlarr:9696` y `Lidarr Server` => `http://lidarr:8686`.
8. Haz la prueba con `Test` y guarda con `Save`.

## Gestor de Subtítulos Bazarr

La primera vez requerirá configurar un inicio de sesión => elige autenticación por formulario (login page).

1. `http://localhost:6767`
2. `Settings` => `Languages` => `Languages filter` => selecciona los idiomas para los subtítulos.
3. `Settings` => `Languages` => `Add new profile`
   1. Primer campo, nombre del perfil.
   2. Haz clic en `Add` para agregar los idiomas establecidos anteriormente.
   3. Probado sin marcar nada para cada idioma.
   4. Guarda los cambios.
4. `Default settings` => marca `Series` y `Movies` y selecciona el perfil.
5. `Settings` => `Subtitles`
   1. `Subtitles options` => alongside media file.
   2. `Automatic subtitles synchronization` => marcado y selecciona los umbrales (*thresholds*).
6. `Settings` => `Providers` => añade un proveedor (OpenSubtitles.com puede requerir inicio de sesión, pero funciona bien con límites).
7. Ve a las secciones de `Sonarr` y `Radarr` y habilítalas. Ej: `Sonarr` => address `sonarr` => port `8989` => introduce la API_KEY.

## Jellyfin

Crea una cuenta nueva con nombre de usuario y contraseña, y crea una nueva biblioteca de contenido `films` mapeada a `/data/media/movies`.

## Seerr 

Realizar tras la configuración de Jellyfin.

1. `http://localhost:5055`
2. Conecta Jellyfin con tu nombre de usuario y contraseña y elige la biblioteca `films`, por ejemplo.
3. Continúa y conecta `Radarr` y `Sonarr`, rellena los datos con el nombre del servidor `radarr` y `sonarr` y sus claves API. Haz clic en `Test` y luego elige la carpeta de monitorización. Elige un perfil de calidad (*quality profile*).
4. Guarda los cambios.

## Para finalizar

Cuando toda la configuración esté lista y funcionando, es muy recomendable hacer una copia de seguridad (*backup*) de `${ROOT_CONFIG_FOLDER}` para volver a tener todo operativo en segundos si se pierde la configuración.

Ejecuta `docker compose down` y luego `docker compose up -d` para ejecutarlo en modo desacoplado y no necesitar mantener la sesión iniciada en el servidor.