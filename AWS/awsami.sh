#! bin/bash
#Use awscli command to create image for any instance for which ip given as input
echo "Please provide the IP address of the instance below"
read address

#aws ec2 describe-instances  --query 'Reservations[*].Instances[*].[InstanceId,PublicIpAddress]' --filters "Name=ip-address,Values=34.193.71.124" | a= grep -a 
#aws ec2 describe-instances  --filters "Name=ip-address,Values=34.193.71.124" | grep -w "InstanceId"

#aws ec2 describe-instances  --filters "Name=ip-address,Values=$address" | grep -w "InstanceId\|PublicIpAddress" | awk '/InstanceId/{instance_id=$2 ; print instance_id ; }' | sed 's/\"//g' | sed 's/\,//g'


output=$(aws ec2 describe-instances  --filters "Name=ip-address,Values=$address" | grep -w "InstanceId\|PublicIpAddress" | awk '/InstanceId/{instance_id=$2 ; print instance_id ; }' | sed 's/\"//g' | sed 's/\,//g')

aws ec2 create-image --instance-id $output --name "shrikkanth" --description "test for sh to work"



#awk '/InstanceId =/{gsub("\"","",$2);instance_id=$2 ; print gsub("\"","",$2);instance_id ; }'

#awk '/Class Device =/{gsub("\"","",$4);host=$4}/port_state/{gsub("\"","",$3);print host,$3}'

#awk -F, -v DATE="$(date +'%Y%m%d')" 'NR>1{s=$1; gsub(/"/,"",s);  print > "Assignment_"s"_"DATE".csv"}' Text_01012020.CSV


#awk '/Class Device =/{host=substr($4,2,length($4)-2)}/port_state/{print host,substr($3,2,length($3)-2)}'

#awk '/Aaron/{ first_name=$2 ; second_name=$3 ; print first_name, second_name ; }' 
#-F',' '{gsub(/"/, "", $2);

#{gsub("\"","",$4);
#awk -F'"' 


#aws ec2 describe-instances  --filters "Name=ip-address,Values=34.193.71.124" | grep -w "InstanceId\|PublicIpAddress" | awk -F '/InstanceId =/{gsub(/"/,"");instance_id=$2 ; print gsub(/"/,"");instance_id ; }'
