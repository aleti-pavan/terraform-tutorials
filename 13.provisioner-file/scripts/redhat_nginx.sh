#!/bin/bash
echo '[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/$basearch/
gpgcheck=0
enabled=1' | tee  /etc/yum.repos.d/nginx.repo

yum -y install nginx
systemctl start nginx
echo "<h1>Welcome to DevOps Classes, Keep Learning</h1>" | tee /usr/share/nginx/html/index.html
