#!/bin/bash
# using shell script with aws-cli command, integrate spot instance price-history check, creation and  deletion with user given input as instance type(for pricehistory check), image name(creation) and ip(deletion) as a single shell script
echo "You can create or delete an instance by chosing the options"
PS3='Please enter your choice: '
options=("Creation" "Deletion" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Creation")
            echo "you chose to create a spot instance"
            #use shell script with awscli command to see the spot price history and launch ec2 spot instance(t2.small) with appropriate cost and instance type given as input
            echo "Hello"
            echo "lets create an instance"  
            echo "please enter the type of instance you need"
            read instance_type; #t2.small
            echo $instance_type
            echo "please enter the image you want to put for the instance"
            read ami_id; #ami-074acc26872f26463
            echo $ami_id

            echo '{
                  "ImageId": "",
                  "KeyName": "access-data-aces",
                  "SecurityGroupIds": ["sg-01bc56ba9bb1b747a"],
                  "InstanceType": "",
                  "SubnetId": "subnet-0542a543654782ddd",
                  "Placement": {
                    "AvailabilityZone": "us-east-1f"
                  }
            }' >> awsspotinstancecreation.json

            sed -i "s/\"InstanceType\":.*,$/\"InstanceType\": \"${instance_type}\",/g" awsspotinstancecreation.json
            sed -i "s/\"ImageId\":.*,$/\"ImageId\": \"${ami_id}\",/g" awsspotinstancecreation.json

            #sed 's/"InstanceType": "",/"InstanceType": "${instance_type}"/g' awsspotinstancecreation.json

            # aws ec2 describe-spot-price-history --instance-types $b --start-time $(date +%s) | grep -w 'SpotPrice'

            output=$(aws --region=us-east-1 ec2 describe-spot-price-history --instance-types $instance_type --start-time $(date +%s) | grep -w 'SpotPrice' | awk '/SpotPrice/{spotprice=$2 ; print spotprice ; }' | sed 's/\"//g')

            echo "$output" >> output.txt

            price=$(cut -f1 -d"," output.txt | sort -n | tail -1) 

            echo "$price"

            price_final=$(echo "scale=5; $price + (30/100)*$price" | bc)

            echo "$price_final"  

            spotins_id=$(aws ec2 request-spot-instances --spot-price "$price_final" --instance-count 1 --type "one-time" --launch-specification file://awsspotinstancecreation.json | grep -w SpotInstanceRequestId | awk '/SpotInstanceRequestId/{spot_id=$2 ; print spot_id ; }' | sed 's/\,//g'| sed 's/\"//g') #here we need to change the instance type as well as the ami_id in the json file
            echo "$spotins_id"

            rm -f awsspotinstancecreation.json # to delete the json file after use  
            rm -f output.txt # to delete the output txt file
            ;;
        "Deletion")
            echo "you chose choice 2"
            PS4='Please enter your choice: '
            option=("spot_instance_deletion" "normal_instance_deletion" "Quits")
            select opts in "${option[@]}"
            do
                case $opts in
                    "spot_instance_deletion")
                        echo "please provide spot instance reqest id"
                            read spot_req_id;
                            #first we need to cancel the spot request then only it can be deleted
                            aws ec2 cancel-spot-instance-requests --spot-instance-request-ids $spot_req_id
                            echo "the instance will be cancelled but you need to delete manually using ip address"
                        ;;
                    "normal_instance_deletion")
                            echo "to delete an instance"
                            echo "Please provide the IP address of the instance below"
                            read ip_address; #34.237.51.204
                            #code to get the instance id alone 
                            instance_id=$(aws ec2 describe-instances  --filters "Name=ip-address,Values=$ip_address" | grep -w "InstanceId\|PublicIpAddress" | awk '/InstanceId/{instance_id=$2 ; print instance_id ; }' | sed 's/\"//g' | sed 's/\,//g')
                            echo $instance_id # you need to echo it then only the sed command works
                            # to delete instance
                            aws ec2 terminate-instances --instance-ids $instance_id
                        ;;
                    "Quits")
                        break
                        ;;
                    *) echo "invalid option $REPLY";;
                esac    
            done
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done