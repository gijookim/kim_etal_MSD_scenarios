#This script is used to generate Figure 4 in
#"Drivers of Future Physical Water Scarcity and its Economic Impacts in Latin America and the Caribbean"

#Running this code produces a classification tree for the specified basin (variable "bs" - reurn the code with the basin 
#of your choice) 
#The binary classification threshold is whether a scenario is severe for the physical water scarcity metric

#Load required libraries
library(rpart) #CART
library(rpart.plot) #plot CART
library(dplyr)
library(magrittr)

#Set path (this should be changed for your local machine)
setwd("/cluster/tufts/lamontagnelab/gkim14/MSD_Scenarios/Zenodo_Organization/Github/processed_data")

#Load CSV of metrics data
metrics <- read.csv('fds_eb_2050_org.csv')


############################# EXAMPLE 1: EASTERN EUROPE (SYNERGY) ############################# 
reg = "Europe_Eastern"
grp = 1

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
df_filt %>% distinct(soc,icd,co2,ag,fd,bee,ed,res,gcm,fb_pct,reb_pct, .keep_all= TRUE) -> no_dups

#create pws_binary which is threshold for most severe scenarios (physical water scarcity > 0.4)
no_dups$metric_binary_jointly_lo <- (no_dups$fb_pct < quantile(no_dups$fb_pct, 0.2)) & (no_dups$reb_pct < quantile(no_dups$reb_pct, 0.2))
no_dups$metric_binary_jointly_hi <- (no_dups$fb_pct > quantile(no_dups$fb_pct, 0.8)) & (no_dups$reb_pct > quantile(no_dups$reb_pct, 0.8))

#filter to just parameter assumptions and binary threshold (wta_binary)
df_class_lo <- subset(no_dups, select = c("soc","icd","co2","ag","fd","bee","ed","res","gcm","metric_binary_jointly_lo"))
df_class_hi <- subset(no_dups, select = c("soc","icd","co2","ag","fd","bee","ed","res","gcm","metric_binary_jointly_hi"))

#run classification with max depth = 4
fit_class_lo <- rpart(metric_binary_jointly_lo ~ .,
                   method="class", data=df_class_lo,control=c(maxdepth=4,cp=.0001))
#plot classification tree
rpart.plot(fit_class_lo, main = paste0(reg,", Jointly Low Burden Scenarios"))



# Counting to re-draw Classification Trees
low_outcomes <- no_dups[no_dups$metric_binary_jointly_lo==TRUE,]
nrow(low_outcomes)

nrow(low_outcomes[low_outcomes$co2=="ref",])
nrow(low_outcomes[(low_outcomes$soc=="soc2")|(low_outcomes$soc=="soc3"),])/nrow(low_outcomes)
nrow(low_outcomes[low_outcomes$soc=="soc5",])/nrow(low_outcomes)

nrow(low_outcomes[((low_outcomes$soc=="soc2")|(low_outcomes$soc=="soc3"))&(low_outcomes$fd=="fd0"),])/nrow(low_outcomes)
nrow(low_outcomes[((low_outcomes$soc=="soc2")|(low_outcomes$soc=="soc3"))&(low_outcomes$fd=="fd1"),])/nrow(low_outcomes)

nrow(low_outcomes[(low_outcomes$soc=="soc5")&(low_outcomes$fd=="fd0"),])/nrow(low_outcomes)
nrow(low_outcomes[(low_outcomes$soc=="soc5")&(low_outcomes$fd=="fd1"),])/nrow(low_outcomes)


#run classification with max depth = 4
fit_class_hi <- rpart(metric_binary_jointly_hi ~ .,
                      method="class", data=df_class_hi,control=c(maxdepth=4,cp=.0001))

#plot classification tree
rpart.plot(fit_class_hi, main = paste0(reg,", Jointly High Burden Scenarios"))

hi_outcomes <- no_dups[no_dups$metric_binary_jointly_hi==TRUE,]
nrow(hi_outcomes)

nrow(hi_outcomes[hi_outcomes$fd=="fd0",])
nrow(hi_outcomes[hi_outcomes$fd=="fd0",])

nrow(hi_outcomes[hi_outcomes$ed=="ed0",])/nrow(hi_outcomes)
nrow(hi_outcomes[hi_outcomes$ed=="ed1",])/nrow(hi_outcomes)

