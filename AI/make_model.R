  library(xgboost)
  library(Matrix)
  library(data.table)
  library(vcd)
  
  set.seed(100)
  
  trainingData <- read.csv("TrainingData.csv", header = FALSE)
  evaluation <- read.csv("ForEvaluation.csv", header = FALSE)
  
  trainingData <- trainingData[sample(nrow(trainingData)), ]
  
  train_limit <- 0.8*nrow(trainingData)
  
  columns <- c("Identifier",
              "Age", 
              "CurrentResidenceYears", 
              "isMarried", 
              "NumberOfDependants", 
              "Graduated",
              "SelfEmployed",
              "YearsOfJobStability",
              "YearlySalary",
              "CreditRating",
              "CoApplicantAge",
              "CoApplicantYearsOfJobStability",
              "CoApplicantYearlySalary",
              "CoApplicantCreditRating",
              "LoanTermInYears",
              "LoanAmount",
              "PropertyTotalCost",
              "AreaClassification",
              "Approved")
  
  boolColumns <- c("isMarried", "Graduated", "SelfEmployed")
  notIntColumns <- c("CreditRating", "CoApplicantCreditRating", "AreaClassification")
  
  colnames(trainingData) <- columns
  colnames(evaluation) <- columns[1:18] 
  
  df_train <- trainingData[1:train_limit , -1]
  df_test <- trainingData[(train_limit + 1):nrow(trainingData) , -1]
  
  train_labels <- df_train[, "Approved"]
  test_labels <- df_test[, "Approved"]
  
  df <- data.table(df_train , keep.rownames = F)
  levels(df[, AreaClassification])
  
  sparse_matrix <- sparse.model.matrix(Approved ~ ., data = df)[,-1]
  head(sparse_matrix)
  
  output_vector = df[,Approved] == "true"
  
  # for(i in 1:100) {
  #   xgb.cv(data = sparse_matrix, label = output_vector,  nrounds = 3, nthread = 2, nfold = 5, metrics = list("rmse","auc"),
  #         max_depth = 3, eta = 1, objective = "binary:logistic")
  # }
  
  bst <- xgboost(data = sparse_matrix, label = output_vector, max_depth = 9, subsample = 0.7, early_stopping_rounds = 50,
                 eta = 0.3, nthread = 10, nrounds = 1000, colsample_bytree = 0.3, min_child_weigth = 1, scale_pos_weight = 1,
                 objective = "binary:logistic")#, verbose = 0)
  
  importance <- xgb.importance(feature_names = colnames(sparse_matrix), model = bst)
  head(importance)
  
  importanceRaw <- xgb.importance(feature_names = colnames(sparse_matrix), model = bst, data = sparse_matrix, label = output_vector)
  
  importanceClean <- importanceRaw[,`:=`(Cover=NULL, Frequency=NULL)]
  
  head(importanceClean)
  
  xgb.plot.importance(importance_matrix = importance)
  
  
  df_test <- data.table(df_test , keep.rownames = F)

  sparse_matrix <- sparse.model.matrix(Approved ~ ., data = df_test)[,-1]

  output_vector = df_test[,Approved] == "true"
  y_pred <- predict(bst, data.matrix(sparse_matrix))
  y_pred_bool <- y_pred >= 0.5

  total <- sum(y_pred_bool == output_vector)

  good_class <- total / nrow(df_test) * 100

  print(good_class)

  xgb.save(bst, "CSI.model")
  
  
  ## Predict the 1000 and add to csv
  
  
  df_valid <- data.table(evaluation[-1] , keep.rownames = F)
  
  sparse_matrix <- sparse.model.matrix(~ . , data = df_valid)

  y_pred <- predict(bst, data.matrix(sparse_matrix))
  y_pred_bool <- y_pred >= 0.5
  
  answer <- cbind(evaluation, y_pred_bool)
  colnames(answer) <- NULL
  
  write.csv(answer, file = "evaluation_with_approbation.csv", )
