#! bin/bash
#use shell script with awscli command to see the spot price history and launch ec2 spot instance(t2.small) with appropriate cost and instance type given as input
echo "Hello"
echo "lets create an instance"  
echo "please enter the type of instance you need"
read instance_type;
echo $instance_type

echo '{
	  "ImageId": "ami-074acc26872f26463",
	  "KeyName": "access-data-aces",
	  "SecurityGroupIds": ["sg-01bc56ba9bb1b747a"],
	  "InstanceType": "",
	  "SubnetId": "subnet-0542a543654782ddd",
	  "Placement": {
	    "AvailabilityZone": "us-east-1f"
	  }
}' >> awsspotinstancecreation.json

sed -i "s/\"InstanceType\":.*,$/\"InstanceType\": \"${instance_type}\",/g" awsspotinstancecreation.json
#sed 's/"InstanceType": "",/"InstanceType": "${instance_type}"/g' awsspotinstancecreation.json

# aws ec2 describe-spot-price-history --instance-types $b --start-time $(date +%s) | grep -w 'SpotPrice'

output=$(aws --region=us-east-1 ec2 describe-spot-price-history --instance-types $instance_type --start-time $(date +%s) | grep -w 'SpotPrice' | awk '/SpotPrice/{spotprice=$2 ; print spotprice ; }' | sed 's/\"//g')

echo "$output" >> output.txt

price=$(cut -f1 -d"," output.txt | sort -n | tail -1) 

echo "$price"

price_final=$(echo "scale=5; $price + (30/100)*$price" | bc)

echo "$price_final"  

aws ec2 request-spot-instances --spot-price "$price_final" --instance-count 1 --type "one-time" --launch-specification file://awsspotinstancecreation.json #here we need to change the instance type in the json file

rm -f awsspotinstancecreation.json # to delete the json file after use  
rm -f output.txt # to delete the output txt file




