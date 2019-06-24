#! bin/bash

echo "Please provide the IP address of the instance below"
read ip_address

#code to get the instance id alone 
instance_id=$(aws ec2 describe-instances  --filters "Name=ip-address,Values=$ip_address" | grep -w "InstanceId\|PublicIpAddress" | awk '/InstanceId/{instance_id=$2 ; print instance_id ; }' | sed 's/\"//g' | sed 's/\,//g')
echo $instance_id # you need to echo it then only the sed command works 

#code to get the image id of the created ami from the instance
ami_id=$(aws ec2 create-image --instance-id $instance_id --name "shrikkanth" --description "test for sh to work" | awk '/ImageId/{image_id=$2 ; print image_id ; }' | sed 's/\"//g' | sed 's/\://g')
echo $ami_id # you need to echo it then only the sed command works 

#to get the price of the spot instance so that it can be used 
echo "lets get the highest price of the spot instance"  
echo "please enter the type of instance you need"
read instance_type; # to know what the user needs like t2.small ,nano, medium ,etc

output=$(aws --region=us-east-1 ec2 describe-spot-price-history --instance-types $instance_type --start-time $(date +%s) | grep -w 'SpotPrice' | awk '/SpotPrice/{spotprice=$2 ; print spotprice ; }' | sed 's/\"//g')

echo "$output" >> output.txt # all the prices at the time period is stored here

price=$(cut -f1 -d"," output.txt | sort -n | tail -1) # the file is sorted in arranging order and the last number which is the biggest no is called 

echo "$price" # the biggest number

price_final=$(echo "scale=5; $price + (30/100)*$price" | bc) #the price is now changed to 30% higher so that the instances will be there

echo "$price_final"  #the final price after +30% of the highest price

echo '{
	  "ImageId": "",
	  "KeyName": "access-data-aces",
	  "SecurityGroupIds": ["sg-01bc56ba9bb1b747a"],
	  "InstanceType": "",
	  "SubnetId": "subnet-0542a543654782ddd",
	  "Placement": {
	    "AvailabilityZone": "us-east-1f"
	  }
}' >> awsspotinstancecreation.json #this json file is the launch-specification file for creating spot instance .... its a must

sed -i "s/\"ImageId\":.*,$/\"ImageId\": \"${ami_id}\",/g" awsspotinstancecreation.json # to add the instance type in the json file after the user inputs the value

sed -i "s/\"InstanceType\":.*,$/\"InstanceType\": \"${instance_type}\",/g" awsspotinstancecreation.json # to add the instance type in the json file after the user inputs the value


# while [ k=1 ]
# do
# 	a=$(aws ec2 describe-images --filters 'Name=image-id,Values=$ami_id' | grep -w "State" | awk '/State/{ad_id=$2 ; print ad_id ; }'| sed 's/\"//g' | sed 's/\,//g')
#    if [ $a==available ]												  
#    then
#     k = 0
#    fi
# done
# aws ec2 describe-images --filters 'Name=image-id,Values=$ami_id' #'Name=state,Values=available'

sleep 1m 30s 

spotins_id=$(aws ec2 request-spot-instances --spot-price "$price_final" --instance-count 1 --type "one-time" --launch-specification file://awsspotinstancecreation.json | grep -w SpotInstanceRequestId | awk '/SpotInstanceRequestId/{spot_id=$2 ; print spot_id ; }' | sed 's/\,//g'| sed 's/\"//g') #here we need to change the instance type as well as the ami_id in the json file
echo "$spotins_id"

sleep 5m

new_inst_id=$(aws ec2 describe-spot-instance-requests --filters "Name=spot-instance-request-id,Values=$spotins_id" | grep -w InstanceId |awk '/InstanceId/{ins_id=$2 ; print ins_id ; }' | sed 's/\,//g'| sed 's/\"//g')
echo "$new_inst_id"

inst_ip=$(aws ec2 describe-instances --instance-ids $new_inst_id | awk '/PublicIpAddress/{ip_add=$2 ; print ip_add ; }' | sed 's/\,//g'| sed 's/\"//g')
echo "$inst_ip" 

rm -f awsspotinstancecreation.json # to delete the json file after use  
rm -f output.txt # to delete the output txt file


#sudo ssh -i /home/roxor/access-data-aces.pem ec2-root@ec2-$inst_ip.compute-1.amazonaws.com 


# SOURCE_FILE=doc.sh
USER=centos

#Datanodes HOST Names
HOST1=$inst_ip

ssh -i /home/roxor/access-data-aces.pem $USER@$HOST1 -p 3393




# R_HOME=/$USER
# REMOTE=$R_HOME/filename

# #NODE-1
# SCP="scp -i /home/roxor/Downloads/access $SOURCE_FILE $USER@$HOST1:"
# SSH="ssh -i /home/roxor/Downloads/access $USER@$HOST1"
# SSHOPT="-t"


# COMMAND="$SCP"
# echo $COMMAND
# $COMMAND

# COMMAND="$SSH $SSHOPT ls -l $REMOTE"
# echo "$COMMAND"
# $COMMAND

# COMMAND="$SSH $SSHOPT chmod +x $REMOTE"
# echo "$COMMAND"
# $COMMAND

# COMMAND="$SSH $SSHOPT $REMOTE"
# echo "$COMMAND"
# $COMMAND

# COMMAND="$SSH $SSHOPT rm -f $REMOTE"
# echo "$COMMAND"
# $COMMAND


