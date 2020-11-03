###########################################################
### Train a classification model with training features ###
###########################################################

lda_train<-function(dat_train){
  library(MASS)
  tm.train <- system.time(
    lda.model <- lda(label ~ ., data=dat_train)
  )
  return(list(tm.train,lda.model))
}
