#! /bin/sh

mkdir -p /usr/var/assets
mkdir -p /usr/var/fonts
cp -rf /root/.postmanerator/themes/cohorte/assets/* /usr/var/assets/.
cp -rf /root/.postmanerator/themes/cohorte/fonts/* /usr/var/fonts/.
postmanerator $@
#weasyprint /usr/var/*.html /usr/var/output.pdf