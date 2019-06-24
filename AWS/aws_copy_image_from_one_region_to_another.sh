#! /bin/bash
# Using shell script with aws-cli command, copy the image of the instance to another region with region name and image name given as input.

# First we get the name and the region of the image which needs to be copied 
echo "Please provide the image name you need to copy below:"
read source_imagename;
echo "Please provide the source region below:"
read source_region;

# Then we set the region as per the users asks  
aws configure set region $source_region

# we get the ami id so that it can be used in the copy-image command
ami_id=$(aws ec2 describe-images --filters 'Name=name,Values=surendhar' | awk '/ImageId/{ami=$2 ; print ami ; }' | sed 's/\,//g' | sed 's/\"//g')
echo "$ami_id"

# we get the destination region and the name for the image which will be copied 
echo "Please provide the destination region below:"
read destination_region;
echo "Please enter the name for the copied image below:"
read new_ami_name;

# this is the main command to copy image from one location to another
aws ec2 copy-image --source-image-id $ami_id --source-region $source_region --region $destination_region --name "$new_ami_name"

#aws ec2 copy-image --source-image-id ami-048c1ba4d28021d77 --source-region us-east-1 --region us-west-1 --name "copied image of surendhar"
#Copy-EC2Image -SourceRegion  -SourceImageId ami_id -Region us-west-2 -Name "Copy of $source_imagename"
