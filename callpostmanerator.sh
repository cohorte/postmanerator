#! /bin/sh

mkdir -p /usr/var/docs/assets
mkdir -p /usr/var/docs/fonts
cp -rf /root/.postmanerator/themes/cohorte/assets/* /usr/var/docs/assets/.
cp -rf /root/.postmanerator/themes/cohorte/fonts/* /usr/var/docs/fonts/.

echo "<html><head><title>REST API Documentation</title></head><body>" > /usr/var/docs/index.html
echo "<h2>REST API Documentation</h2><ul>" >> /usr/var/docs/index.html

ENVIRONMENT=$(cat /usr/var/environments/environment.txt)
COLLECTIONS_FILE="/usr/var/collections/collections.txt"
while read line
do
    [ -z "$line" ] && continue
    echo "Reading collection: $line"    
    postmanerator \
       -theme "cohorte" \
       -collection /usr/var/collections/${line}.json \
       -environment /usr/var/environments/${ENVIRONMENT}.json \
       -output /usr/var/docs/${line}.html \
       $@
    echo "<li><a href='${line}.html'>${line}</a></li>" >> /usr/var/docs/index.html    
done < $COLLECTIONS_FILE

echo "</ul>" >> /usr/var/docs/index.html
echo "</body>" >> /usr/var/docs/index.html

#weasyprint /usr/var/*.html /usr/var/output.pdf