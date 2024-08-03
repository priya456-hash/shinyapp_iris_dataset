data("iris")

head(iris)

#set a seed to make randomness reproducible 
set.seed(42)

#randomly sample 100 of 150 rows indexes
indexes <- sample(
  x = 1:150,
  size =100)

#inspect the random indexes 
print(indexes)

#create training set from indexes
train <- iris[indexes,]
print(train)

#create test from remaining indexes 
test <- iris[-indexes, ]
test

#load decision tree package 
library(tree)

#train a decision model 
model <- tree(
  formula = Species ~ Petal.Length + Petal.Width,
  data = train)

#inspect the model
summary(model)

#Visualize the tree model
plot(model)
text(model)

#load color brewer library for making color blind friendly plot
library(RColorBrewer)

#create a color palette 
color_palette <- brewer.pal(3, "Set2")

#create scatterplot colored by species
plot(
  x = iris$Petal.Length,
  y = iris$Petal.Width,
  pch = 19, 
  col = color_palette[as.numeric(iris$Species)],
  main = "Iris Petal Length vs width",
  xlab = "Petal Length(cm)",
  ylab = "Petal Width (cm)")

#plot decision boundary 
partition.tree(
  tree = model, 
  label = "Species",
  add = TRUE )

#predict with the model
predictions <- predict(
  object = model,
  newdata = test,
  type = "class"
)

#create a confusion matrix
table.matrix <- table(
  x = predictions,
  y = test$Species
)
table.matrix

#install required packages 
library(caret)
library(recipes)
#Evaluate the prediction results
cm <- confusionMatrix(
  data = predictions,
  reference = test$Species)
cm


#save the tree model
save(model, file = "Tree.RData")

#save the training data 
save(train, file = "Train.RData")
