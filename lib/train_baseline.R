###########################################################
### Train a classification model with training features ###
###########################################################




train <- function(features, labels, w=NULL, n.trees, shrinkage){
model <- gbm.fit(x=features,
                 y=labels,
<<<<<<< HEAD
                 distribution = "multinomial",    
=======
                 distribution = "multinomial",    #"bernoulli",   #"multinomial", #logistic regression for 0-1 outcomes
>>>>>>> 74c8781d4255a0ac6d050698836a514efaa48ffb
                 w=w,
                 n.trees=n.trees,
                 shrinkage=shrinkage,
                 verbose=F)
return(model)
}



