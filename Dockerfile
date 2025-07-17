# Use official Python 3.8.1 slim image
FROM python:3.8.1-slim

# Set environment variables for Python
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies needed (netcat für den DB-Check)
RUN echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until && \
    sed -i 's|http://deb.debian.org/debian|http://archive.debian.org/debian|g' /etc/apt/sources.list && \
    sed -i 's|http://security.debian.org/debian-security|http://archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    sed -i '/buster-updates/d' /etc/apt/sources.list
RUN apt-get update && apt-get install -y \
netcat \
gcc \
build-essential \ 
&& rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app


# Copy project file into the container
COPY . .

# Install Python dependencies
RUN python -m pip install --no-cache-dir -r requirements.txt

# Set execute permissions für entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose Django port
EXPOSE 8000

# Entrypoint setzen
ENTRYPOINT ["/app/entrypoint.sh"]
