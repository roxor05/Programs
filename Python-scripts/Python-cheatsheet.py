# #!/usr/bin/env python3.4
# import boto3
# import sys
# from datetime import datetime
# now = datetime.now()
# today_date = (str(now.month) + "-" + str(now.day) + "-" + str(now.year) + " " + str(now.hour) + str(now.minute) + str(now.second))
# ami_name = ("Mahesh_RND_" + today_date)
# def create_image(id):
#     client = boto3.client('ec2', region_name='us-east-2')
#     response = client.create_image(
#         Description=ami_name,
#         InstanceId=id,
#         Name=ami_name,
#         NoReboot=True
#     )
#     return  (response['ImageId'])


# def terminate_instance(id):
#     client = boto3.client('ec2', region_name='us-east-2')
#     response = client.terminate_instances(
#         InstanceIds=[
#             (id)
#         ])

# if len(sys.argv) < 2:
#     print ("usage: python3 create_image.py image_id")
# else:
#     ec2 = boto3.resource('ec2', region_name='us-east-2')
#     ami_id = create_image(sys.argv[1])
#     print (ami_id)
#     image = ec2.Image(ami_id)
#     print ("waiting for image state to be available")
#     image.wait_until_exists(
#         Filters=[
#             {
#                 'Name': 'state',
#                 'Values': [
#                     'available',
#                 ]
#             }
#         ]
#     )
#     print (sys.argv[1] + "Image has been created")
#     print ("terminating instance")
#     terminate_instance(sys.argv[1]) 


########################################################################################################################################################################
										# General type
########################################################################################################################################################################
                                            
#################################################### to Find and replace a word in a file

Read in the file

with open('NAME.txt', 'r') as file :
  filedata = file.read()

# Replace the target string
hi='860836'
hi2='sfhguiosfdhiosfhiosf'
filedata = filedata.replace(hi,hi2)

# Write the file out again
with open('NAME.txt', 'w') as file:
  file.write(filedata)
################################################ to get the system date
import sys
from datetime import datetime
now = datetime.now()
today_date = (str(now.day) + "-" + str(now.month) + "-" + str(now.year))
print (today_date)

############################################## print formating
x = 5; y = 10
print('The value of x is {} and y is {}'.format(x,y))
################################## user defined function
def akhil():
 print(1,2,3,4)
################################ to enter a number
num = input('Enter a number: ')
print(num)
########################### appending text
import datetime

current_date = datetime.date.today()
print(current_date)

hi=['aws']
print(hi[0]+'.amazon.com')
################################################## 
x=2
x=x+2
x=float(2)
print(type(x))
###############################################  inputing
name=input('who the fuck are you?')
print ('oh',name,'aa')
############################################ data type changing
hours=input('Enter the no of hours: ')
fare=input('Enter the fare per hour: ')
amount=int(hours)*int(fare)
print("Amount:",amount)
################################# loop
for i in range(5) :
	print(i)
	if i == 2:
		print('i is equal to 2')
	print('Done with i =',i)
print('all Done') , backup='.bak'
################################ word replace
import fileinput

with fileinput.input("hello.txt", inplace=True) as file:
    for line in file:
        print(line.replace("site", "yoyo_honey_singh"), end='')
#################################################################### word replace
import fileinput
for line in fileinput.input("hello.txt", inplace=True):
    # inside this loop the STDOUT will be redirected to the file
    # the comma after each print statement is needed to avoid double line breaks
    print (line.replace("shrikkanth", "roxor"), end='')
###################################################################### word replace using sed in linux
import subprocess
subprocess.call(["sed", "-i", "-e",  's/hello/helloworld/g', "hello.txt"])
subprocess.call(["sed -i -e 's/hello/helloworld/g' www.txt"], shell=True)
subprocess.call(["ls", "-l"])
######################################################################## how to read a file from python
f = open("demofile.txt", "r")
print(f.read())
####################################################### how to read a line of a file
f = open("demofile.txt", "r")
print(f.readline())
############################################ how to append text in a file
f = open("demofile2.txt", "a")
f.write("Now the file has more content!")
f.close()

#open and read the file after the appending:
f = open("demofile2.txt", "r")
print(f.read())
######################################## how to replace the whole file with new content
f = open("demofile3.txt", "w")
f.write("Woops! I have deleted the content!")
f.close()

#open and read the file after the appending:
f = open("demofile3.txt", "r")
print(f.read())
############################################ how to copy one file data content to another
with open("filetoread.txt") as f:
    with open("filetopaste.txt", "w") as f1:
        for line in f:
            f1.write(line)
###############################################  to clear content inside a file
open('file.txt', 'w').close()
################################################ to delete the file 
import os
if os.path.exists("demofile.txt"):
  os.remove("demofile.txt")
else:
  print("The file does not exist")
######################################## to delete the directory
import os
os.rmdir("myfolder")
###################################### to read a file line by line
filepath = 'output.txt'
with open(filepath) as fp:
   line = fp.readline()
   cnt = 1
   while line:
       print("{}".format(cnt, line.strip()))
       line = fp.readline()
       cnt += 1
       #or
