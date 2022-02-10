#Lucas dans ce script t'aura besion just d'une fonction et de la comprendre c'est la fonction Dash simule tu dois mettre en input le montant , et la paire name  
#et la stratgy pour la paire name il faut précise dans l'input que (paire ='XRPUSDT' 
#il faut pas ecrire 'XRPUSDT SEULE' sinon la fonction comprendra pas et prendra btc par défaut 
#pour Avoir la fonction just excute cette commande :  
#==> source("https://raw.githubusercontent.com/medseddik1999/Crypto_Dashbord_simulator-/main/Simulation_Functions_dash.R")

library(stringr) 

DAta_coin=read.csv('https://github.com/medseddik1999/Crypto_Dashbord_simulator-/blob/main/Stratgy_Dash/dash_final_tab.csv')
 
#ds=list.files("/Users/midou/Desktop/coin_data") 

#coin_names =c()  
#for (item in ds) {
 # name=str_split(item , ".csv" ,simplify = TRUE)[1]   
 # coin_names <- c(coin_names, name)
#}

#data1=read.csv('https://raw.githubusercontent.com/medseddik1999/Crypto_Dashbord_simulator-/main/prediction.csv')
#data1=data1[1:1030,]
#for(name in coin_names){ 
  #DAta_coin[fuss(name,'forecast')]=data1[fuss(name,'forecast')] 
#}

coin_names=c("BTCUSDT" , "DASHUSDT" ,"ETHUSDT"  ,"LTCUSDT" , "XMRUSDT"  ,"XRPUSDT"  ,"ZRXUSDT" ) 



##-----Some functions to use------ 
fuss=function(name ,col){
  dot='.' 
  ghg=paste(col,dot,name,sep = '') 
  ghg
}

buy=function(m,coiin,p,name,df){ 
  ho<-m
  coiin<-m/df[p,fuss(name,'close')] 
  coiin<-coiin-0.007*coiin 
  birp<-m+coiin*df[p,fuss(name,'close')] 
  timp<-df[p,'timestamp']
  rendemt<-((birp-ho)/ho)  
  row<-c(timp,birp,rendemt) 
  return(row)
  
}  

sell=function(coiin,m,p,name,df){
  ho<-m
  m<-coiin*df[p,fuss(name,'close')]  
  m<-m-m*0.007  
  birp<-m+coiin*df[p,fuss(name,'close')] 
  timp<-df[p,'timestamp']
  rendemt<-((birp-ho)/ho)  
  row<-c(timp , birp ,rendemt) 
  return(row) 
  
}

if_trix=function(stg){
  if (stg=='Trix'){
    return(TRUE) } 
  else{return(FALSE)}
}

if_super=function(stg){
  if (stg=='SuperTrend'){
    return(TRUE) } 
  else{return(FALSE)}
}

if_AO=function(stg){
  if (stg=='AwosomeOs'){
    return(TRUE) } 
  else{return(FALSE)}
}  

if_Arima=function(stg){
  if (stg=='ArimaPred'){
    return(TRUE) } 
  else{return(FALSE)}
}

Super_condition1=function(df,p,name){
  if(
    df[p,fuss(name,'SUPER_TREND_DIRECTION1')]+
    df[p,fuss(name,'SUPER_TREND_DIRECTION2')]+df[p,fuss(name,'SUPER_TREND_DIRECTION3')] >=1 &
    df[p,fuss(name,'STOCH_RSI')]<0.8 & df[p,fuss(name,'close')]>df[p,fuss(name,'EMA50')] ){
    return(TRUE)
  }
  else{
    return(FALSE)
  }
} 

Super_condition2=function(df,p,name){
  if(
    df[p,fuss(name,'SUPER_TREND_DIRECTION1')]+
    df[p,fuss(name,'SUPER_TREND_DIRECTION2')]+df[p,fuss(name,'SUPER_TREND_DIRECTION3')] <1 &
    df[p,fuss(name,'STOCH_RSI')]>0.2 ){
    return(TRUE)
  }
  else{
    return(FALSE)
  }
} 

