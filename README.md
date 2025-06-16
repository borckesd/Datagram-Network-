# Datagram Network Docker Setup

This repository helps you run the Datagram CLI using Docker Compose.

---

## Prerequisites

- Docker and Docker Compose installed
- Datagram API key from https://dashboard.datagram.network/

---

## Step 1: Clone this repository

```bash
git clone https://github.com/borckesd/Datagram-Network-.git
cd Datagram-Network-
```

---

## Step 2: Download the datagram-cli binary

### If you don’t already have the datagram-cli binary, download the latest Linux release:

```bash
wget -O datagram-cli https://github.com/Datagram-Group/datagram-cli-release/releases/latest/download/datagram-cli-x86_64-linux
chmod +x datagram-cli
```

### Copy the binary to your project folder (if downloaded elsewhere)

```bash
cp datagram-cli ~/Datagram-Network-/
```

---

## Step 3: Create .env File with Your API Key

```bash
nano .env
```

### Add your Datagram API key (replace your_api_key_here with your actual key), How to get your API key
Visit Datagram Dashboard
Navigate to Wallet → Licenses to find or generate your API key:

```bash
DATAGRAM_KEY=your_api_key_here
```

Save and exit

---

## Step 4: Check Dockerfile and docker-compose.yml
Your project should have these files:

### Dockerfile

```dockerfile
FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y ca-certificates tini procps && \
    rm -rf /var/lib/apt/lists/*

COPY datagram-cli /app/datagram-cli
RUN chmod +x /app/datagram-cli

WORKDIR /app

ENTRYPOINT ["/usr/bin/tini", "--", "./datagram-cli"]
```


### docker-compose.yml

```yaml
version: "3.9"

services:
  datagram:
    build: .
    container_name: datagram-cli
    restart: unless-stopped
    environment:
      - DATAGRAM_KEY=${DATAGRAM_KEY}
    command: ["run", "--", "-key", "${DATAGRAM_KEY}"]
```

---

## Step 5: Build and Run the Container

### Run the following command to build the Docker image and start the container:

```bash
docker compose --env-file .env up --build -d
```

---

## Step 6: Verify Container Status and Logs

### Check if the container is running

```bash
docker ps
```

### Follow the logs to see real-time output from the datagram-cli container

```bash
docker logs -f datagram-cli
```

---

## OPTIONAL

### To stop and remove containers

```bash
docker compose down
```


