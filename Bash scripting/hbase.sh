#! /bin/bash

### to install java 12 for hbase ###
sudo apt-get -y update #to update the latest versions of the built in apps in the container
sudo apt-get -y install software-properties-common #to install all the required applications needed inthe container
sudo apt-get -y update #we need to upate again 
sudo add-apt-repository -y ppa:linuxuprising/java #we add the java website to the apt repository
sudo apt-get -y update #we then update
echo oracle-java12-installer shared/accepted-oracle-license-v1-2 select true | sudo /usr/bin/debconf-set-selections #while installing java it will ask to accept the licence to say yes we write this command
sudo apt-get -y install oracle-java12-installer # then we install java hint:only java12 is availaibe for free or else we need to get taz file for other versions

### Verify Java Inatallation 
sudo apt-get -y install oracle-java12-set-default # to set the java as default

# sudo apt-get install oracle-java8-set-default
java -version # to check the corrent version

# Example Output:
# java version "1.8.0_201"
# Java(TM) SE Runtime Environment (build 1.8.0_201-b09)
# Java HotSpot(TM) 64-Bit Server VM (build 25.201-b09, mixed mode) 

### Java Home Environment

cat /etc/profile.d/jdk.sh # to export the env file

export J2SDKDIR=/usr/lib/jvm/java-12-oracle
export J2REDIR=/usr/lib/jvm/java-12-oracle
export PATH=$PATH:/usr/lib/jvm/java-12-oracle/bin:/usr/lib/jvm/java-12-oracle/db/bin
export JAVA_HOME=/usr/lib/jvm/java-12-oracle
export DERBY_HOME=/usr/lib/jvm/java-12-oracle/db

###RUN echo "export JAVA_HOME=/root/opt/jdk-12.0.1" >> /etc/profile.d/jdk12.sh
###RUN echo "export PATH=/root/opt/jdk-12.0.1/bin" >> /etc/profile.d/jdk12.sh 

sudo echo $JAVA_HOME # to find where the java is mapped to

# Example Output:
# root@1804:~# echo $JAVA_HOME
# /usr/lib/jvm/java-8-oracle/jre/bin/java

### to install hbase ###

###download hbase tar file from http://mirrors.estointernet.in/apache/hbase/
cd
sudo mkdir hduser
cd hduser
sudo wget http://us.mirrors.quenda.co/apache/hbase/1.3.4/hbase-1.3.4-bin.tar.gz # to download the tar file from the website location
# sudo apt-get update 
# sudo mv /home/roxor/Downloads/hbase-1.3.4-bin.tar.gz /home/roxor/hduser/ # to move the tar file to the folder
sudo tar -xvf hbase-1.3.4-bin.tar.gz # to inside the folder and extract

cd
# sudo chown -R roxor:roxor hduser
# sudo chmod -R 755 hduser
###paste the JAVA_HOME path inside
sudo echo "export JAVA_HOME=/usr/lib/jvm/java-12-oracle
export PATH=/usr/lib/jvm/java-12-oracle/bin" >> /hduser/hbase-1.3.4/conf/hbase-env.sh # to map the path to the hbase env as it uses java


sudo echo "export HBASE_HOME=/hduser/hbase-1.3.4 
export PATH= $PATH:$HBASE_HOME/bin" >> ~/.bashrc # map hbase to the home dir so that we can use  

sudo echo "<property>

<name>hbase.rootdir</name>

<value>file:///hduser/HBASE/hbase</value>

</property>

<property>

<name>hbase.zookeeper.property.dataDir</name>

<value>/hduser/HBASE/zookeeper</value>

</property>" >> /hduser/hbase-1.3.4/conf/hbase-site.xml # we map the hbase file here

cd /etc/
cat hosts
cd
cd hduser/hbase-1.3.4/bin
sudo chmod 755 start-hbase.sh
./start-hbase.sh # we start the hbase
jps
hbase shell