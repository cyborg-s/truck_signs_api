# Truck Signs API

### A modern, containerized app that was developed with Django and can be deployed via Docker.


## Table of Contents

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Quickstart](#quickstart)
4. [Usage](#usage)
    - [Config .env](#configure-the-env-file)
    - [Create the Docker Networt](#create-the-docker-network-optional)
    - [Start Postgres-DB](#start-the-postgres-database-container)
    - [Start the backend Container](#start-the-backend-container)
    - [Access to the administration panel](#access-to-the-administration-panel)
5. [Truck Signs Api Notes](#notes-to-the-application)

---

## Introduction

This application provides a backend service for managing a web store for truck signs.
It uses PostgreSQL as a database and can be flexibly configured and deployed using Docker and an optional .env file.

---

## Prerequisites

- Docker
- Git


---

## Quickstart

1. **Generate the `.env` file:**  
   ```bash
   cp truck_signs_designs/settings/simple_env_config.env .env
   ```


2. **Start the Postgres database:**
   ```bash
   docker run -d \
   --name <YOUR_CONTAINER_NAME> \
   --network <YOUR_NETWORK_NAME> \
   -e POSTGRES_DB=<YOUR_DB_NAME> \
   -e POSTGRES_USER=<YOUR_DB_USERNAME> \
   -e POSTGRES_PASSWORD=<YOUR_DB_PASSWORD> \
   -v pgdata:/var/lib/postgresql/data \
   --restart unless-stopped \
   postgres:13
   ```


3. **Build the Docker image:**
   ```bash
   docker build -t <IMMAGE_NAME> .
   ```


4. **Start the backend container:**
   ```bash
   docker run -d \
   --name trucksigns-backend \
   --network <YOUR_NETWORK_NAME> \
   -v static_data:/app/static \
   -v media_data:/app/media \
   -p 8020:8000 \
   --restart unless-stopped \
   <IMMAGE_NAME>
   ```


---

## Usage


- ### Configure the `.env` file:
   ```bash
   nano .env
   ```

   Important variables:
   ```env
   DOCKER_DB_HOST=<YOUR_DB_NAME>
   DOCKER_DB_PORT=<YOUR_DB_PORT>
   DJANGO_SUPERUSER_USERNAME=<YOUR_ADMIN_NAME>
   DJANGO_SUPERUSER_EMAIL=<YOUR_ADMIN_EMAIL_ADDRESS>
   DJANGO_SUPERUSER_PASSWORD=<PASSWORD>
   ALLOWED_HOSTS=127.0.0.1
   ```

   ***Effects of Changing the Values***
   |Variable |	Description and Effect
   |:--------|-----------------------:|
   |DOCKER_DB_HOST	| Defines the hostname of the PostgreSQL container. Adapt it to your DB name to ensure the connection.|
   |DOCKER_DB_PORT	| Sets the port to access PostgreSQL. Must match the used port. Wrong value = connection refused.|
   |DJANGO_SUPERUSER_USERNAME	| Sets the admin login name to Create it automatically.|
   |DJANGO_SUPERUSER_EMAIL	| Used for admin contact.|
   |DJANGO_SUPERUSER_PASSWORD	| Sets the admin password. Should be strong. |
   |ALLOWED_HOSTS	| Restricts which hosts can access Django. Incorrect values cause 400 Bad Request errors.|


- ### Create the Docker network: (optional)
   This helps you to connect database with the Backend.
    ```bash
    docker network create <YOUR_NETWORK_NAME>
    ```


- ### Start the Postgres database:
   > [!NOTE]
   > Do NOT release port 5432 on a public server for the Internet, you do NOT need a direct connection via the Internet!
   ```bash
   docker run -d \
   --name <YOUR_CONTAINER_NAME> \   #The name you find it in the Container list.
   --network <YOUR_NETWORK_NAME> \   
   -e POSTGRES_DB=<YOUR_DB_NAME> \  #The name you add to the `.env`
   -e POSTGRES_USER=<YOUR_DB_USERNAME> \  #Add the name also to the `.env` to connect backend with the DB
   -e POSTGRES_PASSWORD=<YOUR_DB_PASSWORD> \  #This too.
   -v pgdata:/var/lib/postgresql/data \
   --restart unless-stopped \
   postgres:13
   ```


- ### Start the backend Container:

   Start the backend container:
   ```bash
   docker run -d \
   --name <YOUR_BACKEND_CONTAINER_NAME> \
   --network <YOUR_NETWORK_NAME> \
   -v static_data:/app/static \
   -v media_data:/app/media \
   -p 8020:8000 \
   --restart unless-stopped \   #Guarantees restart after crash
   <IMAGE_NAME>
   ```
   > [!NOTE]
   > you can map the port to every you want with *-p PORT:8000*


- ### Access to the administration panel:
   ```bash
   http://<YOUR_SERVER_IP>:8020/admin
   ```
---


- ## Notes to the Application
    <a href=https://github.com/Developer-Akademie-GmbH/truck_signs_api/blob/main/README.md>Truck Signs Api Readme</a>