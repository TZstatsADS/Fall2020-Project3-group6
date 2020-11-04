###########################################################
### Train a classification model with training features ###
###########################################################

xgb_train <- function(dat_train, para){
  
  weight <- sum(dat_train$label==0)/sum(dat_train$label==1)
  
  train_mat <- xgb.DMatrix(data=as.matrix(dat_train[, -which(colnames(dat_train) %in% c('label'))]), 
                           label=as.numeric(dat_train$label)-1)
  tm.train_xgb <- system.time(xgb.fit <- xgb.train(data = train_mat, params=para, 
                                                   scale_pos_weight=weight, nrounds=300))
  return(list(xgb.fit, tm.train_xgb))
}

