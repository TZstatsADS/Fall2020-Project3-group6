###########################################################
### Train a classification model with training features ###
###########################################################

xgb_train <- function(dat_train, para){
  
  train_mat <- xgb.DMatrix(data=as.matrix(dat_train[, -6007]), label=as.numeric(dat_train$label)-1)
  tm.train_xgb <- system.time(xgb.fit <- xgb.train(data = train_mat, params=para, nrounds=300))
  return(list(xgb.fit, tm.train_xgb))
}

