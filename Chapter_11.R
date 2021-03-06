# ����� 11. ���������� ��������������� ���������� ���� � ������� ������ H2O

# ������� ������ �������������

# 11.1.1 ���������� ������


# ������ ���������� CRAN �����������
cat(".Rprofile: Setting US repositoryn")
r = getOption("repos")
r["CRAN"] = "http://cran.us.r-project.org"
options(repos = r)
rm(r)


# ������������� ����� h2o
install.packages("h2o", repos=(c("http://s3.amazonaws.com/h2o-release/h2o/master/1497/R", getOption("repos"))))

# ������������� ��������� ����������� ������
install.packages("car")
install.packages("Rcpp")
install.packages("imputeTS")

# ��������� ����� h2o
library(h2o)
# ��������� �������������
h2o.init(nthreads=-1, max_mem_size = "8G")

# ��������� ������.
data <- read.csv2("C:/Trees/Credit.csv")

# ������� ���������� client_id.
data$client_id <-NULL

# ��������� ����������� �������������� ����������.
data$gender <-as.factor(data$gender)
data$marital_status <-as.factor(data$marital_status)
data$job_position <-as.factor(data$job_position)
data$education <-as.factor(data$education)
data$tariff_id <-as.factor(data$tariff_id)
data$living_region <-as.factor(data$living_region)
data$okrug <-as.factor(data$okrug)
data$open_account_flg <-as.factor(data$open_account_flg)

# �������� ������ ��������� � ��������� ������.
library(car)

data$job_position <- recode(data$job_position, 
                                   "c('5', '7','9', '12')='other'")
data$tariff_id <- recode(data$tariff_id, 
                                "c('14', '15', '16', '17', '24', '26', '27', '33')='other'")

# ��������� ����� ������ �� ��������� � ����������� �������.
set.seed(42)
data$random_number <- runif(nrow(data),0,1)
development <- data[which(data$random_number > 0.3), ]
holdout <- data[ which(data$random_number <= 0.3), ]
development$random_number <- NULL
holdout$random_number <- NULL
data$random_number <- NULL

# ��������� ��������� ���������.
library(imputeTS)

development$avregzarplata <- na.replace(development$avregzarplata, fill = -1)
development$credit_count <- na.replace(development$credit_count, fill = -1)
development$overdue_credit_count <- na.replace(development$overdue_credit_count, fill = -1)

holdout$avregzarplata <- na.replace(holdout$avregzarplata, fill = -1)
holdout$credit_count <- na.replace(holdout$credit_count, fill = -1)
holdout$overdue_credit_count <- na.replace(holdout$overdue_credit_count, fill = -1)

development$living_region <- as.integer(development$living_region)
development$living_region <- na.replace(development$living_region, fill = 82)
development$living_region <- as.factor(development$living_region)

holdout$living_region <- as.integer(holdout$living_region)
holdout$living_region <- na.replace(holdout$living_region, fill = 82)
holdout$living_region <- as.factor(holdout$living_region)

development$okrug <- as.integer(development$okrug)
development$okrug <- na.replace(development$okrug, fill = 9)
development$okrug <- as.factor(development$okrug)

holdout$okrug <- as.integer(holdout$okrug)
holdout$okrug <- na.replace(holdout$okrug, fill = 9)
holdout$okrug <- as.factor(holdout$okrug)

development$education <- as.integer(development$education)
development$education <- na.replace(development$education, fill = 4)
development$education <- as.factor(development$education)

holdout$education <- as.integer(holdout$education)
holdout$education <- na.replace(holdout$education, fill = 4)
holdout$education <- as.factor(holdout$education)

development$marital_status <- as.integer(development$marital_status)
development$marital_status <- na.replace(development$marital_status, fill = 3)
development$marital_status <- as.factor(development$marital_status)

holdout$marital_status <- as.integer(holdout$marital_status)
holdout$marital_status <- na.replace(holdout$marital_status, fill = 3)
holdout$marital_status <- as.factor(holdout$marital_status)

development$age <- na.replace(development$age, fill = 34)
holdout$age <- na.replace(holdout$age, fill = 34)

development$credit_sum <- na.replace(development$credit_sum, fill = 21228)
holdout$credit_sum <- na.replace(holdout$credit_sum, fill = 21228)

development$credit_month <- na.replace(development$credit_month, fill = 10)
holdout$credit_month <- na.replace(holdout$credit_month, fill = 10)

development$score_shk <- na.replace(development$score_shk, fill = 0.461679)
holdout$score_shk <- na.replace(holdout$score_shk, fill = 0.461679)

development$monthly_income <- na.replace(development$monthly_income, fill = 35000)
holdout$monthly_income <- na.replace(holdout$monthly_income, fill = 35000)

