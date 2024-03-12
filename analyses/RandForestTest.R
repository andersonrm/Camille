head(iris)

library(tidyverse)
library(rpart)

tree.model <- rpart(Species ~ Sepal.Length + Sepal.Width +
        Petal.Length + Petal.Width, data = iris)

tree.model

plot(tree.model)
text(tree.model)


plot(iris$Petal.Length, col = c("red", "blue", "forestgreen")[iris$Species], xlab = "", ylab = "Petal Length (cm)")
legend(120, 2, c("setosa","versicolor","virginica"), col = c("red", "blue", "forestgreen"), pch = 1)
abline(h = 2.45)

printcp(tree.model)


tree.model.updated <- update(tree.model,
                             control = rpart.control(minsplit = 2))

printcp(tree.model.updated)


library(party)
library(randomForest)
library(caret)

ctree.model <- ctree(Species ~ Sepal.Length + Sepal.Width +
                       Petal.Length + Petal.Width, data = iris)

plot(ctree.model)



RF.model = randomForest(Species ~ Sepal.Length +
                          Sepal.Width + Petal.Length +
                          Petal.Width, data = iris)
RF.model
update(RF.model, ntrees = 300)

train(Species ~ Sepal.Length + Sepal.Width +
        Petal.Length + Petal.Width,
      data = iris, method = "rf")

update(RF.model, mtry = 3)

importance(RF.model)

