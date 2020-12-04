# DoT/DoH proxy in AWS for B1TDC
In this project I've implemented a simple DoT/DoH proxy based on NGINX and certbot for AWS.  
The project contains the following folders:
- nginx-certbot contains a docker compose file to start NGINX and certbot services.
- nginx contains a docker compose file to start NGINX service only on secondary servers.
Certbot is using DNS-Route53 domain challenge to authenticate that you own a domain.
Required AWS permisssions are covered in the official certbot plugin configuration: `https://certbot-dns-route53.readthedocs.io/en/stable/`.
To pass the domain name, AWS API Key Id, AWS API Key and email in `.env` file located in the directory with `docker-compose.yml` file.


https://www.nginx.com/blog/using-nginx-as-dot-doh-gateway/

You may enable basic authentication on DoH. To add users use the following command:
```
/usr/bin/htpasswd -cb /opt/b1tdc_doh_data/users.passwd dohuser dohpassword
```