str(development)

str(holdout)

train <- as.h2o(development)
valid <- as.h2o(holdout)

str(train)


# 11.1.2 ���������� ������ � ������ � ������������

rf1 <- h2o.randomForest(         ## ������� h2o.randomForest
  training_frame = train,        ## ����� H2O ��� ��������
  validation_frame = valid,      ## ����� H2O ��� ��������
  model_id="RF_credit",          ## ������ ������������� ������
  x=1:15,                        ## ������� �����������, ������� ������� ��������
  y=16,                          ## ������ ��������� ����������
  ntrees = 600,                  ## ���������� 600 ��������,
                                 ## �� ��������� �������� 50 ��������
  seed = 1000000)                ## ������ ��������� ��������

summary(rf1)

rf1_pred <- h2o.predict(rf1, newdata = valid)

rf1_pred
h2o.exportFile(rf1_pred, path = "C:/Trees/predictions.csv", force=TRUE)

plot(h2o.performance(rf1))

plot(h2o.performance(rf1, valid=TRUE))

# 11.1.3 ���������� ������ � ���������� � ����� ������

path <- h2o.saveModel(rf1, path="C:\\Trees\\mybest_model", force=TRUE)
print(path)

m_loaded <- h2o.loadModel("C:\\Trees\\mybest_model\\RF_credit")

summary(m_loaded)

# ��������� ����� ������.
newclients <- read.csv2("C:/Trees/Credit_new.csv")

# ������� ���������� client_id.
newclients$client_id <-NULL

# ��������� ����������� �������������� ����������.
newclients$gender <-as.factor(newclients$gender)
newclients$marital_status <-as.factor(newclients$marital_status)
newclients$job_position <-as.factor(newclients$job_position)
newclients$education <-as.factor(newclients$education)
newclients$tariff_id <-as.factor(newclients$tariff_id)
newclients$living_region <-as.factor(newclients$living_region)
newclients$okrug <-as.factor(newclients$okrug)

# �������� ������ ��������� � ��������� ������.
newclients$job_position <- recode(newclients$job_position, 
                                   "c('5', '7','9', '12')='other'")
newclients$tariff_id <- recode(newclients$tariff_id, 
                                "c('14', '15', '16', '17', '24', '26', '27', '33')='other'")

# ��������� ��������� ���������.
library(imputeTS)

newclients$avregzarplata <- na.replace(newclients$avregzarplata, fill = -1)
newclients$credit_count <- na.replace(newclients$credit_count, fill = -1)
newclients$overdue_credit_count <- na.replace(newclients$overdue_credit_count, fill = -1)

newclients$living_region <- as.integer(newclients$living_region)
newclients$living_region <- na.replace(newclients$living_region, fill = 82)
newclients$living_region <- as.factor(newclients$living_region)

newclients$okrug <- as.integer(newclients$okrug)
newclients$okrug <- na.replace(newclients$okrug, fill = 9)
newclients$okrug <- as.factor(newclients$okrug)

newclients$education <- as.integer(newclients$education)
newclients$education <- na.replace(newclients$education, fill = 4)
newclients$education <- as.factor(newclients$education)

newclients$marital_status <- as.integer(newclients$marital_status)
newclients$marital_status <- na.replace(newclients$marital_status, fill = 3)
newclients$marital_status <- as.factor(newclients$marital_status)

newclients$age <- na.replace(newclients$age, fill = 34)
newclients$credit_sum <- na.replace(newclients$credit_sum, fill = 21228)
newclients$credit_month <- na.replace(newclients$credit_month, fill = 10)
newclients$score_shk <- na.replace(newclients$score_shk, fill = 0.461679)
newclients$monthly_income <- na.replace(newclients$monthly_income, fill = 35000)

# ��������������� ��������� R �� ����� H2O.
newclients <- as.h2o(newclients)

# �������� �������� ��� ����� ������
new_pred <- h2o.predict(m_loaded, newdata = newclients)

# 11.1.4 ����� ����������� �������� ���������� � ������� ����������� ������

# ��������� ���������� �����
grid <- h2o.grid(x=c(1:15), y=16, training_frame=train, validation_frame=valid,
                 algorithm="drf", grid_id="results_grid",
                 hyper_params = list(ntrees=c(600, 700, 800), max_depth = c(14, 16, 18)), 
                 stopping_metric="AUC", seed=10000)

# ������� ���������� ����������� ������
summary(grid)

# ����������� ���������� ������ � ������� �������� AUC
sortedGrid <- h2o.getGrid("results_grid", sort_by = "auc", decreasing = TRUE)
sortedGrid

# ��������� ������.
data <- read.csv2("C:/Trees/Response.csv")

