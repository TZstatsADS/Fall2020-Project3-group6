if(!require("leaps")){
  install.packages("leaps")
}
if(!require("caret")){
  install.packages("caret")
}
if(!require("glmnet")){
  install.packages("glmnet")
}
if(!require("randomForest")){
  install.packages("randomForest")
}
if(!require("scales")){
  install.packages("scales")
}
if(!require("pROC")){
  install.packages("pROC")
}

library(leaps)
library(glmnet)
library(caret)
library(randomForest)
library(scales)
library(pROC)


#getwd()
setwd("~/Documents/GitHub/Fall2020-Project3-group6/lib/")
load("../output/feature_train.RData")
load("../output/feature_test.RData")

set.seed(2020)

dat_train_rescale <- as.data.frame(lapply(dat_train[,-6007], rescale))
dat_test_rescale <- as.data.frame(lapply(dat_test[,-6007], rescale))
dat_train_rescale <- cbind(dat_train_rescale, new_col = dat_train[,6007])
dat_test_rescale <- cbind(dat_test_rescale, new_col = dat_test$label)

#tail(colnames(dat_test_rescale))

# Random Forest-------------------------------------------------------------------------
rf_fit = randomForest(new_col~.,data=dat_train_rescale,importance = TRUE)
save(rf_fit, file="../output/rf_feature_scale.RData")

rf_feat <- as.data.frame(importance(rf_fit))
rf_names <- rownames(rf_feat[order(rf_feat$MeanDecreaseAccuracy), ])

yhat.rf = predict(rf_fit,newdata = dat_test_rescale[,-6007])
mean(yhat.rf == dat_test_rescale[,6007])

tpr.fpr <- roc(as.numeric(yhat.rf),as.numeric(dat_test_rescale[,6007]),plot=TRUE)
Auc <- auc(tpr.fpr)
Auc

# run time
rf_train_time <- system.time(randomForest(new_col~.,data=dat_train_rescale,importance = TRUE))
rf_train_time

rf_test_time <- system.time(predict(rf_fit,newdata = dat_test_rescale[,-6007]))
rf_test_time
