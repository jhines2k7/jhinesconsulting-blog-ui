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

 timestamp=$(date "+%Y%m%d_%H%M%S")
 append # to end of js file for cache busting
 mv dist/bundle.js dist/bundle-$timestamp.js
 mv dist/bundle.js.map dist/bundle-$timestamp.js.map

 change the src property of the script tag to app.js
sed -i "s/dist\/bundle.js/dist\/bundle-\${timestamp}.js/g" index.html

date; echo;
