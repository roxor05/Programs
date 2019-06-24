#!/bin/bash
PATH=$PATH:/usr/libexec # CentOS puts mysqld here
HOST=localhost
if [ -z "$HOST" ];
then
	HOST="OrzotaGateway01"
fi

echo "Expected lsb_release -a"
cat<<++
anitha@varsini$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 12.04.1 LTS
Release:        12.04
Codename:       precise
++
echo "Host[$HOST] verify lsb_release -a output"
lsb_release -a
echo ""

echo "Expected lsb_release -a"
cat<<++
anitha@varsini$ uname -a
Linux ip-10-136-85-56 3.2.0-36-virtual #57-Ubuntu SMP Tue Jan 8 22:04:49 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
++
echo "Host[$HOST] verify lsb_release -a output"
uname -a
echo ""

echo "Expected git version output"
cat<<++
anitha@varsini:~$ git --version
git version 1.7.9.5
++
echo "Host[$HOST] verify git version"
git --version
echo ""

exit 0
