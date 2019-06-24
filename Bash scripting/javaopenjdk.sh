#! bin/bash

sudo apt-get update
sudo apt-get install software-properties-common

sudo add-apt-repository -y ppa:openjdk-r/ppa

sudo apt-get -y update

sudo apt-get -y install openjdk-8-jdk

sudo update-alternatives -y --config java

java -version

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

sudo echo $JAVA_HOME