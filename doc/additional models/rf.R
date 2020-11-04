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
rf_train_time <- system.time(rf_fit <- randomForest(new_col~.,data=dat_train_rescale,importance = TRUE))
save(rf_fit, file="../output/rf_feature_scale.RData")
load(file="../output/rf_feature_scale.RData")

rf_feat <- as.data.frame(importance(rf_fit))
rf_names <- rownames(rf_feat[order(rf_feat$MeanDecreaseAccuracy), ])

rf_test_time <- system.time(yhat.rf <- predict(rf_fit,newdata = dat_test_rescale[,-6007]))
mean(yhat.rf == dat_test_rescale[,6007])

tpr.fpr <- roc(as.numeric(yhat.rf)-1,as.numeric(dat_test_rescale[,6007])-1,plot=TRUE)
Auc <- auc(tpr.fpr)
Auc

# run time
rf_train_time
rf_test_time

# Random Forest with Forward Stepwise Selection------------------------------------
load("../output/forward_feature_scale.RData")
feature_selected = colnames(data_forward_scale)
data_forward_scale  = cbind(data_forward_scale, new_col = dat_train[,6007])
rf_train_time <- system.time(rf_fit <- randomForest(new_col~.,data=data_forward_scale,importance = TRUE))

rf_test_time <- system.time(yhat.rf <- predict(rf_fit,newdata = dat_test_rescale[,feature_selected]))
mean(yhat.rf == dat_test_rescale[,6007])

tpr.fpr <- roc(as.numeric(yhat.rf)-1,as.numeric(dat_test_rescale[,6007])-1,plot=TRUE)
Auc <- auc(tpr.fpr)

Auc
rf_train_time
rf_test_time

# Random Forest with PCA------------------------------------
load("../output/pca_feature_train.RData")
load("../output/pca_feature_test.RData")
rf_train_time <- system.time(rf_fit <- randomForest(label~.,data=pca_feature_train,importance = TRUE))

rf_test_time <- system.time(yhat.rf <- predict(rf_fit,newdata = pca_feature_test[,-1]))
mean(yhat.rf == pca_feature_test[,1])

tpr.fpr <- roc(as.numeric(yhat.rf)-1,as.numeric(pca_feature_test[,1])-1,plot=TRUE)
Auc <- auc(tpr.fpr)

Auc
rf_train_time
rf_test_time

# Random Forest with Lasso------------------------------------
load("../output/fit_train.RData")
a = as.matrix(coef(fit_train))
selected_feature = rownames(coef(fit_train) != 0.0)[coef(fit_train)[,1]!= 0][-1]
data_lasso  = dat_train_rescale[,selected_feature]
data_lasso$label=  dat_train[,6007]

data_lasso_test  = dat_test_rescale[,selected_feature]
data_lasso_test$label=  dat_test[,6007]

rf_train_time <- system.time(rf_fit <- randomForest(label~.,data=data_lasso,importance = TRUE))
-which(colnames(data_lasso_test) %in% c('label'))
rf_test_time <- system.time(yhat.rf <- predict(rf_fit,newdata = data_lasso_test[,-which(colnames(data_lasso_test) %in% c('label'))]))
mean(yhat.rf == data_lasso_test[,which(colnames(data_lasso_test) %in% c('label'))])

tpr.fpr <- roc(as.numeric(yhat.rf)-1,as.numeric(data_lasso_test[,1])-1,plot=TRUE)
Auc <- auc(tpr.fpr)

Auc
rf_train_time
rf_test_time



