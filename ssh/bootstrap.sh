#!/bin/sh -e

apt-get install openssh-server
systemctl enable ssh
systemctl start ssh

useradd -m sshuser && echo "sshuser:pass" | chpasswd
sshuser_home=/home/sshuser
echo 'pass' | sudo -S su - sshuser -c <<EOF
mkdir -p $sshuser_home/team
chmod 770 $sshuser_home/team
cd $sshuser_home/team
whoami > README.md
EOF
