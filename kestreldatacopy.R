#add to git



library(stringr)
library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)

setwd("/Users/corryn/Documents/SERCFucus/LoggerData/SFMLogger/RInput")

raw_k2503411_May13 <- read.csv("export_2503411TT512209_2020_5_13_12.csv", header = TRUE, skip =4) 


df <- data.frame(Ints=integer(), DateTime=character(),Temp=double(),
                 Relative_Humidity=double(),Heat_Stress=double(),
                 Dew_Point=double())

edit_Kestrel <- function(df){
  colnames(df) <- c("DateTime","Temp","Relative_Humidity","Heat_Stress","Dew_Point")
  df<-select(df, DateTime, Temp, Relative_Humidity)
  df<- separate(df, DateTime, c("Date","Time"), sep = " ", remove= TRUE, convert = TRUE, extra="merge", fill="left")
  df<- mutate(df, Hours = str_sub(Time, start = 1, end = 2))
  df$Hours = as.double(df$Hours)
  glimpse(df)
  return(df)
  
}

#edit specific data
k_May13<-edit_Kestrel(raw_k2503411_May13)
k_May13 <- k_May13 %>% filter(Date=="2020-05-13") #set date to correct day
k_May13 <- k_May13 %>% filter(Hours>7) #exclude time not in range (8am-12pm)
glimpse(k_May13)

#ggplot
ggplot(data=k_May13)+
  geom_point(mapping = aes(x=Time, y = Temp))

ggplot(data=k_May13)+
  geom_boxplot(mapping = aes(x=Time, y = Temp))
?geom_boxplot

