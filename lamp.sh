#!/bin/bash

if [ -z $1 ]; then
   echo "You must enter the root MySQL password as an argument!"
   exit 1
fi

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "###################################################################################"
echo "Starting installation of LAMP stack"
echo "###################################################################################"

apt update
apt -y install apache2 php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-mysql php5-gd php5-cli php5-dev mysql-client
php5enmod mcrypt

debconf-set-selections <<< 'mariadb-server-5.5 mysql-server/root_password password $1'
debconf-set-selections <<< 'mariadb-server-5.5 mysql-server/root_password_again password $1'
apt -y install mariadb-server

echo -e "\n"

service apache2 restart && service mysql restart > /dev/null

echo -e "\n"

if [ $? -ne 0 ]; then
   echo "An error has occured!"
else
   echo "Install status: $(tput bold)$(tput setaf 2)SUCESS$(tput sgr0)"
fi

echo -e "\n"