for (name in coin_names){
  
  DAta_coin[fuss(name,'SUPERT')]=DAta_coin[fuss(name,'SUPER_TREND_DIRECTION1')]+
    DAta_coin[fuss(name,'SUPER_TREND_DIRECTION2')]+DAta_coin[fuss(name,'SUPER_TREND_DIRECTION3')]
  
}

DAta_coin[DAta_coin$SUPERT.BTCUSDT==-1,]

#------strg simulation ------ 

simulate_trix=function(m ,coiin=0,name='BTCUSDT',df){
  simule<-data.frame() 
  ho<-m
  for (p in 1:1030){
        if (!is.na(df[p,fuss(name,'TRIX_histo')])){  
          if (df[p,fuss(name,'TRIX_histo')] >0 & df[p,fuss(name,'STOCH_RSI')]<0.8 & m>10){ 
            coiin<-m/df[p,fuss(name,'close')] 
            coiin<-coiin-0.007*coiin
            m<-0
            birp<-m+coiin*df[p,fuss(name,'close')] 
            timp<-df[p,'timestamp']
            rendemt<-((birp-ho)/ho)  
            side<-'Buy'
            row<-c(timp,birp,rendemt,side) 
            simule=rbind(simule,row)
            
            
          }
          if(df[p,fuss(name,'TRIX_histo')]<0 & df[p,fuss(name,'STOCH_RSI')]>0.2 & coiin>0.0001){ 
            m<-coiin*df[p,fuss(name,'close')]  
            m<-m-m*0.007 
            coiin<-0
            birp<-m+coiin*df[p,fuss(name,'close')] 
            timp<-df[p,'timestamp']
            rendemt<-((birp-ho)/ho) 
            side='Sell'
            row<-c(timp , birp ,rendemt ,side) 
            simule=rbind(simule,row) 
             } 
        }
      }
     
  
    colnames(simule)[1:4]<-c('date' ,'portfolio','performance' ,'side') 
    return(simule)
} 
##-------- SUper simule-----  
plot(simulate_trix(m=1000,0,'LTCUSDT',DAta_coin)$portfolio ,type = 'l')                  

         
simulate_super2=function(m ,coiin=0,name='BTCUSDT',df){
  simule<-data.frame() 
  ho<-m  
  for (p in 15:1030){
    if (is.na(df[p,fuss(name,'EMA50')])==FALSE){  
      if (df[p,fuss(name,'SUPERT')]>1 & df[p,fuss(name,'STOCH_RSI')]<0.8
          & df[p,fuss(name,'close')]>df[p,fuss(name,'EMA50')] & m>10) { 
        coiin<-m/df[p,fuss(name,'close')] 
        coiin<-coiin-0.007*coiin
        m<-0
        birp<-m+coiin*df[p,fuss(name,'close')] 
        timp<-df[p,'timestamp']
        rendemt<-((birp-ho)/ho)  
        side<-'Buy'
        row<-c(timp,birp,rendemt,side) 
        simule<-rbind(simule,row)
        
        
      }
      if(df[p,fuss(name,'SUPERT')]<=1 & df[p,fuss(name,'STOCH_RSI')]>0.2 & coiin>0.001){ 
        m<-coiin*df[p,fuss(name,'close')]  
        m<-m-m*0.007 
        coiin<-0
        birp<-m+coiin*df[p,fuss(name,'close')] 
        timp<-df[p,'timestamp']
        rendemt<-((birp-ho)/ho) 
        side='Sell'
        row<-c(timp , birp ,rendemt ,side) 
        simule=rbind(simule,row) 
      } 
    }
  }  
  colnames(simule)[1:4]<-c('date' ,'portfolio','performance' ,'side') 
  return(simule) 
}

