FROM debian:11.2

RUN apt update && apt upgrade -y
RUN apt install -y nginx
RUN apt clean
RUN rm -rf /var/www/*
RUN mkdir -p /var/www/company.com/img

COPY ./index.html /var/www/company.com/
COPY ./img.jpg /var/www/company.com/img/

RUN chmod -R 754 /var/www/company.com
RUN useradd zavedu && groupadd zavedg && usermod -a -G zavedg zavedu
RUN chown -R zavedu:zavedg /var/www/company.com
RUN sed -i 's/\/var\/www\/html/\/var\/www\/company\.com/g' /etc/nginx/sites-enabled/default
RUN sed -i 's/user\ www-data/user\ zavedu/g' /etc/nginx/nginx.conf

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
