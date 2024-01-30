#!/bin/bash
PROGNAME=$(basename $0)

if test -z ${FREEPBX_VERSION}; then
  echo "${PROGNAME}: FREEPBX_VERSION required" >&2
  exit 1
fi

groupadd asterisk
useradd -r -d /var/lib/asterisk -g asterisk asterisk
usermod -aG audio,dialout asterisk
chown -R asterisk:asterisk /etc/asterisk
chown -R asterisk:asterisk /var/{lib,log,spool}/asterisk
chown -R asterisk:asterisk /usr/lib64/asterisk
mkdir /home/asterisk
chown -R asterisk:asterisk /home/asterisk
   
sed -i 's|#AST_USER|AST_USER|' /etc/default/asterisk
sed -i 's|#AST_GROUP|AST_GROUP|' /etc/default/asterisk
sed -i 's|;runuser|runuser|' /etc/asterisk/asterisk.conf
sed -i 's|;rungroup|rungroup|' /etc/asterisk/asterisk.conf
echo "/usr/lib64" >> /etc/ld.so.conf.d/x86_64-linux-gnu.conf
ldconfig

sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php/8.2/apache2/php.ini
sed -i 's/\(^memory_limit = \).*/\1256M/' /etc/php/8.2/apache2/php.ini
sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/apache2/apache2.conf
sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
a2enmod rewrite
systemctl restart apache2
rm /var/www/html/index.html

cat <<EOF > /etc/odbcinst.ini
[MySQL]
Description = ODBC for MySQL (MariaDB)
Driver = /usr/lib/x86_64-linux-gnu/odbc/libmaodbc.so
FileUsage = 1
EOF

cat <<EOF > /etc/odbc.ini
[MySQL-asteriskcdrdb]
Description = MySQL connection to 'asteriskcdrdb' database
Driver = MySQL
Server = 127.0.0.1
Database = asteriskcdrdb
Port = 3306
Option = 3
EOF

cd /usr/local/src
wget http://mirror.freepbx.org/modules/packages/freepbx/freepbx-${FREEPBX_VERSION}-latest-EDGE.tgz
tar zxvf freepbx-${FREEPBX_VERSION}-latest-EDGE.tgz
cd /usr/local/src/freepbx/
./start_asterisk start
service mariadb start
./install -n
fwconsole ma installall
fwconsole reload

fwconsole restart
sleep 5

fwconsole stop
service mariadb stop