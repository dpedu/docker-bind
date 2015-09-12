docker-bind
===========
**Container for running bind 9**

Quick start
-----------

* Pull: `docker pull dpedu/bind`
* Run: `docker run --name="nameserver "-p 53:53 -v /data/bindconfig:/etc/bind dpedu/bind`

Getting the default config
--------------------------

The above example expect a directory with all the configuration bind needs. But you probably
don't have that if you're starting out. So extract it from the image:

* Run a copy that immediately exits: `docker run --name="tempbind" dpedu/bind bash`
* Extract the files: `docker cp tempbind:/etc/bind/ /tmp/`
* Delete temp container: `docker rm tempbind`

