FROM lscr.io/linuxserver/orcaslicer:latest

# Patch nur JavaScript - Python NICHT anfassen
RUN find /usr/share/selkies -name "*.js" -exec sed -i \
    's/window\.isSecureContext/true/g' {} \; 2>/dev/null || true

RUN find /usr/share/selkies -name "*.js" -exec sed -i \
    's/!window\.isSecureContext/false/g' {} \; 2>/dev/null || true

ENV SELKIES_ENABLE_HTTPS=false
ENV PIXELFLUX_WAYLAND=false
EXPOSE 3000
EXPOSE 3001
