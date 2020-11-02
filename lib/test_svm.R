###########################################################
### Make predictions with test features ###
###########################################################

svm_test = function(model, dat_test){
  
  tm.test = system.time(pred_svm <- predict(object = model, newdata = dat_test))
  return(list(pred_svm,tm.test))
  
}

# This function is not necessary.
# We put it here just to show the structure.