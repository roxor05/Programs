import boto3
from datetime import date
from datetime import date, timedelta
import subprocess
import os
import paramiko

open("output1.txt", "w").close()
# to get the data uploading in s3 on the current date

aws_bucket_dir_cmd = f"aws s3api list-object-versions --bucket dw-etl-source-prod --output text"
find_no_of_dir_in_the_bucket = f"{aws_bucket_dir_cmd}"
#print(f"Required command -> {find_no_of_files_matched}")
result = subprocess.run(find_no_of_dir_in_the_bucket, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True,check=True)    
#print(result.stdout)
i=str(result.stdout).strip()
j=(i.split("\n"))
for k in j:
    if "2020-01-31" in k: #to find the data list from actual date and also append it to output.txt 
        print((k.split("\t")[3] + "|||" + k.split("\t")[4]), file=open("output1.txt", "a"))
 