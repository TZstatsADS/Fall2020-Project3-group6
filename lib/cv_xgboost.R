########################
### Cross Validation ###
########################

### Author: Chengliang Tang
### Project 3


cv_xgb <- function(dat_train, K=5, para){
  
  set.seed(2020)
  n <- nrow(dat_train)
  n.fold <- round(n/K, 0)
  s <- sample(n) %% K + 1
  cv.error <- rep(NA, K)
  cv.AUC <- rep(NA, K)
  
  for (i in 1:K){
    
    train_data <- dat_train[s != i,]
    test_data <- dat_train[s == i,]
    test_label <-  as.numeric(dat_train[s == i,]$label)-1
    
    weight_test <- rep(NA, length(test_label))
    for (v in unique(test_label)){
      weight_test[test_label == v] = 0.5 * length(test_label) / length(test_label[test_label == v])
    }
    
    model <- xgb_train(train_data, para)[[1]]
    
    ## make predictions
    pred <- xgb_test(model, test_data)[[1]]
    pred <- ifelse(pred>0.5, 1, 0)
    cv.error[i] <- mean(pred != test_label)
    tpr.fpr <- WeightedROC(pred, test_label, weight_test)
    cv.AUC[i] <- WeightedAUC(tpr.fpr)
  }
  return(c(mean(cv.error),sd(cv.error), mean(cv.AUC), sd(cv.AUC)))
}
