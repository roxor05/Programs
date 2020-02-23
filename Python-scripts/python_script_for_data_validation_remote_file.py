# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from cassandra.cluster import Cluster
from cassandra.auth import PlainTextAuthProvider
import datetime
import os

############# If you need to check 24hrs from the time you run the code ###########

#yesterday
lastHourDateTime = datetime.datetime.now() - datetime.timedelta(hours = 24)
Time_from=lastHourDateTime.strftime('%Y-%m-%d %H:%M:%S') # changing format from datetime to string format
print(Time_from)
print('----------------------------')
#today
Time_now=datetime.datetime.now()
Time_to=Time_now.strftime('%Y-%m-%d %H:%M:%S') # changing format from datetime to string format
print(Time_to)
print('----------------------------')
####################################################################################


################ Manual dates #########################
############# If you need to check on specific date ###########

# Time_from='2020-02-17 05:30:00'  # format = year:month:date hr:min:sec
# print(Time_from)
# print('----------------------------')
# Time_to='2020-02-18 05:30:00' # format = year:month:date hr:min:sec
# print(Time_to)
# print('----------------------------')
###############################################################


# to connect to cassandra and run the query
username=''
password=''
auth_provider = PlainTextAuthProvider(username= username, password= password)
cluster = Cluster(contact_points = ["172.31.26.42"],port = 9042, auth_provider=auth_provider)
session = cluster.connect("avanir")
# to find Veeva CRM tables in snowflake
filepath = 'Source_Names.txt'
with open(filepath) as fp:
   line = fp.readline()
   cnt = 1
   while line:
      result=session.execute("select * from avanir.avanir_etl_run_log where source = '{}' and description = 'Data Updated in snowflake' and time >= '{}' and time <= '{}' ALLOW FILTERING;".format(line.strip(),Time_from,Time_to))
      for rows in result:
              print(rows.table_name,"/",rows.time)
      #print('--------------------------------------------------------------------------------')
      result=session.execute("select * from avanir.avanir_etl_run_log where source = '{}' and description = 'Data Updated in snowflake' and time >= '{}' and time <= '{}' ALLOW FILTERING;".format(line.strip(),Time_from,Time_to))
      for rows in result:
              print(rows.table_name,end=",")
              print(rows.table_name,file=open("output.txt", "a"))
      # to find other source tables in snowflake
      result=session.execute("select * from avanir.avanir_etl_run_log where source = '{}' and description = 'Data loaded to snowflake' and time >= '{}' and time <= '{}' ALLOW FILTERING;".format(line.strip(),Time_from,Time_to))
      for rows in result:
              print(rows.table_name,"/",rows.time)
      #print('--------------------------------------------------------------------------------')
      result=session.execute("select * from avanir.avanir_etl_run_log where source = '{}' and description = 'Data loaded to snowflake' and time >= '{}' and time <= '{}' ALLOW FILTERING;".format(line.strip(),Time_from,Time_to))
      for rows in result:
              print(rows.table_name,end=",")
              print(rows.table_name,file=open("output.txt", "a"))
      line = fp.readline()
      cnt += 1
      print('\n')
      print('--------------------------------------------------------------------------------')
cluster.shutdown()