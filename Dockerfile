# Usamos Ubuntu estable
FROM ubuntu:22.04

# Evitar que el instalador se quede congelado pidiendo zona horaria
ENV DEBIAN_FRONTEND=noninteractive

# Instalar herramientas vitales que no vienen en un contenedor vacío
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    socat \
    netcat-openbsd \
    iproute2 \
    iptables \
    && rm -rf /var/lib/apt/lists/*

# Descargar e instalar los binarios de Tailscale
RUN curl -fsSL https://tailscale.com/install.sh | sh

# Configurar el directorio de trabajo
WORKDIR /root

# Copiar nuestro script maestro y darle permisos
COPY start.sh /root/start.sh
RUN chmod +x /root/start.sh

# Ejecutar el script
CMD ["/root/start.sh"]
