#!/bin/sh
# Create directories

mkdir -p volumes/{config,html}
rm -rf volumes/{config,html}/*

# Run a temporary Nginx container
docker run --rm -d --name nginx-temp nginx:alpine3.21

# Copy nginx.conf, conf.d, & html from the container
docker cp nginx-temp:/etc/nginx/conf.d volumes/config
docker cp nginx-temp:/etc/nginx/nginx.conf volumes/config

docker cp nginx-temp:/usr/share/nginx/html volumes

# Stop the temporary container
docker stop nginx-temp

cp -r templates/html-folder-for-php-info volumes/html/php-info
cp templates/php-nginx-default.conf volumes/config/conf.d/default.conf
cp templates/home-page.html volumes/html/index.html