# Truck Signs API

### A modern, containerized app that was developed with Django and can be deployed via Docker.


## Table of Contents

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Quickstart](#quickstart)
4. [Usage](#usage)
    - [Install dependencies](#install-dependencies)
    - [Clone the Repository](#clone-the-repository)
    - [Config .env](#configure-the-env-file)
    - [Create the Docker Networt](#create-the-docker-network-optional)
    - [Start Postgres-DB](#start-the-postgres-database-container)
    - [Build and start the backend Container](#build-and-start-the-backend-container)
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
   --name postgres-db \
   -e POSTGRES_DB=<YOUR_DB_NAME> \
   -e POSTGRES_USER=<YOUR_DB_USERNAME> \
   -e POSTGRES_PASSWORD=<YOUR_DB_PASSWORD> \
   -v pgdata:/var/lib/postgresql/data \
   --restart unless-stopped \
   postgres:13
   ```


3. **Build the Docker image:**
   ```bash
   docker build -t trucksigns-backend .
   ```


4. **Start the backend container:**
   ```bash
   docker run -d \
   --name trucksigns-backend \
   -v static_data:/app/static \
   -v media_data:/app/media \
   -p 8020:8000 \
   --restart unless-stopped \
   trucksigns-backend
   ```


---

## Usage

- ### Install dependencies:
   ```bash
   sudo apt update && sudo apt install -y docker.io git
   ```


- ### Clone the repository:
   ```bash
   git clone git@github.com:cyborg-s/truck_signs_api.git
   ```


- ### Configure the `.env` file:
  Copy the supplied template and adapt it to your needs:
   ```bash
   nano .env
   ```

   Important variables:
   ```env
   DOCKER_DB_HOST=truck_db
   DOCKER_DB_PORT=5432
   DJANGO_SUPERUSER_USERNAME=<YOUR_ADMIN_NAME>
   DJANGO_SUPERUSER_EMAIL=<YOUR_ADMIN_EMAIL_ADDRESS>
   DJANGO_SUPERUSER_PASSWORD=<PASSWORD>
   ALLOWED_HOSTS=127.0.0.1
   ```


- ### Create the Docker network: (optional)
    ```bash
    docker network create <YOUR_NETWORK_NAME>
    ```


- ### Start the Postgres database:
   > [!NOTE]
   > Do NOT release port 5432 on a public server for the Internet!
   ```bash
   docker run -d \
   --name postgres-db \
   --network <YOUR_NETWORK_NAME> \
   -e POSTGRES_DB=<YOUR_DB_NAME> \
   -e POSTGRES_USER=<YOUR_DB_USERNAME> \
   -e POSTGRES_PASSWORD=<YOUR_DB_PASSWORD> \
   -v pgdata:/var/lib/postgresql/data \
   --restart unless-stopped \
   postgres:13
   ```


- ### Build and start the backend Container:
   Build the Docker image:
   ```bash
   docker build -t trucksigns-backend .
   ```

   Start the backend container:
   ```bash
   docker run -d \
   --name trucksigns-backend \
   --network <YOUR_NETWORK_NAME> \
   -v static_data:/app/static \
   -v media_data:/app/media \
   -p 8020:8000 \
   --restart unless-stopped \
   trucksigns-backend
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