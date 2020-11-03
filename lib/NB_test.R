###########################################################
### Make predictions with test features ###
###########################################################

NB_test = function(model, dat_test){
  ### Input: 
  ###  - the fitted NB model using training data
  ###  - processed features from testing images 
  ### Output: training model specification
  
  ### load libraries
  library(e1071)
  ### make predictions
  tm.test <- system.time(
    NB_pred <- predict(model, dat_test)
  )
  return(list(tm.test,NB_pred))
  
}

# This function is not necessary.
# We put it here just to show the structure.