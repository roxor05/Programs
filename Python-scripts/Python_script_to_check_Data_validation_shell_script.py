# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import sys
import datetime
import os
import paramiko
now = datetime.date.today()
today_date = str('{:02d}'.format(now.day)) + "-" + str('{:02d}'.format(now.month)) + "-" + str((now.year))
today_din= str(now.year) + "-" + str('{:02d}'.format(now.month)) + "-" + str('{:02d}'.format(now.day))
today_date='05-02-2020'
today_din='2020-02-05'

print (today_date)
# print(type(today_date))
print('-------------------------------------------------------')

ssh = paramiko.SSHClient()

ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
# key_location='C:\\Users\\admin\\Downloads\\avanir-access-key.pem'
key_location='C:\\Users\\USER\\Downloads\\avanir-access-key.pem'

ssh.connect('54.218.201.200', username='ubuntu', password='', key_filename='{}'.format(key_location))

# stdin, stdout, stderr = ssh.exec_command('cat /home/ubuntu/Data_Validation/21-01-2020/Total_data_sources_at_2020-01-21')
stdin, stdout, stderr = ssh.exec_command('cat /home/ubuntu/Data_Validation/{}/Total_data_sources_at_{}'.format(today_date,today_din))
x=stdout.readlines()

for y in x:
	print(y , end ='')
z=[]
for y in x:
    z.append((y.split(" ")[-1]).split("T")[0]+"|||"+y.split("/")[0])
#print(z)    
print("--------------------------------------------------------------------------")
a=list(sorted(set(z)))
for y in a:
	if y != a[len(a)-1]:
		print(y,end=',')
	else:
		print(y)
print("\n--------------------------------------------------------------------------")
#print("----------------------------------------------------------------------------------")
for y in a:
	print(y)

print("--------------------------------------------------------------------------")

stdin, stdout, stderr = ssh.exec_command('cat /home/ubuntu/Data_Validation/{}/Total_tables_processed_{}'.format(today_date,today_din))
x=stdout.readlines()
print(x)
print("------------------------------------------------------")
m=[]
for y in x:
	for z in y.replace("\n","").split(","):
		m.append(z)
m.remove('')
n=(sorted(set(m)))
for i in n:
	print(i, end="\n")		
ssh.close()