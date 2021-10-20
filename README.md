# Docker VNC Mudlet Container
[![Build and Deploy to Docker Hub](https://github.com/SeanStoves/Docker-Mudlet-VNC/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/SeanStoves/Docker-Mudlet-VNC/actions/workflows/docker-publish.yml)
![Docker Pulls](https://img.shields.io/docker/pulls/sstoves/mudlet-vnc)

### Environment Variables with their defaults:
<table>
   <tr><td>DISPLAY_HEIGHT</td><td>768</td></tr>
   <tr><td>DISPLAY_WIDTH</td><td>1024</td></tr>
   <tr><td>RUN_FLUXBOX</td><td>yes</td></tr>
   <tr><td>RUN_MUDLET</td><td>yes</td></tr>
   <tr><td>RUN_NOVNC</td><td>yes</td></tr>
   <tr><td>VNC_PASSWORD</td><td>password</td></tr>
</table>

### Exposed Ports
<table>
   <tr><td>VNC Server</td><td>5900</td></tr>
   <tr><td>NoVNC Web</td><td>8080</td></tr>
</table>

### Tags
<table>
   <tr><td><b>Tag</b></td><td>description</td></tr>
   <tr><td>sstoves/mudlet-vnc:latest</td><td>This is the latest/greatest version of Mudlet</td></tr>
   <tr><td>sstoves/mudlet-vnc:4.13.1</td><td>This is the 4.13.1 version of Mudlet</td></tr>
   <tr><td>sstoves/mudlet-vnc:3.22.1</td><td>This is the 3.22.1 version of Mudlet</td></tr>
</table>
