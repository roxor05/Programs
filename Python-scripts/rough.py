# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import snowflake.connector 
File1='rough.txt'
# File2='rough1.txt'

print('-----------------------------------------------------------------')
print('Data in AVNR_UAT Database')
print('-----------------------------------------------------------------')
Username = ''
Password = ''
account = ''
conn = snowflake.connector.connect(
                user= Username,
                password= Password,
                account= account,
                warehouse='COMPUTE_WH_XS',
                database='AVNR_DEV',
                schema='L3',
                role='IT_DEV'
                )

# Create cursor
cur = conn.cursor()
#### Tables in L1 schema ####
with open(File1,'r') as f:
    try:    
        for line in f:
                if 'select category' in line:
                    cur.execute("{}".format(line))
                    for (value1,value2) in cur:
                        print('{}'.format(str(value1)) + '\n' + '{}'.format(str(value2)) + '\n' )
                else:
                    cur.execute("{}".format(line))
                    for (value,) in cur:
                        print(value)
    except Exception as e:
        print(e)
cur.close()
conn.close()