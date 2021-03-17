#!/bin/bash

apt-get update
apt-get install -y vsftpd
cp /etc/vsftpd.conf /etc/vsftpd.conf.original

ufw allow ftp-data
ufw allow ftp

mkdir -p /var/ftp/pub
chown nobody:nogroup /var/ftp/pub
echo "vsftpd test file" | tee /var/ftp/pub/test.txt

useradd -m ftpuser && echo "ftpuser:pass" | chpasswd
mkdir -p /home/ftpuser/ftp/files
chown nobody:nogroup /home/ftpuser/ftp
chmod a-w /home/ftpuser/ftp
chown ftpuser:ftpuser /home/ftpuser/ftp/files
echo "vsftpd sample file" | tee /home/ftpuser/ftp/files/sample.txt
