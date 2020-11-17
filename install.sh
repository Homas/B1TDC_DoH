#!/bin/bash
#(c) Vadim Pavlov 2020 ioc2rpz(at)gmail[dot]com
#to install
#cd ~
#git clone https://github.com/Homas/B1TDC_DoH.git
#sudo bash ./B1TDC_DoH/install.sh

if [[ $EUID -ne 0 ]]; then
    echo "The script requires root priviligies."
    echo "Run 'sudo bash $0'"
    exit 1
fi

SYSUSER=`who am i | awk '{print $1}'`

cp -r ./B1TDC_DoH/b1tdc_doh_data /opt
cp -r ./B1TDC_DoH/nginx /opt
cp -r ./B1TDC_DoH/nginx-certbot /opt

cp -r ./B1TDC_DoH/b1tdc_doh_data/nginx_advanced.conf /opt/nginx_advanced.conf


mkdir -p /opt/b1tdc_doh_data/ssl
mkdir -p /opt/b1tdc_doh_data/ssl/certs
mkdir -p /opt/b1tdc_doh_data/ssl/private
mkdir -p /opt/b1tdc_doh_data/certbot_log
mkdir -p /opt/b1tdc_doh_data/nginx_log
chown -R $SYSUSER /opt/b1tdc_doh_data

yum install docker
systemctl enable docker
service docker start
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

yum install httpd-tools git

echo "
1. To run nginx with certbot navigate to nginx-certbot
Create .env file and start the service with the following command:
sudo docker-compose up

check for any errors and fix them
to run the service in backgroud execute:
sudo docker-compose up -d

2. To run nginx only navigate to nginx and start the service with the following command:
sudo docker-compose up

check for any errors and fix them
to run the service in backgroud execute:
sudo docker-compose up -d

You also need to automatically pull new SSL certificates. You may set up a cron job to do so.
"

#crontab on secondary root host
#export ROOT_HOST=54.189.96.174; scp ec2-user@$ROOT_HOST:/opt/b1tdc_doh_data/ssl/certs/doh.pem /opt/b1tdc_doh_data/ssl/certs/doh.pem && scp ec2-user@$ROOT_HOST:/opt/b1tdc_doh_data/ssl/private/doh.pem /opt/b1tdc_doh_data/ssl/private/doh.pem