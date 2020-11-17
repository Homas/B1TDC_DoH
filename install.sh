#!/bin/bash
#(c) Vadim Pavlov 2020 ioc2rpz(at)gmail[dot]com

if [[ $EUID -ne 0 ]]; then
    echo "The script requires root priviligies."
    echo "Run 'sudo bash $0'"
    exit 1
fi

SYSUSER=`who am i | awk '{print $1}'`

mkdir -p /opt/b1tdc_doh_data/ssl
mkdir -p /opt/b1tdc_doh_data/ssl/certs
mkdir -p /opt/b1tdc_doh_data/ssl/private
mkdir -p /opt/b1tdc_doh_data/certbot_log
mkdir -p /opt/b1tdc_doh_data/nginx_log
chown -R $SYSUSER /opt/b1tdc_doh_data

sudo yum install docker
sudo systemctl enable docker
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

yum install httpd-tools

echo "Don't forget to create .env file where you will start docker compose"