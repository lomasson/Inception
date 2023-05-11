# FROM debian:buster
# EXPOSE 443

# RUN apt-get update
# RUN apt install -y nginx
# RUN apt install openssl
# RUN mkdir /etc/nginx/certs
# RUN openssl req -new -newkey rsa:2048 -days 365 -subj "/CN=lomasson.42.fr" -nodes -x509 -keyout /etc/nginx/certs/cert.key -out /etc/nginx/certs/cert.crt

# CMD ["nginx", "-g", "daemon off;"]
# escape=`
FROM debian:buster
RUN apt-get update && apt-get -y install nginx \
		&& apt-get -y install openssl \
		&& mkdir /etc/nginx/ssl \
		&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
		-subj "/C=FR/ST=Haut-Rhin/L=Mulhouse/O=42/CN=lomasson.42.fr" \
		&& sed -i '/ssl_prefer_server_ciphers on;/a        ssl_certificate /etc/nginx/ssl/nginx.crt;\n        ssl_certificate_key /etc/nginx/ssl/nginx.key;\n' /etc/nginx/nginx.conf 
WORKDIR /etc/nginx/sites-available
COPY conf/wordpress.conf .
COPY conf/fastcgi.conf ../snippets
WORKDIR /etc/nginx/sites-enabled
RUN ln -s /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled/wordpress.conf
EXPOSE 443
CMD ["nginx","-g","daemon off;"]