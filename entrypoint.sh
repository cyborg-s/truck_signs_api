#!/usr/bin/env bash
set -e

echo "Waiting for postgres to connect ..."

while ! nc -z "${DOCKER_DB_HOST:-postgres-db}" 5432; do
  sleep 0.1
done

echo "PostgreSQL is active"

python manage.py collectstatic --noinput
python manage.py migrate
python manage.py makemigrations


echo "Running createsuperuser (if not exists) ..."
python manage.py shell <<EOF
import os
from django.contrib.auth import get_user_model

User = get_user_model()
username = os.environ.get("DJANGO_SUPERUSER_USERNAME")
email = os.environ.get("DJANGO_SUPERUSER_EMAIL")
password = os.environ.get("DJANGO_SUPERUSER_PASSWORD")

if username and email and password:
    if not User.objects.filter(username=username).exists():
        User.objects.create_superuser(username=username, email=email, password=password)
        print("Superuser created.")
    else:
        print("Superuser already exists.")
else:
    print("Superuser environment variables not fully set. Skipping.")
EOF


echo "Starting Gunicorn ..."
gunicorn truck_signs_designs.wsgi:application --bind 0.0.0.0:8000


echo "Postgresql migrations finished"

python manage.py runserver