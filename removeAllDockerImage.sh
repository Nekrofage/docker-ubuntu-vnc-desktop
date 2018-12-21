#!/bin/sh

sudo docker rm $(docker ps -a -q)
sudo docker rmi $(docker images -q)
