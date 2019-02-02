#!/bin/sh

docker run --rm \
	-p 6081:443 \
	-e RESOLUTION=1024x768 \
    -e USER=util01 -e PASSWORD=mot2passe \
    -e ALSADEV=hw:2,0 \
    -e SSL_PORT=443 -v \
    ${PWD}/ssl:/etc/nginx/ssl \
	-v volume01:/home/util01 \
    --device /dev/snd \
	--hostname=container01 \
	nekrofage/ubuntu-desktop-lxde-vnc-zandronum:latest
