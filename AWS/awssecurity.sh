#! bin/bash
#use aws cli command to create security group and then change rules based on user input.
output=$(aws ec2 create-security-group --group-name testgroupbyroxor --description "My security group to change via users by shrikkanth" --vpc-id vpc-70e2060a  | awk '/GroupId/{group_id=$2 ; print group_id ; }' | sed 's/\"//g')

echo "please specific the protocol: tcp or udp "
read a; 
echo "please specific the port number: 1 to 9999"
read b;

aws ec2 authorize-security-group-ingress --group-id $output --protocol $a --port $b --cidr 203.0.113.0/24
aws ec2 authorize-security-group-egress --group-id $output --protocol $a --port $b --cidr 203.0.113.0/24

aws ec2 describe-security-groups --group-id $output


# authorize-security-group-ingress
# [--group-id <value>]
# [--group-name <value>]
# [--ip-permissions <value>]
# [--dry-run | --no-dry-run]
# [--protocol <value>]
# [--port <value>]
# [--cidr <value>]
# [--source-group <value>]
# [--group-owner <value>]
# [--cli-input-json <value>]
# [--generate-cli-skeleton <value>]

#   authorize-security-group-egress
# [--dry-run | --no-dry-run]
# --group-id <value>
# [--ip-permissions <value>]
# [--protocol <value>]
# [--port <value>]
# [--cidr <value>]
# [--source-group <value>]
# [--group-owner <value>]
# [--cli-input-json <value>]
# [--generate-cli-skeleton <value>]

# --vpc-id vpc-70e2060a
