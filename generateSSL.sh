#!/bin/sh

mkdir -p doomserver/ssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout doomserver/ssl/nginx.key -out doomserver/ssl/nginx.crt