nrow(hi_outcomes[(hi_outcomes$ed=="ed0")&(hi_outcomes$co2=="ref"),])/nrow(hi_outcomes)
nrow(hi_outcomes[(hi_outcomes$ed=="ed0")&(!hi_outcomes$co2=="ref"),])/nrow(hi_outcomes)

nrow(hi_outcomes[(hi_outcomes$ed=="ed0")&(!hi_outcomes$co2=="ref")&(hi_outcomes$soc=="soc2"),])/nrow(hi_outcomes)
nrow(hi_outcomes[(hi_outcomes$ed=="ed0")&(!hi_outcomes$co2=="ref")&(hi_outcomes$soc=="soc3"),])/nrow(hi_outcomes)
nrow(hi_outcomes[(hi_outcomes$ed=="ed0")&(!hi_outcomes$co2=="ref")&(hi_outcomes$soc=="soc5"),])/nrow(hi_outcomes)





############################# EXAMPLE 2: PAKISTAN (TRADEOFF) ############################# 
reg = "Pakistan"
grp = 1

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
df_filt %>% distinct(soc,icd,co2,ag,fd,bee,ed,res,gcm,fb_pct,reb_pct, .keep_all= TRUE) -> no_dups

#create pws_binary which is threshold for most severe scenarios (physical water scarcity > 0.4)
no_dups$metric_binary_food_hi <- (no_dups$fb_pct > quantile(no_dups$fb_pct, 0.8)) & (no_dups$reb_pct < quantile(no_dups$reb_pct, 0.2))
no_dups$metric_binary_energy_hi <- (no_dups$fb_pct < quantile(no_dups$fb_pct, 0.2)) & (no_dups$reb_pct > quantile(no_dups$reb_pct, 0.8))

#filter to just parameter assumptions and binary threshold (wta_binary)
df_class_food_hi <- subset(no_dups, select = c("soc","icd","co2","ag","fd","bee","ed","res","gcm","metric_binary_food_hi"))
df_class_energy_hi <- subset(no_dups, select = c("soc","icd","co2","ag","fd","bee","ed","res","gcm","metric_binary_energy_hi"))


#run classification with max depth = 4
fit_class_food_hi <- rpart(metric_binary_food_hi ~ .,
                      method="class", data=df_class_food_hi,control=c(maxdepth=4,cp=.0001))
#plot classification tree
rpart.plot(fit_class_food_hi, main = paste0(reg,", High Food Burden Scenarios"))


food_hi_outcomes <- no_dups[no_dups$metric_binary_food_hi==TRUE,]
nrow(food_hi_outcomes)

nrow(food_hi_outcomes[food_hi_outcomes$soc=="soc3",])
nrow(food_hi_outcomes[food_hi_outcomes$icd=="icd3",])/nrow(food_hi_outcomes)
nrow(food_hi_outcomes[!food_hi_outcomes$icd=="icd3",])/nrow(food_hi_outcomes)

nrow(food_hi_outcomes[(food_hi_outcomes$icd=="icd3")&(food_hi_outcomes$fd=="fd0"),])/nrow(food_hi_outcomes)
nrow(food_hi_outcomes[(food_hi_outcomes$icd=="icd3")&(food_hi_outcomes$fd=="fd1"),])/nrow(food_hi_outcomes)

nrow(food_hi_outcomes[(food_hi_outcomes$icd=="icd3")&(food_hi_outcomes$fd=="fd0")&(food_hi_outcomes$ag=="ag1"),])/nrow(food_hi_outcomes)
nrow(food_hi_outcomes[(food_hi_outcomes$icd=="icd3")&(food_hi_outcomes$fd=="fd0")&(food_hi_outcomes$ag=="ag2"),])/nrow(food_hi_outcomes)
nrow(food_hi_outcomes[(food_hi_outcomes$icd=="icd3")&(food_hi_outcomes$fd=="fd0")&(food_hi_outcomes$ag=="ag3"),])/nrow(food_hi_outcomes)

nrow(food_hi_outcomes[(!food_hi_outcomes$icd=="icd3")&(food_hi_outcomes$ed=="ed0"),])/nrow(food_hi_outcomes)
nrow(food_hi_outcomes[(!food_hi_outcomes$icd=="icd3")&(food_hi_outcomes$ed=="ed1"),])/nrow(food_hi_outcomes)
nrow(food_hi_outcomes[(!food_hi_outcomes$icd=="icd3")&(food_hi_outcomes$ed=="ed1")&(food_hi_outcomes$fd=="fd0"),])/nrow(food_hi_outcomes)
nrow(food_hi_outcomes[(!food_hi_outcomes$icd=="icd3")&(food_hi_outcomes$ed=="ed1")&(food_hi_outcomes$fd=="fd1"),])/nrow(food_hi_outcomes)