# ��������� ����������� ��������������.
data$mortgage <-as.factor(data$mortgage)
data$life_ins <-as.factor(data$life_ins)
data$cre_card <-as.factor(data$cre_card)
data$deb_card <-as.factor(data$deb_card)
data$mob_bank <-as.factor(data$mob_bank)
data$curr_acc <-as.factor(data$curr_acc)
data$internet <-as.factor(data$internet)
data$perloan <-as.factor(data$perloan)
data$savings <-as.factor(data$savings)
data$atm_user <-as.factor(data$atm_user)
data$markpl <-as.factor(data$markpl)
data$response <-as.factor(data$response)

# ����������� ��������� R �� ����� H2O.
frame <- as.h2o(data)

# ��������� ����� �� ���������, ����������� � �������� �������.
splits <- h2o.splitFrame(data=frame, ratios=c(0.7, 0.15), seed=10000)
	tr <- splits[[1]]
	val <- splits[[2]]
	test <- splits[[3]]

# ��������� ���������� �����
grid2 <- h2o.grid(x=c(1:13), y=14, training_frame=tr, validation_frame=val,
                 algorithm="drf", ntrees=300, grid_id="results_grid2",
                 hyper_params = list(mtries=c(3:6), max_depth=c(10, 12, 14, 16)), 
                 stopping_metric="AUC", seed=10000)

sortedGrid2 <- h2o.getGrid("results_grid2", sort_by = "auc", decreasing = TRUE)
sortedGrid2

best_model_id <- sortedGrid2@model_ids[[1]]
best_model <- h2o.getModel(best_model_id)

best_model

best_perf <- h2o.performance(model = best_model, newdata = test)
h2o.auc(best_perf)

data <- read.csv2("C:/Trees/Bankloan.csv")

data$ed <-as.factor(data$ed)
data$default <-as.factor(data$default)

set.seed(42)
data$random_number <- runif(nrow(data),0,1)
development <- data[which(data$random_number > 0.3), ]
holdout <- data[ which(data$random_number <= 0.3), ]
development$random_number <- NULL
holdout$random_number <- NULL

training <- as.h2o(development)
validation <- as.h2o(holdout)

grid3 <- h2o.grid(x=c(1:8), y=9, training_frame=training, validation_frame=validation,
                 nfolds=10, keep_cross_validation_predictions=TRUE,
                 algorithm="drf", ntrees=300, grid_id="results_grid3",
                 hyper_params=list(mtries=c(3:5), max_depth=c(10, 12, 14, 16)), 
                 stopping_metric="AUC", seed=10000)

sortedGrid3 <- h2o.getGrid("results_grid3", sort_by = "auc", decreasing = TRUE)

sortedGrid3

optimal_model_id <- sortedGrid3@model_ids[[1]]
optimal_model <- h2o.getModel(optimal_model_id)

optimal_model

# 11.2 ������� ������ ���������

# ��������� ������.
data <- read.csv2("C:/Trees/Response.csv")

# ��������� ����������� ��������������.
data$mortgage <-as.factor(data$mortgage)
data$life_ins <-as.factor(data$life_ins)
data$cre_card <-as.factor(data$cre_card)
data$deb_card <-as.factor(data$deb_card)
data$mob_bank <-as.factor(data$mob_bank)
data$curr_acc <-as.factor(data$curr_acc)
data$internet <-as.factor(data$internet)
data$perloan <-as.factor(data$perloan)
data$savings <-as.factor(data$savings)
data$atm_user <-as.factor(data$atm_user)
data$markpl <-as.factor(data$markpl)
data$response <-as.factor(data$response)

# ��������� ����� ������ �� ��������� � ����������� �������.
set.seed(42)
data$random_number <- runif(nrow(data),0,1)
development <- data[which(data$random_number > 0.3), ]
holdout <- data[ which(data$random_number <= 0.3), ]
development$random_number <- NULL
holdout$random_number <- NULL
data$random_number <- NULL

# ������� ������, ����� ������ ����� ������ ����� ��������� ���������� cus_leng.
str(development)

# ��� �������� ��������� ���������� response � ������ ����������, �����
# ��������� ���������� cus_leng ����� ���������.
development<-development[,c(which(colnames(development)=="response"),
which(colnames(development)!="response"))]
holdout<-holdout[,c(which(colnames(holdout)=="response"),
which(colnames(holdout)!="response"))]

# ��������������� ���������� R �� ������ H2O.
train <- as.h2o(development)
valid <- as.h2o(holdout)

rf2 <- h2o.randomForest(x=c(1:13), y=14, training_frame = train, 
                        validation_frame = valid, ntrees=600, 
                        score_tree_interval=100, seed=1000000) 

summary(rf2)


