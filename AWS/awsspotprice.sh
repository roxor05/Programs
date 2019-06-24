#! bin/bash
#Use shell script with awscli command to see the spot price history for any instance type and region given as input
echo "Please give any region below:" 
read a;
echo "Please provide the instance type"
read b;

aws ec2 describe-spot-price-history --instance-types $b --region $a --start-time 2019-06-05T15:00:00 --end-time 2019-06-05T16:00:00 | grep -w 'SpotPrice\|Timestamp'

