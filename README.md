This is a blank template for starting a lumen app running in a docker with nginx.

There is no database included.

After building the docker, the app should be created with the same name that is in
the nginx default conf.

cd /data
lumen new appname
chown -R 1000:www-data appname
chmod -R 774 appname/
