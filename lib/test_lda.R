###########################################################
### Make predictions with test features ###
###########################################################

test_lda <- function(model, dat_test){
  
  ### Input: 
  ###  - the fitted lda model using training data
  ###  - processed features from testing images 
  ### Output: training model specification
  
  ### load libraries
  library("MASS")
  ### make predictions
  tm.test <- system.time(
    pred_lda <- predict(model, dat_test)
    )
  return(list(tm.test,pred_lda))
}
