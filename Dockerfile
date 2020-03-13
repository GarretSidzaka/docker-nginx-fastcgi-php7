FROM nginx:alpine

RUN apk add --update --no-cache supervisor python3 && \
    mkdir /etc/supervisor.d
    
RUN apk --no-cache add php7 php7-fpm php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype php7-session \
    php7-mbstring php7-gd curl

COPY python3-fcgi.supervisor.conf /etc/supervisor.d/python3-fcgi.ini
COPY python3-fcgi.nginx.conf /etc/nginx/conf.d/python3-fcgi.conf

RUN rm /etc/nginx/conf.d/default.conf

COPY run-server /usr/local/bin

VOLUME ["/var/www/app"]

EXPOSE 80

CMD ["run-server"]
