###########################################################
### Train a classification model with training features ###
###########################################################




train <- function(features, labels, w=NULL, n.trees, shrinkage){
model <- gbm.fit(x=features,
                 y=labels,
                 distribution = "multinomial",    
                 w=w,
                 n.trees=n.trees,
                 shrinkage=shrinkage,
                 verbose=F)
return(model)
}



