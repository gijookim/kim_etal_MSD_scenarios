
# This script is used to generate Figures 3, Figures S4-S7 in
#"Identifying the Uncertainties and Drivers of Future Human Outcomes through a Multisector Scenario Ensemble"

#load required libraries
library(dplyr)
library(randomForest)
library(magrittr)

#Set path (this should be changed for your local machine)
setwd("/cluster/tufts/lamontagnelab/gkim14/MSD_Scenarios/Zenodo_Organization/Github/processed_data")

############################# FOR FOOD AND RESIDENTIAL ENERGY BURDENS #############################
#Load CSV of metrics data
metrics <- read.csv('fds_eb_2050_org.csv')
metrics[is.na(metrics)] <- 0

#initialize an empty dataframe to store the parameter importance scores
sum_importances = data.frame()

#specify basin(s) for regression analysis
region_list <- unique(metrics$region)
group_list <- c(1,5,10)

#loop through basins
for (grp in group_list){
  
  sum_importances = data.frame()
  
  for (reg in region_list) {
    
    #filter to single basin and year
    metrics %>% filter(region==reg & group==grp) -> df_filt
    
    #make sure that the parameters are categorical variables!
    df_filt$soc=as.factor(df_filt$soc)
    df_filt$icd=as.factor(df_filt$icd)
    df_filt$co2=as.factor(df_filt$co2)
    df_filt$ag=as.factor(df_filt$ag)
    df_filt$fd=as.factor(df_filt$fd)
    df_filt$bee=as.factor(df_filt$bee)
    df_filt$ed=as.factor(df_filt$ed)
    df_filt$res=as.factor(df_filt$res)
    df_filt$gcm=as.factor(df_filt$gcm)
    
    #remove duplicates from dataset
    df_filt %>% distinct(soc,icd,co2,ag,fd,bee,ed,res,gcm,reb_pct, .keep_all= TRUE) -> no_dups
    
    #filter data to just what's required for regression analysis (7 parameter assumptions,metric)
    #here the scarcity metric is physical water scarcity (pws)
    df_regr <- subset(no_dups, select = c("soc","icd","co2","ag","fd","bee","ed","res","gcm","reb_pct"))
    
    #regression using the randomforest package
    rf_regr <- randomForest(
      reb_pct~.,
      data=df_regr,mtry=7,importance=TRUE,ntree=200) #bagging (mtry = 7)
    
    #Put variable importance scores into dataframe
    importance_df <- as.data.frame(rf_regr %>% importance)
    importance_df$varnames <- rownames(importance_df)
    rownames(importance_df) <- NULL  
    importance_df$region <- reg
    importance_df$metric <- 'reb'
    
    #add to the sum_importances storage dataframe
    sum_importances <- rbind(sum_importances,importance_df)
    print(reg)
  }
  
  write.csv(sum_importances, paste0("RT_Results/RT_reg_reb_2050_g", grp, ".csv"))
  print(grp)
}



############################# FOR PHYSICAL WATER SCARCITY #############################

#specify basin(s) for regression analysis
metrics <- read.csv('region_pws_2050_full_ensemble.csv')
region_list <- unique(metrics$region)

#loop through basins
sum_importances = data.frame()
  
for (reg in region_list) {
  
  #filter to single basin and year
  metrics %>% filter(region==reg) -> df_filt
  
  #make sure that the parameters are categorical variables!
  df_filt$soc=as.factor(df_filt$soc)
  df_filt$icd=as.factor(df_filt$icd)
  df_filt$co2=as.factor(df_filt$co2)
  df_filt$ag=as.factor(df_filt$ag)
  df_filt$fd=as.factor(df_filt$fd)
  df_filt$bee=as.factor(df_filt$bee)
  df_filt$ed=as.factor(df_filt$ed)
  df_filt$res=as.factor(df_filt$res)
  df_filt$gcm=as.factor(df_filt$gcm)
  
  #remove duplicates from dataset
  df_filt %>% distinct(soc,icd,co2,ag,fd,bee,ed,res,gcm,wgt_reg_pws, .keep_all= TRUE) -> no_dups
  
  #filter data to just what's required for regression analysis (7 parameter assumptions,metric)
  #here the scarcity metric is physical water scarcity (pws)
  df_regr <- subset(no_dups, select = c("soc","icd","co2","ag","fd","bee","ed","res","gcm","wgt_reg_pws"))
  
  #regression using the randomforest package
  rf_regr <- randomForest(
    wgt_reg_pws~.,
    data=df_regr,mtry=7,importance=TRUE,ntree=200) #bagging (mtry = 7)
  
  #Put variable importance scores into dataframe
  importance_df <- as.data.frame(rf_regr %>% importance)
  importance_df$varnames <- rownames(importance_df)
  rownames(importance_df) <- NULL  
  importance_df$region <- reg
  importance_df$metric <- 'pws'
  
  #add to the sum_importances storage dataframe
  sum_importances <- rbind(sum_importances,importance_df)
  print(reg)
}

write.csv(sum_importances, "RT_Results/RT_reg_pws_2050.csv")


