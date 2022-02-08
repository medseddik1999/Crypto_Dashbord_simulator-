#!/usr/bin/env python
# coding: utf-8

# In[1]:


import os  #on cree un dossier 
os.mkdir("/Users/midou/Desktop/coin_data") # change the path for you.  


# In[2]:


#we define list of coin to use historical data. 
paire_name = ["XRPUSDT","BTCUSDT","DASHUSDT","ZRXUSDT","ETHUSDT","XMRUSDT","LTCUSDT","YFIUSDT"]  ##I used 6 coin.   


# In[3]:


from  binance.client import Client ## you need to install binance package  "pip install python-binance"  
import pandas as pd
import numpy as np   
from tqdm import tqdm


# In[4]:


#loop to get data  

for coin in tqdm(paire_name) :  
    interval_time=Client.KLINE_INTERVAL_1DAY 
    date_for_start = "01/01/2017" 
    giveme=Client().get_historical_klines(coin,interval_time,date_for_start)
    df=pd.DataFrame(giveme ,columns=["timestamp","open","high","low","close","volume","closetime","quote_avg","trades","tp","tv","dt2"] )
    del df["dt2"]
    del df["tp"]
    df ["trades"]=pd.to_numeric(df ["trades"])
    df ["closetime"]=pd.to_datetime(df["closetime"] , unit='ms')
    del df["tv"] 
    df["volume"]=pd.to_numeric(df["volume"])
    df["open"]=pd.to_numeric(df["open"])
    df["high"]=pd.to_numeric(df["high"])
    df["low"]=pd.to_numeric(df["low"])
    df["close"]=pd.to_numeric(df["close"])  
    df["timestamp"]=pd.to_datetime(df["timestamp"] , unit="ms")  
    file_path="/Users/midou/Desktop/coin_data/"+coin+".csv"  
    df.to_csv(file_path ,index=False ,encoding='utf-8')  
    


# In[ ]:




