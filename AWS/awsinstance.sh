#! bin/bash

echo "Please give any region below:" 
read a;
aws configure set region $a
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,PublicIpAddress]'  --filters Name=instance-state-name,Values=running --output text
