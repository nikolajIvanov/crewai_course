FROM python:3.11-slim

# Setze Arbeitsverzeichnis
WORKDIR /app

# Verhindere Puffer für Python-Ausgaben
ENV PYTHONUNBUFFERED=1

# Kopiere das Startskript
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Erstelle .docker_cache Verzeichnis und setze Berechtigungen
RUN mkdir -p /app/.docker_cache && chmod 777 /app/.docker_cache

# Halte Container am Laufen mit dem Entrypoint-Skript
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bash"] 