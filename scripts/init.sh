#!/bin/sh
# Create directories

rm -rf volumes
mkdir -p volumes/{http,html,db}
mkdir -p volumes/http/config
mkdir -p volumes/db/{data,init}

# Run a temporary Nginx container
docker run --rm -d --name nginx-temp nginx:alpine3.21

# Copy nginx.conf, conf.d, & html from the container
docker cp nginx-temp:/etc/nginx/conf.d volumes/http/config
docker cp nginx-temp:/etc/nginx/nginx.conf volumes/http/config

docker cp nginx-temp:/usr/share/nginx/html volumes

# Stop the temporary container
docker stop nginx-temp

cp templates/home-page.html volumes/html/index.html
cp templates/php-nginx-default.conf volumes/http/config/conf.d/default.conf
cp templates/init-todos-db.sql volumes/db/init/todos.sql
cp -r templates/todos-app volumes/html/todos
cp -r templates/html-folder-for-php-info volumes/html/php-info

