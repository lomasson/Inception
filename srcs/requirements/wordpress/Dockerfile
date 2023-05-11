# FROM alpine:3.17
# EXPOSE 9000
# RUN apk update
# RUN	apk upgrade
# RUN	apk add php81 \
# 	php81-fpm \
# 	php81-mysql \
# 	default-mysql-client \
# 	get \
# 	curl;

# # RUN mkdir -p /var/www/html
# # RUN chown -R www-data:www-data /var/www/html
# # RUN userdel -f www-data && useradd -u 82 www-data
# # Téléchargement et extraction de WordPress
# # RUN curl -o /tmp/wordpress.tar.gz -SL https://wordpress.org/latest.tar.gz && \
# #     tar -xzf /tmp/wordpress.tar.gz && \
# #     rm /tmp/wordpress.tar.gz && \
# RUN	curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN	chmod +x /usr/local/bin/wp;
# RUN wp core download --path=/var/www/html/
# WORKDIR /var/www/html/wordpress
# RUN chown -R www-data:www-data * \
# 		&& chmod -R 755 * \
# 		&& rm	wp-config-sample.php
# ADD conf/php-fpm.conf /etc/php/7.3/fpm
# ADD conf/www.conf /etc/php/7.3/fpm/pool.d
# WORKDIR /home
# COPY /conf/wp-config.php .
# COPY /tools/script.sh .
# # RUN userdel www-data
# # RUN useradd -u 82 www-data
# # RUN chown -R www-data:www-data /data/html
# # RUN cd wordpress
# # WORKDIR wordpress


# # RUN wp config create --dbhost=127.0.0.1:3306 --dbname=table --dbuser=root --dbpass=root 
# # RUN wp core --path=wordpress update
# # CMD ["wp plugin update --all"]
# # CMD ["wp theme update --all"]
# # CMD ["wp core install --path=wordpress --url=127.0.0.1:9000 --title=lomasson.42.fr --admin_user=root --admin_email=root@inception.fr"]
# # COPY ./conf/php-fpm.conf /etc/php81/php-fpm.conf
# # RUN sed -i 's/^listen = 127\.0\.0\.1:9000$/listen = 9000/' /etc/php81/php-fpm.d/www.conf
# # RUN sed -i 's/^listen = 127\.0\.0\.1:9000$/listen = 9000/' /etc/php81/php-fpm.conf
# # Configuration de PHP-FPM
# # COPY php-fpm.conf /etc/php7/php-fpm.conf
# # Exposition du port 80S
# ENTRYPOINT ["/bin/sh","script.sh"]

FROM debian:buster
WORKDIR /var/www/html
RUN apt-get update \
		&& apt-get -y install php7.3 php7.3-fpm php7.3-mysql default-mysql-client wget\ 
		&& wget https://wordpress.org/wordpress-6.1.1.tar.gz \
		&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x wp-cli.phar \
		&& mv wp-cli.phar /usr/local/bin/wp \
		&& tar -xvf  wordpress-6.1.1.tar.gz -C /var/www/html/ \
		&& rm wordpress-6.1.1.tar.gz 
WORKDIR /var/www/html/wordpress
RUN chown -R www-data:www-data * \
		&& chmod -R 755 * \
		&& rm	wp-config-sample.php
WORKDIR /run/php
ADD conf/php-fpm.conf /etc/php/7.3/fpm
ADD conf/www.conf /etc/php/7.3/fpm/pool.d
WORKDIR /home
COPY /conf/wp-config.php .
COPY /tools/script.sh .
ENTRYPOINT ["/bin/sh","script.sh"]
