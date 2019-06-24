#! bin/bash 
# using shell script with aws-cli command to delete the image you have created with image name as input and then image id as input

# delete ami via ami id input
echo "enter the image-id"
read image_id;
aws ec2 deregister-image --image-id $image_id

# delete ami via name input
echo "enter the image name"
read image_name;
ami_id=$(aws ec2 describe-images --filters "Name=name,Values=$image_name" | awk '/ImageId/{image_id=$2 ; print image_id ; }' | sed 's/\"//g' | sed 's/\://g' | sed 's/\,//g')
echo "$ami_id"
aws ec2 deregister-image --image-id $ami_id