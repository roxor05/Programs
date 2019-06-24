#! /bin/bash

### to install java 12 for zookeeper ###
sudo apt-get -y update
sudo apt-get -y install software-properties-common
sudo apt-get -y update
sudo add-apt-repository -y ppa:linuxuprising/java
sudo apt-get -y update
echo oracle-java12-installer shared/accepted-oracle-license-v1-2 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get -y install oracle-java12-installer

### Verify Java Inatallation 
sudo apt-get -y install oracle-java12-set-default

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

###RUN echo "export JAVA_HOME=/root/opt/jdk-12.0.1" >> /etc/profile.d/jdk12.sh
###RUN echo "export PATH=/root/opt/jdk-12.0.1/bin" >> /etc/profile.d/jdk12.sh 

sudo echo $JAVA_HOME

# Example Output:
# root@1804:~# echo $JAVA_HOME
# /usr/lib/jvm/java-8-oracle/jre/bin/java

#### download the latest zookeeper tar file from http://zookeeper.apache.org/releases.html
# sudo adduser hadoop
mkdir hduser
# sudo chown -R hadoop:hadoop /hduser
cd hduser
sudo wget http://mirrors.estointernet.in/apache/zookeeper/zookeeper-3.4.14/zookeeper-3.4.14.tar.gz
# mv /Home/user/Downloads/zookeeper-3.4.14.tar.gz /Home/user/hduser 
tar -zxf zookeeper-3.4.14.tar.gz
cd zookeeper-3.4.14
mkdir data
# sudo chown -R hadoop:hadoop /data

echo "tickTime = 2000
dataDir = /hduser/zookeeper-3.4.14/data #need to specify this
clientPort = 2181
initLimit = 5
syncLimit = 2" >> hduser/zookeeper-3.4.14/conf/zoo.cfg 

cd 


sudo mkdir /var/lib/zookeeper 
# cd /var/lib
# sudo chown -R hadoop:hadoop zookeeper/
sudo mkdir /var/log/zookeeper
# cd /var/log
# sudo chown -R hadoop:hadoop zookeeper/
sudo echo "export ZOO_LOG_DIR=/var/log/zookeeper" >> ~/.bashrc

bin/zkServer.sh start # to start zookeeper server
bin/zkCli.sh # to open console
# bin/zkServer.sh stop # to stop the zookeeper server