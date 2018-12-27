#!/bin/sh

sudo docker rm $(docker ps -a -q)
sudo docker rmi $(docker images -q)
sudo docker volume rm $(docker volume ls -qf dangling=true)
