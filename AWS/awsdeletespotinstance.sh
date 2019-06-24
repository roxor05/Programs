#! bin/bash
# using shell script with aws-cli command to delete the spot instance you created with image name as input and then ip as input.
echo "Please provide the image-id"
read image_id; #ami-074acc26872f26463
# to find the instance id 
spot_req_id=$(aws ec2 describe-spot-instance-requests --filters "Name=launch.image-id,Values=$image_id" | awk '/SpotInstanceRequestId/{ins_id=$2 ; print ins_id ; }' | sed 's/\,//g'| sed 's/\"//g')
echo "$spot_req_id"
#first we need to cancel the spot request then only it can be deleted
aws ec2 cancel-spot-instance-requests --spot-instance-request-ids $spot_req_id 

echo "Please provide the IP address of the instance below"
read ip_address; #34.237.51.204
#code to get the instance id alone 
instance_id=$(aws ec2 describe-instances  --filters "Name=ip-address,Values=$ip_address" | grep -w "InstanceId\|PublicIpAddress" | awk '/InstanceId/{instance_id=$2 ; print instance_id ; }' | sed 's/\"//g' | sed 's/\,//g')
echo $instance_id # you need to echo it then only the sed command works 

# # to get the spot instance id
# new_inst_id=$(aws ec2 describe-spot-instance-requests --filters "Name=spot-instance-request-id,Values=$spotins_id" | grep -w InstanceId |awk '/InstanceId/{ins_id=$2 ; print ins_id ; }' | sed 's/\,//g'| sed 's/\"//g')
# echo "$new_inst_id"

# to stop or delete instance
# aws ec2 cancel-spot-instance-requests --spot-instance-request-ids sir-08b93456 #first we need to cancel the spot request then only it can be deleted
#aws ec2 stop-instances --instance-ids $instance_id
aws ec2 terminate-instances --instance-ids $instance_id
