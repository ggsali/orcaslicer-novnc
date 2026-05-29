FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:1
ENV RESOLUTION=1920x1080x24

# Basis-Pakete
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    xvfb \
    openbox \
    x11vnc \
    novnc \
    websockify \
    supervisor \
    libfuse2 \
    libgtk-3-0 \
    libglib2.0-0 \
    libwebkit2gtk-4.1-0 \
    libgstreamer1.0-0 \
    libgstreamer-plugins-base1.0-0 \
    libopengl0 \
    libglx0 \
    libgl1 \
    dbus-x11 \
    && rm -rf /var/lib/apt/lists/*

# OrcaSlicer herunterladen
RUN wget -q https://github.com/SoftFever/OrcaSlicer/releases/download/v2.3.1/OrcaSlicer_Linux_AppImage_Ubuntu2404_V2.3.1.AppImage \
    -O /opt/OrcaSlicer.AppImage && \
    chmod +x /opt/OrcaSlicer.AppImage

# noVNC setup
RUN ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html 2>/dev/null || true

# Supervisor config
RUN mkdir -p /etc/supervisor/conf.d
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
