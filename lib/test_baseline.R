###########################################################
### Make predictions with test features ###
###########################################################

test <- function(model, features,n.trees,shrinkage,pred.type){
  res <- predict(model, newdata = data.frame(features),n.trees,shrinkage,type=pred.type)
  pred=apply(res,1,which.max)
  #return(res)
  return(pred)
}

# This function is not necessary.
<<<<<<< HEAD
# We put it here just to show the structure.
=======
# We put it here just to show the structure.
>>>>>>> 74c8781d4255a0ac6d050698836a514efaa48ffb
