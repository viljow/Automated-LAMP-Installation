#!/bin/bash
root_mysql_passwd = ""

echo "###################################################################################"
echo "Starting installation of LAMP"
echo "###################################################################################"

sudo apt update
sudo apt -y install apache2 php5 libapache2-mod-php5 php5-mcrypt php5-curl php5-mysql php5-gd php5-cli php5-dev mysql-client
php5enmod mcrypt

sudo debconf-set-selections <<< 'mariadb-server mariadb-server/root_password password $root_mysql_passwd'
sudo debconf-set-selections <<< 'mariadb-server mariadb-server/root_password_again password $root_mysql_passwd'
sudo apt-get -y install mariadb-server

echo -e "\n"

service apache2 restart && service mysql restart > /dev/null

echo -e "\n"

if [ $? -ne 0 ]; then
   echo "An error has occured!"
else
   echo "Install status: $(tput bold)$(tput setaf 2)SUCESS$(tput sgr0)"
fi

echo -e "\n"
