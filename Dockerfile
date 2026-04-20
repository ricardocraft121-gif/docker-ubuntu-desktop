# Usamos la última versión estable de Ubuntu (24.04 LTS o 22.04 LTS)
FROM ubuntu:latest

# Evitamos que Ubuntu nos pida configurar zonas horarias o teclados durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Actualizamos el sistema e instalamos utilidades básicas de una terminal completa
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    git \
    nano \
    wget \
    sudo \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Instalamos sshx para el acceso remoto
RUN curl -sSf https://sshx.io/get | sh

# Nos ubicamos en la carpeta principal del usuario root
WORKDIR /root

# Iniciamos sshx (asegurando el espacio entre CMD y el corchete)
CMD ["sshx"]
