# Usamos una base que ya tiene Node.js instalado por si tu bot es en JS
# (Si es en Python, cambia a FROM python:3.11-slim)
FROM python:3.11-slim

# Instalamos curl, git y nano (útiles para manejar tu bot desde la terminal)
RUN apt-get update && apt-get install -y \
    curl \
    git \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Instalamos sshx
RUN curl -sSf https://sshx.io/get | sh

# Creamos un directorio de trabajo limpio
WORKDIR /root

# El único comando que ejecutará el contenedor es sshx
CMD["sshx"]
