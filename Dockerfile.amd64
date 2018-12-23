################################################################################
# base system
################################################################################
ARG image=ubuntu:18.04
FROM $image as system

ARG localbuild
RUN echo "LOCALBUILD=$localbuild"
RUN if [ "x$localbuild" != "x" ]; then sed -i 's#http://archive.ubuntu.com/#http://fr.archive.ubuntu.com/#' /etc/apt/sources.list; fi

ENV HOME=/root \
      APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn \
      DEBIAN_FRONTEND=noninteractive \
      DOOMWADDIR='/wads' \
      FILES='' \
      LANG=en_US.UTF-8 \
      LANGUAGE=en_US.UTF-8 \
      LC_ALL=C.UTF-8


# built-in packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common curl apache2-utils \
    && apt-get update \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
        supervisor nginx sudo vim-tiny net-tools zenity xz-utils \
        dbus-x11 x11-utils alsa-utils \
        mesa-utils libgl1-mesa-dri \
        lxde xvfb x11vnc \
        gtk2-engines-murrine gnome-themes-standard gtk2-engines-pixbuf gtk2-engines-murrine arc-theme \
        firefox chromium-browser \
        ttf-ubuntu-font-family \
		mc screen vim \
		bash unzip git gnupg libglu1-mesa libgtk2.0 net-tools \
		socat software-properties-common supervisor wget x11vnc xvfb \		
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*


# Set up Zandronum
RUN mkdir -p /app/util01
COPY conf/zandronum.ini /app/util01/config/zandronum/
COPY conf/initUtil01.sh /app/util01/
COPY scripts/* /tmp/
RUN /tmp/install_zandronum.sh

# Freedoom installation
RUN wget https://github.com/freedoom/freedoom/releases/download/v0.11.3/freedoom-0.11.3.zip \
    && unzip freedoom-0.11.3.zip \
    && rm freedoom-0.11.3.zip \
    && cp freedoom-0.11.3/freedoom2.wad /app/util01/config/zandronum \
    && rm freedoom-0.11.3 -rf

# Slade editor installation
RUN wget -O- http://debian.drdteam.org/drdteam.gpg | apt-key add -    
RUN apt-add-repository 'deb http://debian.drdteam.org/ stable multiverse'
RUN apt-get update 
RUN apt-get install -y slade

# Eureka editor installation
RUN apt-get install -y eureka 

# Office applications
RUN apt-get install -y gedit gnumeric abiword gimp

# Clean up
RUN apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# tini for subreap
ARG TINI_VERSION=v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
RUN chmod +x /bin/tini

# python library
COPY image/usr/local/lib/web/backend/requirements.txt /tmp/
RUN apt-get update \
    && dpkg-query -W -f='${Package}\n' > /tmp/a.txt \
    && apt-get install -y python-pip python-dev build-essential \
	&& pip install setuptools wheel && pip install -r /tmp/requirements.txt \
    && dpkg-query -W -f='${Package}\n' > /tmp/b.txt \
    && apt-get remove -y `diff --changed-group-format='%>' --unchanged-group-format='' /tmp/a.txt /tmp/b.txt | xargs` \
    && apt-get autoclean -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/* /tmp/a.txt /tmp/b.txt


################################################################################
# builder
################################################################################
FROM ubuntu:16.04 as builder

ARG localbuild
RUN if [ "x$localbuild" != "x" ]; then sed -i 's#http://archive.ubuntu.com/#http://fr.archive.ubuntu.com/#' /etc/apt/sources.list; fi

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates

# nodejs
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs

# yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

# build frontend
COPY web /src/web
RUN cd /src/web \
    && yarn \
    && npm run build


################################################################################
# merge
################################################################################
FROM system
LABEL maintainer="lesanglierdesardennes@gmail.com"

COPY --from=builder /src/web/dist/ /usr/local/lib/web/frontend/
COPY image /

EXPOSE 80
WORKDIR /root
ENV HOME=/home/ubuntu \
    SHELL=/bin/bash
HEALTHCHECK --interval=30s --timeout=5s CMD curl --fail http://127.0.0.1:6079/api/health
ENTRYPOINT ["/startup.sh"]
