#!/bin/sh

REPO=nekrofage/ubuntu-desktop-lxde-vnc-zandronum                                                                
TAG=latest
IMAGE=ubuntu:18.04
LOCALBUILD=1

docker build -t $REPO:$TAG --build-arg localbuild=$LOCALBUILD --build-arg image=$IMAGE .

