import boto3
from datetime import date
import subprocess
import re
import os
# to get the data uploading in s3 on the current date
aws_bucket_dir_cmd = f"aws s3api list-object-versions --bucket dw-etl-source-prod --output text"
find_no_of_dir_in_the_bucket = f"{aws_bucket_dir_cmd}"
#print(f"Required command -> {find_no_of_files_matched}")
result = subprocess.run(find_no_of_dir_in_the_bucket, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True,check=True)    
#print(result.stdout)
i=str(result.stdout).strip()
#print(i)
#j=i.split("\n")
# for k in range(1,len(j),2):
    #print(j[k].split(" ")[3]+' '+j[k].split("  ")[4])
print('---------Going to delete the data in the text file:output.txt-----------------')
open("output.txt", "w").close() # to delete the contents in a file
print('----------------------------Deleted data in text file-------------------------')
j=(i.split("\n")) # split it into list from normal text for every line 
for k in j:
    if '2020-01-23' in k: #to find the data list from actual date and also append it to output.txt 
        print((k.split("\t")[3] + "|||" + k.split("\t")[4]), file=open("output.txt", "a"))
print("---------------Data appended to output.txt file-------------------------------")
print("------------------------------------------------------------------------------")
with open('output.txt', 'rt') as f:
    data = f.readlines() # reads line by line of the file
for line in data: # for every line 
    if line.__contains__('/'): #to not print the values having /
        print(line.strip())
print("------------------------------------------------------------------------------")
print('-------These are the data from the source s3 bucket on the given date --------')

############################################################################################################
