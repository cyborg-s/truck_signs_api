# Verwende ein aktuelles, schlankes Python-Image
FROM python:3.12-slim

# Installiere Systemabhängigkeiten (für DB-Wait und Paketbuilds)
RUN apt-get update && apt-get install -y --no-install-recommends \
    netcat \
    gcc \
    build-essential \
 && rm -rf /var/lib/apt/lists/*

# Setze das Arbeitsverzeichnis
WORKDIR /app

# Kopiere den Code in das Container-Image
COPY . .

# Installiere Python-Abhängigkeiten
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Mache entrypoint.sh ausführbar
RUN chmod +x /app/entrypoint.sh

# Öffne Port 8000 (Django Standard)
EXPOSE 8000

# Setze den Entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
