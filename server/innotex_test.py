#!/usr/bin/env python3
# -*- coding: utf-8 -*
from __future__ import unicode_literals
import cgi
import json
import pandas as pd

gettext = cgi.FieldStorage()
name= gettext.getfirst("name", "empty")
balance=gettext.getfirst("balance", "empty")


# df=pd.DataFrame(columns=['id', 'name', 'balance'])
# df[['id', 'name', 'balance']].to_csv('current_table.csv', index=False)

# df_trasactions=pd.DataFrame(columns={'UUID', 'send_user_id','receive_user_id', 'value' })
# df_trasactions.to_csv('transactions_table.csv',index=False,header=True)


df=pd.read_csv('current_table.csv')
max_id=0 if len(df)==0 else df['id'].max()
df_new=pd.DataFrame({'id':max_id+1, 'name':[name], 'balance':[balance] })
df=pd.concat((df,df_new.copy()),ignore_index=True)
df.to_csv('current_table.csv', index=False, header=True)

result = {'id':str(max_id+1),'name':str(name),'offline_balance':str(int(float(balance)*0.1))};

print('Content-Type: application/json\n\n')
print(json.dumps(result))