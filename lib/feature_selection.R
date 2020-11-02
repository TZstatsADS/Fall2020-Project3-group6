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


library(leaps)
library(glmnet)
library(caret)
library(randomForest)

#getwd()
#setwd("~/Documents/GitHub/Fall2020-Project3-group6/lib/")
load("../output/feature_train.RData")

# Best Subset Selection----------------------------------------------------------------
# best_fit <- regsubsets(label ~ ., data = dat_train)

# Forward Stepwise Selection-------------------------------------------------------------------------
forward_fit <- regsubsets(label ~ ., data = dat_train, method = "forward",nvmax= (ncol(dat_train)-1))
forward_summ = summary(forward_fit)
best.size = which.max(forward_summ$adjr2)
forward_feature = forward_summ$which[best.size,][forward_summ$which[best.size,] == TRUE][-1]
forward_feature = names(forward_feature)
length(forward_feature)
save(forward_feature, file="../output/forward_feature.RData")
load("../output/forward_feature.RData")

# Backward Stepwise Selection-------------------------------------------------------------------------
# backward_fit <- regsubsets(label ~ ., data = dat_train, method = "backward",nvmax= (ncol(dat_train)-1))
# backward_summ = summary(backward_fit)
# best.size = which.max(backward_fit$adjr2)
# backward_feature = backward_fit$which[best.size,][backward_fit$which[best.size,] == TRUE][-1]
# backward_feature
# save(names(backward_feature), file="../output/backward_feature.RData")


# Lasso-------------------------------------------------------------------------
grid=c(0,10^(-3:3))
x = model.matrix(label~.,dat_train)
y = dat_train$label
weight_train <- rep(NA, length(y))
for (v in unique(y)){
  weight_train[y == v] = 0.5 * length(y) / length(y[y == v])
}
cv.out = cv.glmnet(x[,-1], y, alpha=1, type.measure = "class",
                   lambda=grid,nfolds=5,family="binomial", weights = weight_train) 
bestlam=cv.out$lambda.min
bestlam
lasso.mod=glmnet(x[,-1], y, alpha=1, lambda=bestlam,family="binomial")
lasso_feature = as.matrix(coef(lasso.mod))
length(lasso_feature[lasso_feature != 0])
save(lasso_feature, file="../output/lasso_feature.RData")

# PCA-------------------------------------------------------------------------
pca <- preProcess(x=dat_train,method="pca",thresh=0.95)
pca_feature <- predict(pca,dat_train[,-6007])
save(pca_feature, file="../output/pca_feature.RData")

# Random Forest-------------------------------------------------------------------------
rf_fit = randomForest(label~.,data=dat_train,importance = TRUE)
save(rf_fit, file="../output/rf_feature.RData")

# not sure 
rf_feat <- as.data.frame(importance(rf_fit))
rf_names <- rownames(rf_feat[order(rf_feat$MeanDecreaseAccuracy), ])[1:length(forward_feature)]

yhat.rf = predict(rf_fit,newdata = dat_test)
mean(yhat.rf == dat_test$label)


