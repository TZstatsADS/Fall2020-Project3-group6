###########################################################
### Train a classification model with training features ###
###########################################################

svm_train <- function(dat_train, ...){
  
  weight0 <- nrow(dat_train)/sum(dat_train$label==0)
  weight1 <- nrow(dat_train)/sum(dat_train$label==1)
  
  tm.train_svm <- system.time(svm.fit <- svm(label~., data = dat_train, 
                                             class.weights=c('0'=weight0, '1'=weight1),...))
  return(list(svm.fit, tm.train_svm))
}

