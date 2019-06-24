#!/bin/bash
sudo yum install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-6-x86_64/pgdg-redhat10-10-1.noarch.rpm
sudo yum install postgresql10-server postgresql10
sudo /usr/pgsql-10/bin/postgresql-10-setup initdb
sudo systemctl start postgresql-10
sudo systemctl enable postgresql-10
sudo systemctl status postgresql-10