#run classification with max depth = 4
fit_class_energy_hi <- rpart(metric_binary_energy_hi ~ .,
                           method="class", data=df_class_energy_hi,control=c(maxdepth=4,cp=.0001))
#plot classification tree
rpart.plot(fit_class_energy_hi, main = paste0(reg,", High Residential Energy Burden Scenarios"))

energy_hi_outcomes <- no_dups[no_dups$metric_binary_energy_hi==TRUE,]
nrow(energy_hi_outcomes)

nrow(energy_hi_outcomes[!energy_hi_outcomes$soc=="soc5",])/nrow(energy_hi_outcomes)
nrow(energy_hi_outcomes[energy_hi_outcomes$soc=="soc5",])/nrow(energy_hi_outcomes)

nrow(energy_hi_outcomes[(energy_hi_outcomes$soc=="soc5")&(energy_hi_outcomes$ed=="ed0"),])/nrow(energy_hi_outcomes)
nrow(energy_hi_outcomes[(energy_hi_outcomes$soc=="soc5")&(energy_hi_outcomes$ed=="ed1"),])/nrow(energy_hi_outcomes)

nrow(energy_hi_outcomes[(energy_hi_outcomes$soc=="soc5")&(energy_hi_outcomes$ed=="ed0")&(energy_hi_outcomes$co2=="ref"),])/nrow(energy_hi_outcomes)
nrow(energy_hi_outcomes[(energy_hi_outcomes$soc=="soc5")&(energy_hi_outcomes$ed=="ed0")&(!energy_hi_outcomes$co2=="ref"),])/nrow(energy_hi_outcomes)

nrow(energy_hi_outcomes[(energy_hi_outcomes$soc=="soc5")&(energy_hi_outcomes$ed=="ed0")&(!energy_hi_outcomes$co2=="ref")&(energy_hi_outcomes$ag=="ag1"),])/nrow(energy_hi_outcomes)
nrow(energy_hi_outcomes[(energy_hi_outcomes$soc=="soc5")&(energy_hi_outcomes$ed=="ed0")&(!energy_hi_outcomes$co2=="ref")&(energy_hi_outcomes$ag=="ag2"),])/nrow(energy_hi_outcomes)
nrow(energy_hi_outcomes[(energy_hi_outcomes$soc=="soc5")&(energy_hi_outcomes$ed=="ed0")&(!energy_hi_outcomes$co2=="ref")&(energy_hi_outcomes$ag=="ag3"),])/nrow(energy_hi_outcomes)






############################# EXAMPLE 3: NORTHERN SOUTH AMERICA (BOTH POSSIBILITIES) ############################# 
reg = "South America_Northern"
grp = 1

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
df_filt %>% distinct(soc,icd,co2,ag,fd,bee,ed,res,gcm,fb_pct,reb_pct, .keep_all= TRUE) -> no_dups

#create pws_binary which is threshold for most severe scenarios (physical water scarcity > 0.4)
no_dups$metric_binary_energy_hi <- (no_dups$fb_pct < quantile(no_dups$fb_pct, 0.3)) & (no_dups$reb_pct > quantile(no_dups$reb_pct, 0.7))
no_dups$metric_binary_jointly_lo <- (no_dups$fb_pct < quantile(no_dups$fb_pct, 0.3)) & (no_dups$reb_pct < quantile(no_dups$reb_pct, 0.3))

#filter to just parameter assumptions and binary threshold (wta_binary)
df_class_energy_hi <- subset(no_dups, select = c("soc","icd","co2","ag","fd","bee","ed","res","gcm","metric_binary_energy_hi"))
df_class_jointly_lo <- subset(no_dups, select = c("soc","icd","co2","ag","fd","bee","ed","res","gcm","metric_binary_jointly_lo"))

#run classification with max depth = 4
fit_class_energy_hi <- rpart(metric_binary_energy_hi ~ .,
                           method="class", data=df_class_energy_hi,control=c(maxdepth=4,cp=.0001))
