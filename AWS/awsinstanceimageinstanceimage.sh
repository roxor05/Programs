#! bin/bash
# using awscli create a spot instance(check with spotprice history) with user given image name as input and then login to it, create a file, do scp(to local) and then again take image of that instance with name as user given
echo "Please enter the image id below"
read old_image_id;
# ami-074acc26872f26463
# echo "lets get the highest price of the spot instance"  
# echo "please enter the type of instance you need"
# read instance_type; # to know what the user needs like t2.small ,nano, medium ,etc

output=$(aws --region=us-east-1 ec2 describe-spot-price-history --instance-types t2.small --start-time $(date +%s) | grep -w 'SpotPrice' | awk '/SpotPrice/{spotprice=$2 ; print spotprice ; }' | sed 's/\"//g')

echo "$output" >> output.txt # all the prices at the time period is stored here

price=$(cut -f1 -d"," output.txt | sort -n | tail -1) # the file is sorted in arranging order and the last number which is the biggest no is called 

echo "$price" # the biggest number

price_final=$(echo "scale=5; $price + (30/100)*$price" | bc) #the price is now changed to 30% higher so that the instances will be there

echo "$price_final"  #the final price after +30% of the highest price

echo '{
	  "ImageId": "",
	  "KeyName": "access-data-aces",
	  "SecurityGroupIds": ["sg-01bc56ba9bb1b747a"],
	  "InstanceType": "t2.small",
	  "SubnetId": "subnet-0542a543654782ddd",
	  "Placement": {
	    "AvailabilityZone": "us-east-1f"
	  }
}' >> awsspotinstancecreation.json #this json file is the launch-specification file for creating spot instance .... its a must

sed -i "s/\"ImageId\":.*,$/\"ImageId\": \"${old_image_id}\",/g" awsspotinstancecreation.json # to add the instance type in the json file after the user inputs the value

# sed -i "s/\"InstanceType\":.*,$/\"InstanceType\": \"${instance_type}\",/g" awsspotinstancecreation.json # to add the instance type in the json file after the user inputs the value

# while [ k=1 ]
# do
# 	a=$(aws ec2 describe-images --filters 'Name=image-id,Values=$ami_id' | grep -w "State" | awk '/State/{ad_id=$2 ; print ad_id ; }'| sed 's/\"//g' | sed 's/\,//g')
#    if [ $a==available ]												  
#    then
#     k = 0
#    fi
# done
# aws ec2 describe-images --filters 'Name=image-id,Values=$ami_id' #'Name=state,Values=available'

# sleep 1m 30s 

#to launch the spot instance 
spotins_id=$(aws ec2 request-spot-instances --spot-price "$price_final" --instance-count 1 --type "one-time" --launch-specification file://awsspotinstancecreation.json | grep -w SpotInstanceRequestId | awk '/SpotInstanceRequestId/{spot_id=$2 ; print spot_id ; }' | sed 's/\,//g'| sed 's/\"//g') #here we need to change the instance type as well as the ami_id in the json file
echo "$spotins_id" # to get the spot instance request id 

sleep 5m

new_inst_id=$(aws ec2 describe-spot-instance-requests --filters "Name=spot-instance-request-id,Values=$spotins_id" | grep -w InstanceId |awk '/InstanceId/{ins_id=$2 ; print ins_id ; }' | sed 's/\,//g'| sed 's/\"//g')
echo "$new_inst_id"

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
FILE=running.txt
R_HOME=/home/$USER
#SCP="scp -i $KEY $FILE $USER@$HOST:$R_HOME" # for testing
#sudo ssh -i /home/roxor/access-data-aces.pem ec2-root@ec2-$inst_ip.compute-1.amazonaws.com
SCP="scp -rp -i $KEY -o StrictHostKeyChecking=no $USER@$HOST:/home/centos/$FILE /home/roxor/"
#LOCAL="/home/roxor/" #copying file to local

COMMAND="$SSH $SSHOPT echo \"hello this is the message\" > $FILE" 
echo "$COMMAND"
$COMMAND

COMMAND="$SCP"
echo $COMMAND
$COMMAND

# COMMAND2="$SSH $SSHOPT chmod 755 $FILE"
# echo "$COMMAND2"
# $COMMAND2

#ssh -t $USER@$HOST_IP echo \"hello this is the message\" > $FILE 
#ssh -t linuxtechi@192.168.10.10 sudo touch /etc/banner.txt

# to create an image for the new instance created
echo "enter a name for the image you want to create"
read img_name;
aws ec2 create-image --instance-id $new_inst_id --name "$img_name" --description "test for sh to work" #| awk '/ImageId/{image_id=$2 ; print image_id ; }' | sed 's/\"//g' | sed 's/\://g'