fh = open('my_text_file.txt')
for line in fh:
    # in python 2
    # print line
    # in python 3
    print(line)
fh.close()

strip() --- to delete the empty or white spaces in a string
#############################################################################################################################################################################
                      # time and date
#############################################################################################################################################################################
date_today= date.today() # to get todays date
#print(today)
today = f'"{date_today}"'
print(today)
                              # or
import datetime

lastHourDateTime = datetime.datetime.now() - datetime.timedelta(hours = 1)
print lastHourDateTime.strftime('%Y-%m-%d %H')
                              #or
import datetime
import os

lastHourDateTime = datetime.datetime.now() - datetime.timedelta(hours = 24)
Time_from_str_format=lastHourDateTime.strftime('%Y-%m-%d %H:%M:%S') # changing format from datetime to string format
#print(Time_from)
Time_now=datetime.datetime.now()
Time_to_str_format=Time_now.strftime('%Y-%m-%d %H:%M:%S') # changing format from datetime to string format
print(Time_to)
print(type(Time_to))
from datetime import datetime
Time_from=datetime.strptime(Time_from_str_format, '%Y-%m-%d %H:%M:%S')
print(Time_from) # changing format from string to datetime format
Time_to=datetime.strptime(Time_to_str_format, '%Y-%m-%d %H:%M:%S')
print(Time_to) # changing format from string to datetime format
#############################################################################################################################################################################
        # to remove duplicates from a file
#############################################################################################################################################################################
lines_seen = set() # holds lines already seen
outfile = open("hello1.txt", "w")
for line in open("hello.txt", "r"):
    if line not in lines_seen: # not a duplicate
        outfile.write(line)
        lines_seen.add(line)
outfile.close()
#############################################################################################################################################################################
        # to execute line by line in a file
#############################################################################################################################################################################
filepath = 'hello1.txt'
with open(filepath) as fp:
   line = fp.readline()
   cnt = 1
   while line:
       print("Line {}: {}".format(line.strip()))
       line = fp.readline()
       cnt += 1
#############################################################################################################################################################################
        # to execute command on remote system
#############################################################################################################################################################################
import paramiko
ssh = paramiko.SSHClient()

ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

ssh.connect('54.218.201.200', username='ubuntu', password='', key_filename='C:\\Users\\USER\\Downloads\\avanir-access-key.pem')

# stdin, stdout, stderr = ssh.exec_command('cat /home/ubuntu/Data_Validation/21-01-2020/Total_data_sources_at_2020-01-21')
stdin, stdout, stderr = ssh.exec_command()
                              # or (better)

import paramiko

client = paramiko.SSHClient()
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

client.connect('52.39.37.163', username='ubuntu', key_filename='C:\\Users\\USER\\Downloads\\avanir-access-key.pem')

# Setup sftp connection and transmit this script
print "copying"
sftp = client.open_sftp()
sftp.put('C:\\Users\\USER\\Documents\\GitHub\\ROxOR\\Python-scripts\\hello1.txt', '/home/ubuntu/dir')
sftp.close()
#############################################################################################################################################################################
#############################################################################################################################################################################
												# AWS CLI
#############################################################################################################################################################################
####################################### to print the list of buckets
import boto3

# Create an S3 client
s3 = boto3.client('s3')

# Call S3 to list current buckets
response = s3.list_buckets()

# Get a list of all bucket names from the response
buckets = [bucket['Name'] for bucket in response['Buckets']]

# Print out the bucket list
#print("Bucket List:\n %s\n" % buckets)
with open("output.txt", "w") as out_file:
        for i in buckets:
                out_string = ""
                out_string += str(i)
                out_string += "\n"
                out_file.write(out_string)
                #print(i)
####################################### to print s3 bucket object
import boto3

# Create an S3 client
s3 = boto3.client('s3')

response = s3.list_objects_v2(Bucket='dw-etl-source-prod')
print(response)
#################################### to print bucket name from aws cli command
import re
import boto3
import subprocess
aws_ls_cmd = f"aws s3 ls"
find_no_of_files_matched = f"{aws_ls_cmd}"
#print(f"Required command -> {find_no_of_files_matched}")
result = subprocess.run(find_no_of_files_matched, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True,check=True)
print(type(result.stdout))
print("---------------------------------------------")
print(result.stdout) # we print the result but its in run.std_output format so we change the format
print("---------------------------------------------")
i=str(result.stdout).strip() # we strip the empty spaces and empty elements in the string
print(type(i))
print("---------------------------------------------")
print(i)
print("---------------------------------------------")
j=(i.split("\n")) # we split the string using the next line which is \n
print(type(j)) 
print("---------------------------------------------")
print(j)
print("---------------------------------------------")
# k=(len(j))
# print(k)
print("---------------------------------------------")
for k in j: # we split the data to get specific data from the list
	print(k.split(" ")[0]+'||'+k.split(" ")[2])
print("---------------------------------------------")
print(type(k))

