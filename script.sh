#!/bin/bash

# sleep until instance is ready
until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
  sleep 1
done

# install docker
sudo apt-get -y update
sudo curl -fsSL https://get.docker.com/ | sh

# make sure docker is started
sudo service docker start
sudo usermod -aG docker ubuntu
