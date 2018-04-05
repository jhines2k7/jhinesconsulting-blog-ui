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

#concatenate minified css files
cp assets/css/bootstrap.min.css assets/css/font-awesome.min.css .tmp
cat .tmp/bootstrap.min.css .tmp/font-awesome.min.css > .tmp/lib.min.css

#concatenate main, barfiller, and responsive
cp main.css assets/css/responsive.css assets/css/bar-filler.css .tmp
cat .tmp/main.css .tmp/responsive.css .tmp/bar-filler.css > .tmp/main.tmp.css

# minify main.tmp.css
node_modules/.bin/uglifycss .tmp/main.tmp.css --output .tmp/main.min.css

# concatenate all minified css
cat .tmp/lib.min.css .tmp/main.min.css > dist/app.min.css