#plot classification tree
rpart.plot(fit_class_energy_hi, main = paste0(reg,", High Residential Energy Burden Scenarios"))

energy_hi_outcomes <- no_dups[no_dups$metric_binary_energy_hi==TRUE,]
nrow(energy_hi_outcomes)

nrow(energy_hi_outcomes[energy_hi_outcomes$ed=="ed0",])/nrow(energy_hi_outcomes)
nrow(energy_hi_outcomes[energy_hi_outcomes$ed=="ed1",])/nrow(energy_hi_outcomes)

nrow(energy_hi_outcomes[(energy_hi_outcomes$ed=="ed0")&(energy_hi_outcomes$soc=="soc2"),])/nrow(energy_hi_outcomes)
nrow(energy_hi_outcomes[(energy_hi_outcomes$ed=="ed0")&(energy_hi_outcomes$soc=="soc3"),])/nrow(energy_hi_outcomes)
nrow(energy_hi_outcomes[(energy_hi_outcomes$ed=="ed0")&(energy_hi_outcomes$soc=="soc5"),])/nrow(energy_hi_outcomes)

nrow(energy_hi_outcomes[(energy_hi_outcomes$ed=="ed0")&(energy_hi_outcomes$soc=="soc5")&(energy_hi_outcomes$icd=="icd2"),])/nrow(energy_hi_outcomes)
nrow(energy_hi_outcomes[(energy_hi_outcomes$ed=="ed0")&(energy_hi_outcomes$soc=="soc5")&(energy_hi_outcomes$icd=="icd3"),])/nrow(energy_hi_outcomes)
nrow(energy_hi_outcomes[(energy_hi_outcomes$ed=="ed0")&(energy_hi_outcomes$soc=="soc5")&(energy_hi_outcomes$icd=="icd5"),])/nrow(energy_hi_outcomes)

nrow(energy_hi_outcomes[(energy_hi_outcomes$ed=="ed0")&(energy_hi_outcomes$soc=="soc5")&(!energy_hi_outcomes$icd=="icd3")&(energy_hi_outcomes$co2=="ref"),])/nrow(energy_hi_outcomes)
nrow(energy_hi_outcomes[(energy_hi_outcomes$ed=="ed0")&(energy_hi_outcomes$soc=="soc5")&(!energy_hi_outcomes$icd=="icd3")&(energy_hi_outcomes$co2=="ndc"),])/nrow(energy_hi_outcomes)
nrow(energy_hi_outcomes[(energy_hi_outcomes$ed=="ed0")&(energy_hi_outcomes$soc=="soc5")&(!energy_hi_outcomes$icd=="icd3")&(energy_hi_outcomes$co2=="ndl"),])/nrow(energy_hi_outcomes)



#run classification with max depth = 4
fit_class_lo <- rpart(metric_binary_jointly_lo ~ .,
                      method="class", data=df_class_jointly_lo,control=c(maxdepth=4,cp=.0001))
#plot classification tree
rpart.plot(fit_class_lo, main = paste0(reg,", Jointly Low Burden Scenarios"))

# Counting to re-draw Classification Trees
low_outcomes <- no_dups[no_dups$metric_binary_jointly_lo==TRUE,]
nrow(low_outcomes)

nrow(low_outcomes[low_outcomes$ed=="ed0",])/nrow(low_outcomes)
nrow(low_outcomes[low_outcomes$ed=="ed1",])/nrow(low_outcomes)

nrow(low_outcomes[(low_outcomes$ed=="ed1")&(low_outcomes$co2=="ref"),])/nrow(low_outcomes)

nrow(low_outcomes[(low_outcomes$ed=="ed1")&(low_outcomes$co2=="ref")&(low_outcomes$soc=="soc3"),])/nrow(low_outcomes)
nrow(low_outcomes[(low_outcomes$ed=="ed1")&(low_outcomes$co2=="ref")&(!low_outcomes$soc=="soc3"),])/nrow(low_outcomes)

nrow(low_outcomes[(low_outcomes$ed=="ed1")&(low_outcomes$co2=="ref")&(!low_outcomes$soc=="soc3")&(low_outcomes$gcm=="canesm5"),])/nrow(low_outcomes)
nrow(low_outcomes[(low_outcomes$ed=="ed1")&(low_outcomes$co2=="ref")&(!low_outcomes$soc=="soc3")&(!low_outcomes$gcm=="canesm5"),])/nrow(low_outcomes)
