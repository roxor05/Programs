#! bin/absh
# using awscli command to attach new security group to your created spot instance  and remove the old one.

# to get the instance id using the spot instace id
instance_id=$(aws ec2 describe-spot-instance-requests --filters "Name=spot-instance-request-id,Values=sir-zj1g4nkk" | awk '/InstanceId/{ins_id=$2 ; print ins_id ; }' | sed 's/\,//g'| sed 's/\"//g')
echo "$instance_id"

#to change the security group 
aws ec2 modify-instance-attribute --instance-id $instance_id --groups sg-01bc56ba9bb1b747a

