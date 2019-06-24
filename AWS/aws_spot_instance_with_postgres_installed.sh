#!/bin/bash
# using shell script with aws-cli command, try to create a spot instance and in that instance, install and start postgresql service in it within a shell script

echo "Hello"
echo "lets create a spot instance"  
echo "please enter the type of instance you need"
read instance_type;
echo $instance_type

echo '{
      "ImageId": "ami-074acc26872f26463",
      "KeyName": "access-data-aces",
      "SecurityGroupIds": ["sg-01bc56ba9bb1b747a"],
      "InstanceType": "",
      "SubnetId": "subnet-0542a543654782ddd",
      "Placement": {
        "AvailabilityZone": "us-east-1f"
      }
}' >> awsspotinstancecreation.json

sed -i "s/\"InstanceType\":.*,$/\"InstanceType\": \"${instance_type}\",/g" awsspotinstancecreation.json
#sed 's/"InstanceType": "",/"InstanceType": "${instance_type}"/g' awsspotinstancecreation.json

# aws ec2 describe-spot-price-history --instance-types $b --start-time $(date +%s) | grep -w 'SpotPrice'

output=$(aws --region=us-east-1 ec2 describe-spot-price-history --instance-types $instance_type --start-time $(date +%s) | grep -w 'SpotPrice' | awk '/SpotPrice/{spotprice=$2 ; print spotprice ; }' | sed 's/\"//g')

echo "$output" >> output.txt

price=$(cut -f1 -d"," output.txt | sort -n | tail -1) 

echo "$price"

price_final=$(echo "scale=5; $price + (30/100)*$price" | bc)

echo "$price_final"  

spotins_id=$(aws ec2 request-spot-instances --spot-price "$price_final" --instance-count 1 --type "one-time" --launch-specification file://awsspotinstancecreation.json | grep -w SpotInstanceRequestId | awk '/SpotInstanceRequestId/{spot_id=$2 ; print spot_id ; }' | sed 's/\,//g'| sed 's/\"//g') #here we need to change the instance type as well as the ami_id in the json file
echo "$spotins_id" # to get the spot instance request id 

rm -f awsspotinstancecreation.json # to delete the json file after use  
rm -f output.txt # to delete the output txt file

sleep 5m

new_inst_id=$(aws ec2 describe-spot-instance-requests --filters "Name=spot-instance-request-id,Values=$spotins_id" | grep -w InstanceId |awk '/InstanceId/{ins_id=$2 ; print ins_id ; }' | sed 's/\,//g'| sed 's/\"//g')
echo "$new_inst_id"inst_ip=$(aws ec2 describe-instances --instance-ids $new_inst_id | awk '/PublicIpAddress/{ip_add=$2 ; print ip_add ; }' | sed 's/\,//g'| sed 's/\"//g')

inst_ip=$(aws ec2 describe-instances --instance-ids $new_inst_id | awk '/PublicIpAddress/{ip_add=$2 ; print ip_add ; }' | sed 's/\,//g'| sed 's/\"//g')
echo "$inst_ip"


rm -f awsspotinstancecreation.json # to delete the json file after use  
rm -f output.txt # to delete the output txt file
 

# to connect to the instance 
USER=centos # user of the instance
# scp -i /home/roxor/access /home/roxor/doc.sh centos@34.217.130.132:/home/centos
HOST=$inst_ip #host ip address
KEY=/home/roxor/access-data-aces.pem #access key for the instance
SSH="ssh -i $KEY -o StrictHostKeyChecking=no $USER@$HOST" #connecting to the instance ssh -i /home/roxor/access-data-aces.pem centos@3.80.6.179
SSHOPT="-t" # this will include the commands in the instance. see command2 in the comments to understand the use
#FILE=running.txt
#R_HOME=/home/$USER
#SCP="scp -i $KEY $FILE $USER@$HOST:$R_HOME" # for testing
#sudo ssh -i /home/roxor/access-data-aces.pem ec2-root@ec2-$inst_ip.compute-1.amazonaws.com
#SCP="scp -rp -i $KEY -o StrictHostKeyChecking=no $USER@$HOST:/home/centos/$FILE /home/roxor/"
#LOCAL="/home/roxor/" #copying file to local

# COMMAND="$SSH" 
# echo "$COMMAND"
# $COMMAND

COMMAND1="$SSH $SSHOPT sudo yum -y update" 
echo "$COMMAND1"
$COMMAND1

COMMAND2="$SSH $SSHOPT sudo yum -y install postgresql postgresql-contrib"
echo "$COMMAND2"
$COMMAND2

COMMAND="$SSH" 
echo "$COMMAND"
$COMMAND
