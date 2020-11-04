###########################################################
### Make predictions with test features ###
###########################################################

test_lda <- function(model, dat_test){
  
  ### Input: 
  ###  - the fitted lda model using training data
  ###  - processed features from testing images 
  ### Output: training model specification, test time
  
  ### load libraries
  library("MASS")
  ### make predictions
  tm.test <- system.time(
    pred_lda <- predict(model, dat_test)
    )
  return(list(tm.test,pred_lda))
}

# For model performance evaluation
# runtime<-test_lda(lda_train(pca_feature_train)[2],pca_feature_test[-1])[1] # running time
# lda.modelaaaaa <- lda(label ~ ., data=pca_feature_train)
# pred_ldaaaa <- predict(lda.modelaaaaa, pca_feature_test[-1])
# accu <- mean(dat_test$label == pred_ldaaaa$class) # Accuracy
# library(pROC)
# roc1 <- roc(as.integer(dat_test$label), as.integer(pred_ldaaaa$class))
# auc(roc1) # Get the full AUC