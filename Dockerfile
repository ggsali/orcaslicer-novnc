
FROM lscr.io/linuxserver/orcaslicer:latest
 
# Patch the JavaScript to allow HTTP (bypass isSecureContext check)
RUN find /usr/share/selkies -name "*.js" -exec sed -i \
    's/window\.isSecureContext/true/g' {} \; 2>/dev/null || true
 
RUN find /usr/share/selkies -name "*.js" -exec sed -i \
    's/!window\.isSecureContext/false/g' {} \; 2>/dev/null || true
 
# Patch signaling server to force HTTP
RUN sed -i \
    's/http_protocol = .https:. if self\.enable_https else .http:./http_protocol = "http:"/g' \
    /lsiopy/lib/python3.13/site-packages/selkies/signaling_server.py 2>/dev/null || true
 
# Force HTTP mode
ENV SELKIES_ENABLE_HTTPS=false
ENV SELKIES_HTTP_PORT=3000
ENV SELKIES_HTTPS_PORT=3001
 
EXPOSE 3000
EXPOSE 3001
