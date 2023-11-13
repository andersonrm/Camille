##re-add setwd
setwd("C:/Users/camil/OneDrive/Documents/Camille Wagstaff PhD/R2")
install.packages("rlang")
install.packages("readr")
library(readr)
library(rlang)
install.packages("tidyr")
library(tidyr)
install.packages('dplyr')
library(dplyr)
install.packages('ggplot2')
library(ggplot2)

d <- read_csv('2019 GCA BLH.csv')
d=subset(d,d$BLH != "TOM")
d=subset(d,d$BLH != 'NTC')

d=subset(d,d$Organism != 'PREDICTED')
d=subset(d,d$Genus != 'PREDICTED:')
d$Genus=ifelse(d$Genus =='Cannabia', 'Cannabis',d$Genus)



d$pres=1 ##creates this new column in your data that just indicates that all the species listed are "present"


wided=d%>% ##telling R what dataset we want to manipulate and what the new name is "wide2010" here
  
  group_by(Genus, BLH, Region, Date )%>% ##this is just how I want to group my data. For you, it would be your site/plot factors and individual hopper ID. Note you'll want to put your Species ID column!
  
  summarize(pres=mean(pres))%>% ## this won't change anything but is for some reason necessary bc of the grouping argument
  
  spread(Genus,pres,fill=0) ##spp is the column that had my species names (telling R to "spread" this column wide), pres is the column of values that will go in each new column, fill=0 tells R to give the species a 0 if it doesn't already have a value assigned (i.e., if amaranthus isn't present in an individual's gut, it will get a 0 in the amaranthus column for that individual)


wided$rich=as.numeric(apply(wided[,4:82],1,sum))
ggplot(wided)+geom_histogram(aes(x=rich, y=after_stat(density)))

longd=d%>% 
  group_by(Genus, BLH, Region, Date)%>%
  summarize(pres=mean(pres))

plant=longd%>%group_by(Genus)%>%summarize(individuals=n())
plant%>%filter(individuals>5)%>%ggplot(aes(x=Genus, y=individuals))+geom_bar(stat='identity')
