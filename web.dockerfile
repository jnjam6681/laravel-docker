FROM nginx

RUN apt-get update -y && apt-get install -y curl

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/nginx.conf
