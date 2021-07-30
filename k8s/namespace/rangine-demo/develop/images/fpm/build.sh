#!/bin/sh

CUR_DIR=$(pwd)
SOURCE_DIR="$CUR_DIR/w7-rangine-empty"

if [ -f "$SOURCE_DIR/composer.json" ]; then
    cd $SOURCE_DIR && composer install --no-dev
fi

cd $CUR_DIR && docker build -f "$CUR_DIR/Dockerfile" -t rangine-fpm-demo .

# push
# docker login  -u $1 -p $2

# docker tag rangine-demo  $1/rangine-demo

# docker push $1/rangine-demo

