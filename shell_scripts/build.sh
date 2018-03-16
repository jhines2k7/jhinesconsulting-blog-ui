#!/usr/bin/env bash
VERSION=0.35.5

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

# modify the value of the contact form service ip object in the config file
sed -i "s/contactFormServiceIP: ''/contactFormServiceIP: '$CONTACT_FORM_SERVICE_IP'/g" dist/bundle.js

#copy the assets to dist directory
cp -r assets dist

#copy the data to dist directory
cp -r data dist

# copy index.html to dist directory
cp index.html dist

#copy css file to dist directory
cp main.css dist

NEW_UUID=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)
# append hash to end of css file for cache busting
mv dist/main.css dist/main.$NEW_UUID.css

# append hash to end of js file for cache busting
mv dist/bundle.js dist/bundle.$NEW_UUID.js
mv dist/bundle.js.map dist/bundle.$NEW_UUID.js.map

# update file name of js bundle
sed -i "s/dist\/bundle.js/bundle.$NEW_UUID.js/g" dist/index.html

# update file name of main.css
sed -i "s/main.css/main.$NEW_UUID.css/g" dist/index.html

docker login --username=$DOCKER_HUB_USER --password=$DOCKER_HUB_PASSWORD

docker build -t jhines2017/jhinesconsulting-blog-ui:$VERSION .

docker push jhines2017/jhinesconsulting-blog-ui:$VERSION

rm -rf node_modules .tmp dist
