#! bin/bash
#use shell script to get the details of the instance(instanceid,privateip,key) with public ip given as input.
echo "Please give the ip address:" 
read a;

aws ec2 describe-instances  --filters "Name=ip-address,Values=$address" | grep -w "InstanceId\|PublicIpAddress\|KeyName" 

