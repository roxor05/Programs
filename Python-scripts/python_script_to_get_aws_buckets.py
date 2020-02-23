# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import boto3
import subprocess

#Create an S3 client
s3 = boto3.client('s3')

# Call S3 to list current buckets
response = s3.list_buckets()

# Get a list of all bucket names from the response
buckets = [bucket['Name'] for bucket in response['Buckets']]

# Print out the bucket list of names an store it in output.txt
#print("Bucket List:\n %s\n" % buckets)
with open("output.txt", "w") as out_file:
        for i in buckets:
                out_string = ""
                out_string += str(i)
                out_string += "\n"
                out_file.write(out_string)
                print(i)
# f = open("output.txt", "r")
# print(f.read())
#### to print all the bucket names
# fh = open('output.txt')
# for line in fh:
#     print(line)
with open("output.txt") as openfile:
    for line in openfile:
        for bucket_name in line.split():
            if "dw-etl-source-prod" in bucket_name:
                #print(bucket_name) to print the value
                bucketname=str(bucket_name) #to store the value
print('-----------------------------------')
print('-----------------------------------')
print(bucketname)
print('-----------------------------------')
print('-----------------------------------')


									#or

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