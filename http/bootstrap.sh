apt-get update
apt-get -y install nginx
systemctl start nginx

mv /vagrant/www/* /var/www/html
