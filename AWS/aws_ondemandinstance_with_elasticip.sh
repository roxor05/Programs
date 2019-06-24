#!/bin/bash
# using shell script with aws-cli command, create t2.nano on-demand instance with elastic ip attached and login to it after creation.

# ami-074acc26872f26463 --- imageid
# t2.nano --- instance-type
# access-data-aces ---keypair
# sg-01bc56ba9bb1b747a --- test security group
# subnet-0542a543654782ddd --- subnet id
# echo "enter the imageid"
# read image_id;
# echo "enter the instance type"
# read instance_type;
# echo "enter the key name"
# read key_pair;
# echo "enter security-group-ids"
# read security_id;
# echo "enter the subnet id"
# read subnet_id;

# to create a on-demand instance
instance_id=$(aws ec2 run-instances --image-id ami-074acc26872f26463 --count 1 --instance-type t2.nano --key-name access-data-aces --security-group-ids sg-01bc56ba9bb1b747a --subnet-id subnet-0542a543654782ddd | awk '/InstanceId/{instance_id=$2 ; print instance_id ; }' | sed 's/\"//g' | sed 's/,//g')
echo "$instance_id"

# to describe the instance created so that we can use it to get the vpc id which is used to allocate the address
vpc_id=$(aws ec2 describe-instances --filters "Name=instance-id,Values=$instance_id" | head -n50 | awk '/VpcId/{vpc_id=$2 ; print vpc_id ; } ' | sed 's/\"//g' | sed 's/,//g')
echo "$vpc_id"

# to create a elastic ip with the specified vpc id and this will be stored in elastic ips where it wont be assocated with any instance
alloc_id=$(aws ec2 allocate-address --domain $vpc_id  | awk '/AllocationId/{allocate_id=$2 ; print allocate_id ; }' | sed 's/\"//g' | sed 's/\,//g' )
echo "$alloc_id"

# to connect the instance to the elastic ip created 
associat_id=$(aws ec2 associate-address --instance-id  --allocation-id $alloc_id | awk '/AssociationId/{association_id=$2 ; print association_id ; }' | sed 's/\"//g' ) 
echo "$associat_id"

#to get the instance ip address
inst_ip=$(aws ec2 describe-instances --filters "Name=instance-id,Values=$instance_id" | head -n50 | awk '/PublicIp/{ip_id=$2 ; print ip_id ; } ' | sed 's/\"//g' | sed 's/,//g')
echo "$inst_ip"


# to decouple the elastic ip from the instance then only we can release(delete) the elastic ip
aws ec2 disassociate-address --association-id $associat_id

# to delete the elastic ip since we can have only 5 per region
aws ec2 release-address --allocation-id $alloc_id

# to connect to the instance 
USER=centos # user of the instance
# scp -i /home/roxor/access /home/roxor/doc.sh centos@34.217.130.132:/home/centos
HOST=$inst_ip #host ip address
KEY=/home/roxor/access-data-aces.pem #access key for the instance
SSH="ssh -i $KEY -o StrictHostKeyChecking=no $USER@$HOST" #connecting to the instance ssh -i /home/roxor/access-data-aces.pem centos@3.80.6.179
#SSHOPT="-t" # this will include the commands in the instance. see command2 in the comments to understand the use
#FILE=running.txt
#R_HOME=/home/$USER

COMMAND="$SSH" 
echo "$COMMAND"
$COMMAND