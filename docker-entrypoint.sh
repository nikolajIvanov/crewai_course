#!/bin/bash
set -e

# Stelle sicher, dass das Verzeichnis existiert und beschreibbar ist
mkdir -p /app/.docker_cache
chmod 777 /app/.docker_cache

# Prüfe, ob requirements.txt existiert
if [ -f /app/requirements.txt ]; then
  # Berechne den MD5-Hash der requirements.txt
  CURRENT_HASH=$(md5sum /app/requirements.txt | awk '{ print $1 }')
  HASH_FILE="/app/.docker_cache/requirements.md5"
  
  # Wenn die Hash-Datei nicht existiert oder der Hash unterschiedlich ist
  if [ ! -f "$HASH_FILE" ] || [ "$(cat $HASH_FILE)" != "$CURRENT_HASH" ]; then
    echo "Neue oder geänderte requirements.txt gefunden. Installiere Pakete..."
    pip install --no-cache-dir -r /app/requirements.txt
    echo "$CURRENT_HASH" > "$HASH_FILE"
    echo "Pakete wurden installiert."
  else
    echo "requirements.txt ist unverändert. Keine Installation erforderlich."
  fi
fi

# Führe den übergebenen Befehl aus
exec "$@" 