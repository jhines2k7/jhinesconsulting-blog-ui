#!/usr/bin/env bash
VERSION=0.8.0

# clean the dist directory
if [ -d dist ]; then
    rm -rf dist
fi

if [ ! -d dist ]; then
    mkdir dist
fi

# clean the .tmp directory
if [ -d .tmp ]; then
    rm -rf .tmp
fi

if [ ! -d .tmp ]; then
    mkdir .tmp
fi

cp js/*.js .tmp

# js compile and transform
node_modules/.bin/riot js .tmp && node_modules/.bin/webpack --config=webpack.config.js

# modify the value of the domain object in the config file
sed -i "s/domain: 'localhost'/domain: '192.168.99.101'/g" dist/bundle.js

#copy the assets to dist directory
cp -r assets dist

# copy index.html to dist directory
cp index.html dist

#copy css file to dist directory
cp m

# change the src property of the script tag to bundle.js
sed -i 's/dist\/bundle.js/bundle.js/g' dist/index.html

docker login --username=$DOCKER_HUB_USER --password=$DOCKER_HUB_PASSWORD

docker build -t jhines2017/jhines-consulting-blog:$VERSION .

docker push jhines2017/jhines-consulting-blog:$VERSION

date; echo;
