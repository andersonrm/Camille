##Final Project STATS511 - Camille Wagstaff - SP'24

#Assessing seasonal host use and pathogen transmission by beet leafhopper in vegetable and hemp crop systems
#Dataset is 3 years of sampling leaves tested for 2 pathogens: BCTV (virus) and CPt (bacteria)

## Import dataset/set directory

#RMA# If this doesn't find your directory, delete this line and use setwd()
knitr::opts_knit$set(root.dir = rprojroot::find_rstudio_root_file())


#RMA# my directory has a "data/" folder, you may need to delete this part below:
data <- read.csv("data/Plants.csv")


#view structure of df
str(data)
View(data)

## set up libraries
library(tidyverse)
#RMA# tidyverse loads ggplot and dplyr among many others.

#set as factors
# data$Time.period = factor(data$Time.period)
# data$Region = factor(data$Region)
# data$Zone = factor(data$Zone)
# data$Plant = factor(data$Plant)
# data$BCTV = factor(data$BCTV)
# data$BLTVA= factor(data$BLTVA)

#RMA# Here's a fast way to convert all the above to factors:

data <- data %>% 
  mutate(across(c(
    # convert everything between time.period and bltva to factors:
    Time.period : BCTV
  ), as.factor)) %>% 
  
  # however, we will likely want to have BLTV and BCTV as numeric for analyses:
  mutate(bctv = as.numeric(BCTV) - 1,
         bltva = as.numeric(BLTVA) - 1)
  # this keeps your factor variables and adds two numeric versions as well.

#confirm factors and run descriptive stats
str(data)
summary(data)
#RMA# Notice that we now have different values for the factor and numeric
# versions of BCTV and BLTVA

#Descriptive stats
# Calculate infection rates by plant for each pathogen
infection_by_plant <- aggregate(cbind(BCTV, BLTVA) ~ Plant, data, mean)
head(infection_by_plant)

#                  Plant       BCTV      BLTVA
#1                 Brush 0.00000000 0.06666667
#2                Kochia 0.28985507 0.68115942
#3               Mustard 0.68604651 0.67441860
#4 Netseed lambsquarters 0.13636364 0.90909091
#5               Pigweed 0.00000000 0.15151515
#6                Potato 0.05633803 0.78873239

#RMA# similarly, new rates using numeric:
data.means <- aggregate(cbind(bctv, bltva) ~ Plant, data = data, FUN = mean)


#Plot means
ggplot(data.means, aes(x = Plant, y = bctv)) +
  geom_col()

#Plot means
ggplot(data.means, aes(x = Plant, y = bltva)) +
  geom_col()



#binary logistic regression for bacteria and time period
model_Time.per <- glm(BLTVA ~ Time.period, family ='binomial', data = data)
summary(model_Time.per)
anova(model_Time.per)
#RMA# I don't think this is what you want. Using Time.period, a factor with 15
# levels will eat 15 degrees of freedom, reducing your statistical power, making
# it harder to detect any effects. Also, R does not know the order of this
# variable so if you're looking to show an effect of time, this isn't the way to
# go. Instead consider using Julian days.


#binary logistic regression for virus and time period
model_Time.per <- glm(BCTV ~ Time.period, family ='binomial', data = data)
summary(model_Time.per)
anova(model_Time.per)


# Calculate infection rates by time period for each pathogen
infection_by_time <- aggregate(cbind(BCTV, BLTVA) ~ Time.period, data, mean)
head(infection_by_time)


#plot raw data
ggplot(data, aes(x=Time.period, y=BLTVA)) + geom_jitter()

#plot raw data
ggplot(data, aes(x=Time.period, y=BCTV)) + geom_jitter()



#binary logistic regression for bacteria and location
model_Region <- glm(BLTVA ~ Region, family ='binomial', data = data)
summary(model_Region)
anova(model_Region)
#RMA# try swapping BLTVA (a factor) for bltva (a numeric).


#binary logistic regression for virus and location
model_Region <- glm(BCTV ~ Region, family ='binomial', data = data)
summary(model_Region)
anova(model_Region)
#RMA# same here

# Calculate infection rates by region for each pathogen
infection_by_region <- aggregate(cbind(BCTV, BLTVA) ~ Region, data, mean)
head(infection_by_region)


#plot raw data
ggplot(data, aes(x=Region, y=BLTVA)) + geom_jitter()

#plot raw data
ggplot(data, aes(x=Region, y=BCTV)) + geom_jitter()



# Find the plant with the highest BCTV infection rate
highest_BCTV_plant <- infection_by_plant[which.max(infection_by_plant$BCTV), "Type_of_Plant"]

# Find the plant with the highest BLTVA infection rate
highest_BLTVA_plant <- infection_by_plant[which.max(infection_by_plant$BLTVA), "Type_of_Plant"]

# Find the time period with the highest BCTV infection rate
highest_BCTV_time <- infection_by_time[which.max(infection_by_time$BCTV), "Time_Period"]

# Find the time period with the highest BLTVA infection rate
highest_BLTVA_time <- infection_by_time[which.max(infection_by_time$BLTVA), "Time_Period"]

# Find the region with the highest BCTV infection rate
highest_BCTV_region <- infection_by_region[which.max(infection_by_region$BCTV), "Region"]

# Find the region with the highest BLTVA infection rate
highest_BLTVA_region <- infection_by_region[which.max(infection_by_region$BLTVA), "Region"]


