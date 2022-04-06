#! /bin/sh -xe
ansible -m command -a 'apt-get install -y python3-certbot-apache' apache
ansible -m command -a "echo certbot --apache --email {{ admin_email }} -d {{ lookup('dig', groups['fip'][0] + '/PTR') | regex_replace('\\.$', '') }} -d {{ public_hostname }}" apache
