#Read file
data <- read.csv(file = "C:/Users/marol/Documents/KDD/KDD project/SharkAttack_Balanced.csv")

#Creation of subset for continuous variables
subset1 <- subset(data, select = c(Sal,DRYBULBTEMPF,Turb,WindSpeed,WindDirection,SeaLevelPressure,Attack..Y.N.))

#Model using glm function - testing for various combinations
model <- glm(formula = Attack..Y.N. ~ Sal+DRYBULBTEMPF+Turb+WindSpeed+WindDirection+SeaLevelPressure, data = subset1, family = "binomial")
summary(model)

library(ROCR)
data1 <- read.csv(file = "C:/Users/marol/Documents/KDD/KDD project/SharkAttackTesting.csv")
newdata <- data.frame(Sal=data1$Sal,DRYBULBTEMPF=data1$DRYBULBTEMPF,Turb=data1$Turb,WindSpeed=data1$WindSpeed,WindDirection=data1$WindDirection,SeaLevelPressure=data1$SeaLevelPressure)
newdata$probability <- predict(model,newdata,type="response")
write.csv(newdata,"C:/Users/marol/Documents/KDD/KDD project/logisticRegression_Probability.csv")
#ROC and Area under curve
p <- predict(model,newdata,type="response")
pr <- prediction(p, data1$Attack..Y.N.)
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)
auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc
