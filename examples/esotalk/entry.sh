#!/bin/bash

if [ ! -d "/var/www/core" ]; then
  cd /var/www
  git clone https://github.com/esotalk/esoTalk.git --branch develop
  get reset --hard b2a1884fde967286a8c30c152e27b3fd4dfadad0
  mv esoTalk/* ./ && rm -r esoTalk
  #mv config.php core/config.php
  #chmod +x core/config.php
fi