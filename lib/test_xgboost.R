###########################################################
### Make predictions with test features ###
###########################################################

xgb_test = function(model, dat_test){
  
  test_mat <- xgb.DMatrix(data=as.matrix(dat_test[, -6007]), label=as.numeric(dat_test$label)-1)
  tm.test <-  system.time(pred_xgb <- predict(object = model, newdata = test_mat))
  return(list(pred_xgb,tm.test))
  
}

# This function is not necessary.
# We put it here just to show the structure.