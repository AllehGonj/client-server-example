#!/bin/sh -e

apt-get update
apt-get -y install nginx inotify-tools
systemctl start nginx

mv /vagrant/www/* /var/www/html/
while inotifywait -r -e modify,create,delete,move /vagrant/www/; do
    rsync -a /vagrant/www/ /var/www/html/
done &
