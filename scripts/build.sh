#!/usr/bin/env bash
VERSION=0.51.11

echo "Contact form submission service ip: "
echo $CONTACT_FORM_SERVICE_IP

cd /home/james/projects/jhinesconsulting/jhinesconsulting-blog-ui

npm install

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

# remove all console.log occurrences
find .tmp -name "*.js" -type f | xargs sed -i '/console.log/d'

# modify the value of the contact form service ip object in the config file
sed -i "s/contactFormServiceIP: ''/contactFormServiceIP: '$CONTACT_FORM_SERVICE_IP'/g" dist/bundle.js

#copy the assets to dist directory
cp -r assets/ dist

# "clearing" the css directory
rm -rf dist/assets/css
mkdir dist/assets/css

#copy the data to dist directory
cp -r data dist

# copy index.html to dist directory
cp index.html dist

NEW_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)

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

# append hash to end of css file for cache busting
mv dist/app.min.css dist/assets/css/app.min.$NEW_UUID.css

# append hash to end of js file for cache busting
#mv dist/bundle.js dist/bundle.$NEW_UUID.js
#mv dist/bundle.js.map dist/bundle.$NEW_UUID.js.map

#uglify bundle.js
node_modules/.bin/uglifyjs dist/bundle.js --compress --mangle -o dist/bundle.$NEW_UUID.min.js

# update file name of js bundle
sed -i "s/dist\/bundle.js/bundle.$NEW_UUID.min.js/g" dist/index.html

# update file name of main.css
sed -i "s/main.css/dist\/assets\/css\/app.min.$NEW_UUID.css/g" dist/index.html

# remove other css imports
sed -i '/bootstrap.min.css/d' dist/index.html
sed -i '/font-awesome.min.css/d' dist/index.html
sed -i '/bar-filler.css/d' dist/index.html
sed -i '/responsive.css/d' dist/index.html

docker login --username=$DOCKER_HUB_USER --password=$DOCKER_HUB_PASSWORD

docker build -t jhines2017/jhinesconsulting-blog-ui:$VERSION .

docker push jhines2017/jhinesconsulting-blog-ui:$VERSION

rm -rf node_modules .tmp dist
