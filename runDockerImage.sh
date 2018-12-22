#!/bin/sh

docker run -p 6080:80 \
	-e RESOLUTION=1024x768 \
        -e USER=util01 -e PASSWORD=mot2passe \
        -e ALSADEV=hw:2,0 \
	-v volume01:/volume/volume01 \
        --device /dev/snd \
	--hostname=container01 \
	nekrofage/ubuntu-desktop-lxde-vnc-zandronum:latest
