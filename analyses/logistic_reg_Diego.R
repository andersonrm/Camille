# Regression analysis of BLH infection status on plant species richness
library(tidyverse)
library(sjPlot)


camille_2019 <- read.csv("data/camille.2019.csv")
camille_2020 <- read.csv("data/camille.2020.csv")
camille_2021 <- read.csv("data/camille.2021.csv")

#BLTVA

# Number of plant species per BLH individual
a <- tapply(camille_2019$BLTVA, camille_2019$BLH, length)
a1 <- tapply(camille_2020$BLTVA, camille_2020$BLH, length)
a2 <- tapply(camille_2021$BLTVA, camille_2021$BLH, length)

# Infection status per BLH individual

b <- tapply(camille_2019$BLTVA, camille_2019$BLH, mean, na.rm = TRUE)
b1 <- tapply(camille_2020$BLTVA, camille_2020$BLH, mean, na.rm = TRUE)
b2 <- tapply(camille_2021$BLTVA, camille_2021$BLH, mean, na.rm = TRUE)

BLTVA <- data.frame(p_sp = c(a, a1, a2), infect = c(b, b1, b2))

model_TVA <- glm(infect ~ p_sp, data = BLTVA, family = binomial)
summary(model_TVA)

#BCTV

# Infection status per BLH individual

d <- tapply(camille_2019$BCTV, camille_2019$BLH, mean, na.rm = TRUE)
d1 <- tapply(camille_2020$BCTV, camille_2020$BLH, mean, na.rm = TRUE)
d2 <- tapply(camille_2021$BCTV, camille_2021$BLH, mean, na.rm = TRUE)

BCTV <- data.frame(p_sp = c(a, a1, a2), infect = c(d, d1, d2))

model_CTV <- glm(infect ~ p_sp, data = BCTV, family = binomial)
summary(model_CTV)

plot_model(model_CTV,
           type = "pred")

## infection decreases with species richness

prediction <- data.frame(p_sp = seq(1, 21, len = length(BCTV$infect)))

prediction$pred <- predict(model_CTV, newdata = prediction, type="response")

plot(BCTV$p_sp, BCTV$infect, xlab = "Number of plant species in gut", ylab = "Probability of infection", xlim = c(0, 25))
lines(prediction$p_sp, prediction$pred)

# There are some NA in very high plant richness individuals, which would be interesting to double-check

## Riley's comment:
## There are very few records of BLH with gut richness > 15, I wonder if these data 
## are driving the negative relationship. 

hist(BCTV$p_sp)

model_CTV_2 <- glm(infect ~ p_sp,
                   data = filter(BCTV, infect != "NaN" & p_sp < 15),
                   family = binomial)
summary(model_CTV_2)

plot_model(model_CTV_2,
           type = "pred")

## Nope, the result is still significant!

## I had to make the figure below to show all the data points to convince myself


BCTV %>% 
  filter(infect != "NaN") %>% 
  ggplot(aes(x = p_sp, y = infect)) +
  geom_jitter(height = .05) +
  geom_smooth(method = "glm",
              method.args = list(family = "binomial"),
              color = 'black') +
  theme_classic() +
  labs(x = "Gut richness",
       y = "Pr(BCTV infection)")

