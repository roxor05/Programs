# -*- coding: utf-8 -*-
from __future__ import unicode_literals
#############################################################################################################
                # to find the actual data given by client to s3 bucket on a specific date
#############################################################################################################
import boto3
from datetime import date, timedelta
import subprocess
import os
import paramiko
import snowflake.connector 
from datetime import datetime

# to get the data uploading in s3 on the current date
aws_bucket_dir_cmd = f"aws s3api list-object-versions --bucket dw-etl-source-prod --output text"
find_no_of_dir_in_the_bucket = f"{aws_bucket_dir_cmd}"
#print(f"Required command -> {find_no_of_files_matched}")
result = subprocess.run(find_no_of_dir_in_the_bucket, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True,check=True)    
#print(result.stdout)
i=str(result.stdout).strip()

j=(i.split("\n")) # split it into list from normal text for every line 

###################################### dates ########################################
date_today = date.today()
date_yesterday = date_today - timedelta(days = 1)

Current_date=date_today.strftime('%Y-%m-%d')
yesterday_date=date_yesterday.strftime('%Y-%m-%d')
print(Current_date + " --- Today's date")
print('----------------------------')
print(yesterday_date + " --- Yesterday's date")
print('----------------------------')

##############################################################################################

############################## Manual dates ###########################################################
#we can check manually in dates using this and commenting the dates

# Current_date='2020-02-18'  # format = year:month:date
# yesterday_date='2020-02-17' # format = year:month:date

# print(Current_date + " --- Today's date")
# print(yesterday_date + " --- Yesterday's date")
##############################################################################################


open("output.txt", "w").close() # to delete the contents in a file

for k in j:
    if yesterday_date in k: #to find the data list from actual date and also append it to output.txt 
        print((k.split("\t")[3] + "|||" + k.split("\t")[4]), file=open("output.txt", "a"))


print("---------------Data's in S3 of {} also appended to output.txt file-------------------------------".format(yesterday_date))
print("------------------------------------------------------------------------------")


with open('output.txt', 'rt') as f:
    data = f.readlines() # reads line by line of the file
for line in data: # for every line 
    if line.__contains__('/'): #to not print the values having /
        print(line.strip())
#open("output.txt", "w").close() # to delete the yesterday data in output file
for k in j:
    if Current_date in k: #to find the data list from actual date and also append it to output.txt 
        print((k.split("\t")[3] + "|||" + k.split("\t")[4]), file=open("output.txt", "a"))


print("------------------------------------------------------------------------------")
print("---------------Data's in S3 of {} also appended to output.txt file-------------------------------".format(Current_date))
print("------------------------------------------------------------------------------")


with open('output.txt', 'rt') as f:
    data = f.readlines() # reads line by line of the file
for line in data: # for every line 
    if line.__contains__('/'): #to not print the values having /
        if line.__contains__(yesterday_date):
            # print(line.strip())
            pass
        else:
            print(line.strip())   


print("------------------------------------------------------------------------------")
print('-------These are the data from the source s3 bucket on the given date --------')
print("------------------------------------------------------------------------------")



###########################################################################################################
 #to find the tables inside the snowflake table
###########################################################################################################

open("Source_duplicate.txt", "w").close()

with open('output.txt', 'rt') as f:
    data = f.readlines() # reads line by line of the file
print('---------Going to delete the data in the text file:Source_duplicate.txt-----------------')
open("Source_duplicate.txt", "w").close() # to delete the contents in a file
print('----------------------------Deleted data in text file-------------------------')
print('---------Going to delete the data in the text file:Source_Names.txt-----------------')
open("Source_Names.txt", "w").close() # to delete the contents in a file
print('----------------------------Deleted data in text file-------------------------')
lines_seen = set()
for line in data: # for every line 
    if line.__contains__('/'): #to not print the values having /
        #print(line.strip())

        a=line.strip()
        #print(re.sub("/.*$", "", a)) # this works to print only the dir name
        #print(a[:a.find("/")]) # this works to print only the dir name
        b=(a[:a.find("/")])
        # print(b)
        print(b, file=open("Source_duplicate.txt", "a"))

lines_seen = set() # holds lines already seen
outfile = open("Source_Names.txt", "w")
for line in open("Source_duplicate.txt", "r"):
    if line not in lines_seen: # not a duplicate
        outfile.write(line)
        lines_seen.add(line)
outfile.close()


##################################################################################################################################
                        # to scp Source_Names.txt which has the source dir names
##################################################################################################################################

############################### Key location ##################################################################
# please change the name of the user or change the location

#key_location='C:\\Users\\admin\\Downloads\\avanir-access-key.pem'
key_location='C:\\Users\\USER\\Downloads\\avanir-access-key.pem'

#################################################################################################################################
try:

    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    client.connect('52.39.37.163', username='ubuntu', key_filename='{}'.format(key_location),banner_timeout=200)
    # Setup sftp connection and transmit this script
    print ("copying")
    print("-----------------------------------------------------------------------------------")
    sftp = client.open_sftp()
    sftp.put('Source_Names.txt', '/home/ubuntu/Source_Names.txt')
    sftp.put('python_script_for_data_validation_remote_file.py', '/home/ubuntu/python_script_for_data_validation_remote_file.py')
    sftp.close()
    client.close()
