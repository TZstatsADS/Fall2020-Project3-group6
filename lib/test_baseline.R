###########################################################
### Make predictions with test features ###
###########################################################

test_baseline <- function(model, features,n.trees,shrinkage,pred.type){
  res <- predict(model, newdata = data.frame(features),n.trees,shrinkage,type=pred.type)
  pred=apply(res,1,which.max)
  #return(res)
  return(pred)
}

# This function is not necessary.
# We put it here just to show the structure.