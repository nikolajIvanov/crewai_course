# Python 3.11 Docker-Umgebung

Diese Docker-Umgebung stellt Python 3.11 bereit und synchronisiert Dateien zwischen dem Host und dem Container.

## Verwendung

### Container starten

```bash
docker-compose up -d
```

### In den Container einsteigen

```bash
docker-compose exec python-app bash
```

### Container stoppen

```bash
docker-compose down
```

## Dateisynchronisation

Der aktuelle Ordner wird mit dem `/app`-Verzeichnis im Container synchronisiert. Alle Änderungen im Container unter `/app` werden sofort auf dem Host sichtbar und umgekehrt. 

## Packages verwalten

Wenn Sie neue Python-Packages zur `requirements.txt` hinzufügen, haben Sie zwei Möglichkeiten:

1. Neuaufbau des Images:
```bash
docker-compose build
docker-compose up -d
```

2. Oder verwenden Sie das Entrypoint-Skript im laufenden Container:
```bash
docker-compose exec python-app bash -c '/usr/local/bin/docker-entrypoint.sh'
```

Das Entrypoint-Skript erkennt automatisch Änderungen an der `requirements.txt` und installiert die neuen Packages beim Starten des Containers.

## Python-Skripte ausführen

Es gibt mehrere Möglichkeiten, ein Python-Skript im Container auszuführen:

```bash
# Option 1: Direktes Ausführen eines Skripts im laufenden Container
docker-compose exec python-app python /app/mein_skript.py

# Option 2: Bash-Shell im Container öffnen und dann Skript ausführen
docker-compose exec python-app bash
# Im Container:
python /app/mein_skript.py
```

## Tipps für den täglichen Gebrauch

- **Logs anzeigen:** `docker-compose logs -f`
- **Installierte Packages auflisten:** `docker-compose exec python-app pip list` 