except Exception as e:
    print('Error while connecting to node4 while running the python script')
    print(e)
#################################################################################################################################
                        # to print cassandra output
#################################################################################################################################
try:

    ssh = paramiko.SSHClient()

    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    ssh.connect('52.39.37.163', username='ubuntu', password='', key_filename='{}'.format(key_location),banner_timeout=200)

    stdin, stdout, stderr = ssh.exec_command('python3 python_script_for_data_validation_remote_file.py')
    x=stdout.readlines()
    for i in x:
        print(i.strip())

    stdin, stdout, stderr = ssh.exec_command('rm python_script_for_data_validation_remote_file.py Source_Names.txt')

    print('The Snowflake Validation procedure starts now')
    ssh.close()
except Exception as e:
    print('Error while connecting to node4 while getting the data from the python script')
    print(e)
##################################################################################################################################
            # to validate in snowflake we first take the snowflake tables we need to check
##################################################################################################################################

open("Snowflake_Tables_to_validate.txt", "w").close()
# copying from instance to local which contains the snowflake tables arrived today
try:

    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    client.connect('52.39.37.163', username='ubuntu', key_filename='{}'.format(key_location),banner_timeout=200)
    # Setup sftp connection and transmit this script
    print("-----------------------------------------------------------------------------------")
    print ("copying")
    print("-----------------------------------------------------------------------------------")
    sftp = client.open_sftp()
    sftp.get('/home/ubuntu/output.txt','Snowflake_Tables_to_validate_with_duplicates.txt' )
    print("-----------------------------------------------------------------------------------")
    print('copied the Snowflake_Tables_to_validate.txt')
    print("-----------------------------------------------------------------------------------")
    sftp.close()
    client.close()
except Exception as e:
    print('Error while copying the snowflake table file name from node4')
    print(e)
######################################################################################################################
# Removing duplicate table names
######################################################################################################################
lines_seen = set() # holds lines already seen
outfile = open('Snowflake_Tables_to_validate.txt', "w")
for line in open('Snowflake_Tables_to_validate_with_duplicates.txt', "r"):
    if line not in lines_seen: # not a duplicate
        outfile.write(line)
        lines_seen.add(line)
outfile.close()

######################################################################################################################
# to connect to snowflake and print the output
######################################################################################################################
try:
    Username = ''
    Password = ''
    account = ''
    conn = snowflake.connector.connect(
                user= Username,
                password= Password,
                account= account,
                warehouse='COMPUTE_WH_XS',
                database='AVNR_STAGE',
                schema='L1'
                    )

    # Create cursor
    cur = conn.cursor()
    # Execute SQL statement
    #open("snowflake_count.txt", "w").close()
    with open('Snowflake_Tables_to_validate.txt','r') as f:
            for line in f:
    # we use veeva crm then this line is excuted as it doesnt have Extract date column in it 
                if 'VEEVA_CRM' in line:
                    try:
                            cur.execute("select max(last_modified_time) from {};".format(line))
                            for (last_modified_time,) in cur:
                               print('{}------'.format(line.strip()) + 'last_modified_time: {0}'.format(datetime.date(last_modified_time))) 
                # else:
                #   pass
                    except Exception as e:
                        print(e)
    # this prints all the others in the data
                else:
                    try:
                        cur.execute("select MAX(EXTRACT_DT),count(*) from {} where EXTRACT_DT='{}';".format(line,Current_date))
                        #cur.execute("select MAX(EXTRACT_DT) from {};".format(line))
                        for (EXTRACT_DT,count) in cur:
                            if count == 0:
                               pass
                            else:
                          #for EXTRACT_DT in cur:
                               print('{}------'.format(line.strip()) + 'EXTRACT_DT:{0}------Count:{1}'.format(EXTRACT_DT, count))
                               #print('{}------'.format(line.strip()) + 'EXTRACT_DT:{0}'.format(EXTRACT_DT),file=open("snowflake_count.txt", "a"))

                    except Exception as e:
                        print(e)
    cur.close()
    conn.close()
except Exception as e:
    print('Error while connecting to snowflake')
    print(e)
#############################################################################################################################################
# to delete the file containing the snowflake table name in the instance
#############################################################################################################################################
try:

    ssh = paramiko.SSHClient()

    ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    ssh.connect('52.39.37.163', username='ubuntu', password='', key_filename='{}'.format(key_location),banner_timeout=200)

    stdin, stdout, stderr = ssh.exec_command('rm output.txt')

    print('-----------------------------------------------------------------------------------------------------------')
    print('All successfully done')
    print('-----------------------------------------------------------------------------------------------------------')

    ssh.close()
except Exception as e:
    print('Error while deleting the Snowflake_Tables file in node4')
    print(e)
###############################################################################################################################################