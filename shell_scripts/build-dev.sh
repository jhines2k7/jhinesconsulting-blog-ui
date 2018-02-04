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

# modify the value of the domain object in the config file
sed -i "s/domain: 'localhost'/domain: $CONTACT_FORM_SUBMISSION_SERVICE_HOSTNAME/g" dist/bundle.js
