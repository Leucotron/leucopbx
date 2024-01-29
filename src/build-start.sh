#!/bin/bash
PROGNAME=$(basename $0)

set -ex

## import system information vars
. /etc/os-release 

## disable screen requests
DEBIAN_FRONTEND=noninteractive 

## set timezone
TZ=America/Sao_Paulo
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

apt-get -y update
apt-get -y upgrade
apt-get install -y tzdata supervisor apt-utils
apt-get -y install build-essential git curl wget libnewt-dev libssl-dev libncurses5-dev subversion libsqlite3-dev libjansson-dev libxml2-dev uuid-dev default-libmysqlclient-dev htop sngrep lame ffmpeg mpg123
apt-get -y install git vim curl wget libnewt-dev libssl-dev libncurses5-dev subversion libsqlite3-dev build-essential libjansson-dev libxml2-dev uuid-dev expect
apt-get install -y build-essential openssh-server apache2 mariadb-server mariadb-client bison flex php8.2 php8.2-curl php8.2-cli php8.2-common php8.2-mysql php8.2-gd php8.2-mbstring  php8.2-intl php8.2-xml php-pear curl sox libncurses5-dev libssl-dev mpg123 libxml2-dev libnewt-dev sqlite3  libsqlite3-dev pkg-config automake libtool autoconf git unixodbc-dev uuid uuid-dev libasound2-dev libogg-dev libvorbis-dev libicu-dev libcurl4-openssl-dev odbc-mariadb libical-dev libneon27-dev libsrtp2-dev  libspandsp-dev sudo subversion libtool-bin python-dev-is-python3 unixodbc vim wget libjansson-dev software-properties-common nodejs npm ipset iptables fail2ban php-soap
apt-get install -y cron

mkdir -p /var/log/supervisor

./build-asterisk.sh

./build-freepbx.sh

apt-get clean

exec rm -f /build-start.sh

