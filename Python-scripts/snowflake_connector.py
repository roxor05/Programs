# -*- coding: utf-8 -*-
from __future__ import unicode_literals
# pip install asn1crypto==1.3.0
# pip install --upgrade snowflake-connector-python
import snowflake.connector 
from datetime import datetime
# Connectio string
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
open("snowflake_count.txt", "w").close()
current_date='2020-02-07'
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
                except:
                            pass
# this prints all the others in the data
            else:
                try:
                    cur.execute("select MAX(EXTRACT_DT),count(*) from {} where EXTRACT_DT='{}';".format(line,current_date))
                    #cur.execute("select MAX(EXTRACT_DT) from {};".format(line))
                    for (EXTRACT_DT,count) in cur:
                        if count == 0:
                           pass
                        else:
                      #for EXTRACT_DT in cur:
                           print('{}------'.format(line.strip()) + 'EXTRACT_DT:{0}------Count:{1}'.format(EXTRACT_DT, count))
                           #print('{}------'.format(line.strip()) + 'EXTRACT_DT:{0}'.format(EXTRACT_DT),file=open("snowflake_count.txt", "a"))

                except:
                    pass