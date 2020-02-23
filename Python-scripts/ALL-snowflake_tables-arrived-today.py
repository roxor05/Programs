# -*- coding: utf-8 -*-
from __future__ import unicode_literals
####  Requirement for running this code  ####
# First install pip3 then install snowflake connector 

# pip3 install asn1crypto==1.3.0
# pip3 install snowflake-connector-python
#########################################################################
import snowflake.connector 
from datetime import datetime
from datetime import date, timedelta

date_today = date.today()
Current_date=date_today.strftime('%Y-%m-%d')
print("--------------------------------------------------------------------------")
print(Current_date + " --- Today's date")
print("--------------------------------------------------------------------------")

####### For a specific date uncomment the below line with the Date required #############

# Current_date='2020-02-19'

#########################################################################################

open("snowflake_tables.txt", "w").close()
Username = ''
Password = ''
account = ''
conn = snowflake.connector.connect(
                user= Username,
                password= Password,
                account= account,
                warehouse='COMPUTE_WH_XS',
                database='AVNR_STAGE',
                schema='INFORMATION_SCHEMA'
                )

# Create cursor
cur = conn.cursor()
#### Tables in L1 schema ####
cur.execute("SELECT DISTINCT TABLE_NAME FROM  TABLES WHERE TABLE_SCHEMA LIKE '%L1%' ORDER BY TABLE_NAME ASC")
for row in cur:
    print(f'{row[0]}',file=open("snowflake_tables.txt", "a"))
cur.close()
conn.close()
print("Tables in L1 schema are copied to snowflake_tables.txt")
print("--------------------------------------------------------------------------")
##### To get the count for L1 tables #####
try:

conn = snowflake.connector.connect(
                user= Username,
                password= Password,
                account= account,
                        warehouse='COMPUTE_WH_XS',
                        database='AVNR_STAGE',
                        schema='L1'
                        )

    cur = conn.cursor()
    # Execute SQL statement

    with open('snowflake_tables.txt','r') as f:
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
                        pass
except Exception as e:
    pass
cur.close()
conn.close()