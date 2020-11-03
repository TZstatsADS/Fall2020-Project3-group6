###########################################################
### Train a classification model with training features ###
###########################################################

svm_train <- function(dat_train, ...){
  tm.train_svm <- system.time(svm.fit <- svm(label~., data = dat_train, ...))
  return(list(svm.fit, tm.train_svm))
}

