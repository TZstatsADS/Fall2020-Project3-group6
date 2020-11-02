###########################################################
### Train a classification model with training features ###
###########################################################

NB_train <- function(dat_train, weight=0){
  library(e1071)
  
  tm.train <- system.time(
      NB.fit<-naiveBayes(formula = label~.,data = data,type = "class")
      )
  return(
    list(tm.train,NB.fit)
  )
}

