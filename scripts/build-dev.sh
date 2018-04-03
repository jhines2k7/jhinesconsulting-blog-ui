#!/usr/bin/env bash
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

sed -i "s/contactFormServiceIP: ''/contactFormServiceIP: '$CONTACT_FORM_SERVICE_IP'/g" dist/bundle.js