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

echo Reached-1
exit 0
echo Reached-2

mkdir -p volumes/final-project/config
rm -rf volumes/final-project/config/*
mkdir -p volumes/home-page/{config,html}
rm -rf volumes/home-page/{config,html}/*


# Run a temporary Nginx container
docker run --rm -d --name nginx-temp nginx:alpine3.21

# Copy nginx.conf, conf.d, & html from the container
docker cp nginx-temp:/etc/nginx/conf.d volumes/final-project/config
docker cp nginx-temp:/etc/nginx/nginx.conf volumes/final-project/config/nginx.conf

docker cp nginx-temp:/etc/nginx/conf.d volumes/home-page/config
docker cp nginx-temp:/etc/nginx/nginx.conf volumes/home-page/config/nginx.conf

docker cp nginx-temp:/usr/share/nginx/html volumes/home-page/

# Stop the temporary container
docker stop nginx-temp

# find & replace 80 to 7901 in volumes/final-project/config/conf.d/default.conf
# sed for find & replace
sed -i 's/80/7901/g' volumes/final-project/config/conf.d/default.conf

LOC_BLOCK=$(cat <<EOF
    location / {
        root   /usr/share/nginx/html;
        index  index.html index.htm;
    }
EOF
)
FP_REPO_NAME="pages-site"

NEW_LOC_BLOCK=$(cat <<EOF
    location / {
        proxy_pass http://hp-svc:6969;
    }
    location /$FP_REPO_NAME {
        alias   /usr/share/nginx/html;
        index  index.html index.htm;
    }
EOF
)

perl -0777 -i -pe "s#$LOC_BLOCK#$NEW_LOC_BLOCK#g" volumes/final-project/config/conf.d/default.conf

sed -i 's/80/6969/g' volumes/home-page/config/conf.d/default.conf

OLD_HTML_BODY=$(cat <<EOF
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
EOF
)

NEW_HTML_BODY=$(cat <<EOF
<body>
<h1>Home</h1>
    <p>Please visit the <a href="/$FP_REPO_NAME/">$FP_REPO_NAME</a> page.</p>
</body>
EOF
)

perl -0777 -i -pe "s#$OLD_HTML_BODY#$NEW_HTML_BODY#g" volumes/home-page/html/index.html