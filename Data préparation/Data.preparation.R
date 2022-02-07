###data preparation ##   

library(dplyr)  
library(stringr)
   
ds=list.files("/Users/midou/Desktop/coin_data") 

coin_names =c() 
for (item in ds) {
  name=str_split(item , ".csv" ,simplify = TRUE)[1]   
  coin_names <- c(coin_names, name)
}




for (filename in 1:length(ds)){ 
  datac=read.csv(paste("/Users/midou/Desktop/coin_data/",ds[filename],sep = ""))   
  datac = datac %>% filter(timestamp > "2019-03-28 04:00:00" )  
  rownames(datac) <- datac$timestamp
  for (name in 2: length(colnames(datac))){ 
    colnames(datac)[name]<-paste(colnames(datac)[name],coin_names[filename])
 }
  rownames(datac) <- datac$timestamp
   assign(coin_names[filename] , datac)
   rm(datac) 
   
}  

 ### merginig automaticly by timestemp : 
data1=merge(BTCUSDT ,DASHUSDT)
data2=merge(ETHUSDT ,LTCUSDT) 
data3=merge(XMRUSDT , XRPUSDT) 
data4=merge(data1 ,ZRXUSDT)  
rm(data1) 
data5=merge(data4,data2) 
data6=merge(data5 ,data3) 

write.csv(data6 , file = "/Users/midou/Desktop/dashbord_coin.csv") 

rm(data2)  
rm(data3) 
rm(data4) 
