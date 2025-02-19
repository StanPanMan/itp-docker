FROM nginx:alpine3.21 AS nginx-default
RUN rm -rf /usr/share/nginx/html/*
COPY --from=final-project docs/ /usr/share/nginx/html/