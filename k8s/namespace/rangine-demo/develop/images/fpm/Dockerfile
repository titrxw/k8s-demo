FROM php:7.4-cli


ADD  ./w7-rangine-empty/ /home/www/w7-rangine-empty/
ADD ./entrypoint.sh /home/docker/

WORKDIR /home/www/w7-rangine-empty

RUN chmod 777 ./ -R \
    && chmod 777 /home/docker/entrypoint.sh

EXPOSE 80

ENTRYPOINT [ "/home/docker/entrypoint.sh" ]