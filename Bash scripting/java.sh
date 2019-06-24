#! /bin/bash

### to install the java 1.8 version in centos ###

# cd /opt/
# wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.tar.gz"
# tar xzf jdk-8u201-linux-x64.tar.gz

# ###Install Java 8 with Alternatives
# cd jdk1.8.0_201/
# alternatives --install /usr/bin/java java /opt/jdk1.8.0_201/bin/java 2
# alternatives --config java

# alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_201/bin/jar 2
# alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_201/bin/javac 2
# alternatives --set jar /opt/jdk1.8.0_201/bin/jar
# alternatives --set javac /opt/jdk1.8.0_201/bin/javac

# #to check java version
# java -version

# ### Setup Java Environment Variables ###
# cat >> /etc/environment <<EOL
# JAVA_HOME=/usr/lib/jvm/java-8-oracle
# JRE_HOME=/usr/lib/jvm/java-8-oracle/jre
# EOL

# #Also add the above commands to /etc/bashrc or /etc/environment file to auto set environment variables during the system reboot


###########################################################################################################################################


### to install the java 1.8 version in ubuntu ###

# sudo add-apt-repository ppa:webupd8team/java # install the repository
# sudo apt-get update
# sudo apt-get install oracle-java8-installer
# sudo apt install openjdk-8-jdk 
apt-get update
apt-get -y install software-properties-common
sudo apt-get update
sudo add-apt-repository ppa:linuxuprising/java
sudo apt-get update
sudo apt-get install oracle-java12-installer

### Verify Java Inatallation 
sudo apt-get install oracle-java12-set-default

# sudo apt-get install oracle-java8-set-default
java -version

# Example Output:
# java version "1.8.0_201"
# Java(TM) SE Runtime Environment (build 1.8.0_201-b09)
# Java HotSpot(TM) 64-Bit Server VM (build 25.201-b09, mixed mode) 

### Java Home Environment

cat /etc/profile.d/jdk.sh

export J2SDKDIR=/usr/lib/jvm/java-12-oracle
export J2REDIR=/usr/lib/jvm/java-12-oracle
export PATH=$PATH:/usr/lib/jvm/java-12-oracle/bin:/usr/lib/jvm/java-12-oracle/db/bin
export JAVA_HOME=/usr/lib/jvm/java-12-oracle
export DERBY_HOME=/usr/lib/jvm/java-12-oracle/db

sudo echo $JAVA_HOME

# Example Output:
# root@1804:~# echo $JAVA_HOME
# /usr/lib/jvm/java-8-oracle/jre/bin/java


#####to install the java 1.8 version in centos#######
# yum -y update