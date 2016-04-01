* Project starter.
** Use this blank template for starting a lumen app running in a docker container with nginx and php7.

It's not as easy as I'd like it to be yet, but this takes care of some setup so that I can begin developing asap.

** Get started
* Clone the repo.
`git clone https://github.com/mgonzo/php7-lumen.git

* Rename the directory whatever you want

* Open `default` and change the name 'app' on lines 8 and 28 to the name you will use when you generate the lumen app.

* Build the image:
`docker build -t nameofyourimage .`
`docker run --name nameofyourcontainer -p 80:80 -v /absolute/path/to/data:/data -d nameofyourimage`

* After building the docker, you need to generate a lumen app with the same name that is in the nginx default.
`docker exec -t -i nameofyourcontainer bash -l`

* Now you are in the container
`cd /data`
`lumen new nameofyourapp`
**note: the name of your app must match the name that you put in the default config file**
`chown -R 1000:www-data nameofyourapp`
`exit`

There is no database included.


cd /data
lumen new appname
chown -R 1000:www-data appname
chmod -R 774 appname/
