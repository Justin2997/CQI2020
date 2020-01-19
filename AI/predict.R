require(xgboost)
require(Matrix)
require(data.table)

evaluation <- read.csv("ForEvaluation.csv", header = FALSE)

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

colnames(evaluation) <- columns[1:18] 

bst <- xgb.load("CSI_2.model")

df_valid <- data.table(evaluation[-1] , keep.rownames = F)

sparse_matrix <- sparse.model.matrix(~ . , data = df_valid)

y_pred <- predict(bst, data.matrix(sparse_matrix))
y_pred_bool <- y_pred >= 0.5

answer <- cbind(as.character(evaluation[, "Identifier"]), tolower(as.character(y_pred_bool)))
colnames(answer) <- NULL

write.csv(answer, file = "evaluation_with_approbation.csv", row.names = FALSE, quote = FALSE)