##----Simulate__AO---- 
simulate_AO=function(m ,coiin=0,name='BTCUSDT',df){
  simule<-data.frame() 
  ho<-m  
  for (p in 15:1030){
    if (is.na(df[p,fuss(name,'AO')])==FALSE & is.na(df[p,fuss(name,'WillR')])==FALSE ){  
      if (df[p,fuss(name,'AO')]>=0 & df[p,fuss(name,'WillR')]< -85 & m>10) { 
        coiin<-m/df[p,fuss(name,'close')] 
        coiin<-coiin-0.007*coiin
        m<-0
        birp<-m+coiin*df[p,fuss(name,'close')] 
        timp<-df[p,'timestamp']
        rendemt<-((birp-ho)/ho)  
        side<-'Buy'
        row<-c(timp,birp,rendemt,side) 
        simule<-rbind(simule,row)
        
        
      }
      if(df[p,fuss(name,'AO')]< 0 & df[p,fuss(name,'STOCH_RSI')]>0.2 & coiin>0.001){ 
        m<-coiin*df[p,fuss(name,'close')]  
        m<-m-m*0.007 
        coiin<-0
        birp<-m+coiin*df[p,fuss(name,'close')] 
        timp<-df[p,'timestamp']
        rendemt<-((birp-ho)/ho) 
        side='Sell'
        row<-c(timp , birp ,rendemt ,side) 
        simule=rbind(simule,row) 
      } 
    }
  }  
  colnames(simule)[1:4]<-c('date' ,'portfolio','performance' ,'side') 
  return(simule) 
}


simulate_Arima=function(m ,coiin=0,name='BTCUSDT',df){
  simule<-data.frame() 
  ho<-m  
  for (p in 15:1020){
    if (is.na(df[p,fuss(name,'forecast')])==FALSE){  
      if (df[p+10,fuss(name,'forecast')]>=df[p,fuss(name,'close')]*0.3+df[p,fuss(name,'close')] & m>10) { 
        coiin<-m/df[p,fuss(name,'close')] 
        coiin<-coiin-0.007*coiin
        m<-0
        birp<-m+coiin*df[p,fuss(name,'close')] 
        timp<-df[p,'timestamp']
        rendemt<-((birp-ho)/ho)  
        side<-'Buy'
        row<-c(timp,birp,rendemt,side) 
        simule<-rbind(simule,row)
        
        
      }
      if(df[p+10,fuss(name,'forecast')]<df[p,fuss(name,'close')]*0.1+df[p,fuss(name,'close')] & coiin>0.001){ 
        m<-coiin*df[p,fuss(name,'close')]  
        m<-m-m*0.007 
        coiin<-0
        birp<-m+coiin*df[p,fuss(name,'close')] 
        timp<-df[p,'timestamp']
        rendemt<-((birp-ho)/ho) 
        side='Sell'
        row<-c(timp , birp ,rendemt ,side) 
        simule=rbind(simule,row) 
      } 
    }
  }  
  colnames(simule)[1:4]<-c('date' ,'portfolio','performance' ,'side') 
  return(simule) 
}

simulate_Arima(1407,name='BTCUSDT' ,df=DAta_coin)







Dash_Simule=function(m,coiin=0,pair,stg='Trix' ,df1){ 
  if (if_trix(stg)==TRUE){ 
    return(simulate_trix(m ,name = pair ,df=df1)) 
  } 
  else if (if_super(stg)==TRUE){
    return(simulate_super2(m,name = pair, df=df1))
  } 
  else if (if_AO(stg)==TRUE){
    return(simulate_AO(m,name= pair ,df=df1)) 
  } else if(if_Arima(stg)==TRUE){ 
    return(simulate_Arima(m,name= pair ,df=df1))
    }else {
    print("please make sure about stg name :stg = 'Trix' or 'SuperTrend' or 'AwosomeOs'") 
  }
} 



#stg = 'Trix' or 'SuperTrend' or 'AwosomeOs' or 'ArimaPred'
#plot(Dash_Simule(1000 , pair = 'DASHUSDT' ,stg = 'SuperTrend')$portfolio , type='l')    
#lines(Dash_Simule(1000 , pair = 'DASHUSDT' ,stg = 'Trix')$portfolio , type='l') 
#Dash_Simule(1000 , pair = 'XRPUSDT' ,stg = 'SuperTrend' ,df=DAta_coin)       

 

#write.csv(DAta_coin,file =  "/Users/midou/Desktop/dash_final_tab.csv") 



