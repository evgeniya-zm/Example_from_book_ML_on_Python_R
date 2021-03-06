# ��������������� ��������

# ������ ���������� CRAN �����������
cat(".Rprofile: Setting US repositoryn")
r = getOption("repos")
r["CRAN"] = "http://cran.us.r-project.org"
options(repos = r)
rm(r)

# ������������� ����� xlsx
install.packages("xlsx")

# ������������� ����� openxlsx
install.packages("openxlsx")

# ������������� ����� Hmisc
install.packages("Hmisc")

# ������������� ����� imputeMissings
install.packages("imputeMissings")

# ������������� ����� imputeTS
install.packages("imputeTS")

# ������������� ����� dplyr
install.packages("dplyr")

# ������������� ����� memisc
install.packages("memisc")

# ������������� ����� rattle
install.packages("rattle")

# ������������� ����� data.table
install.packages("data.table")

# ������������� ����� anytime
install.packages("anytime")

# ������������� ����� stringr
install.packages("stringr")

# 1. �������� ���������� �� ����� Excel � CSV �����

# 1.1 ������� ��������� �� ����� Excel (������ ������)

# �� ��������� ������ java.lang.OutOfMemoryError: GC overhead limit exceeded
# ����������� ������ ��������� ����������� ������ (8 ��) ����� ��������� 
# ������ rJava, ������� ����������� ��� ����������� ������ xlsx
options(java.parameters = "-Xmx8192m")

# ��������� ����� xlsx
library(xlsx)

# ��������� ������, ������ ������ ������� �������� �����
data <- read.xlsx2("C:/Trees/Credit.xlsx", sheetIndex=1)
head(data)

# 1.2 ������� ��������� �� ����� Excel (������ ������)

# ��������� ����� openxlsx
library("openxlsx")

# ��������� ������, ������ ������ ������� �������� �����
data_xls <- read.xlsx("C:/Trees/Credit.xlsx", sheet=1)
head(data_xls)

# ����������� ����� openxlsx
detach("package:openxlsx", unload=TRUE)

# 1.3 ������� ��������� �� CSV �����, � ������� ������������ ��������� � �������� ��������� ������� � �������

data2 <- read.csv2("C:/Trees/Example_semicolon.csv", sep = ';')
head(data2)

# 1.4 ������� ��������� �� CSV �����, � ������� ������������ ��������� � �������� ��������� ��������

data3 <- read.csv2("C:/Trees/Example_comma.csv", sep = ',')
head(data3)

# 2. ������ ���������� � CSV ���� � ���� Excel

# 2.1 ���������� �� ������ ���������� CSV ����, � ������� �������� ��������� �������� (������ ������)

# ���������� CSV ����, �� ��������� � ����� ����� 
# ��������� �������������� ������� ID
write.csv(data3, "C:/Trees/Example_from_R_to_csv_comma.csv")

# 2.2 ���������� �� ������ ���������� CSV ����, � ������� �������� ��������� �������� (������ ������)

# ���������� CSV ����, �� ��������� ��������� �������������� ������� ID, 
# � ��� ��� ���� ����������������� ���������� client_id, ������� 
# � ������� ��������� row.names=FALSE �������� �������� ������� ID
write.table(data3, file="C:/Trees/Example_from_R_to_csv_comma2.csv", 
                        row.names=FALSE, sep=",")

# 2.3 ���������� �� ������ ���������� CSV ����, � ������� �������� ��������� ������� � ��������

# ���������� CSV ����, �� ��������� ��������� �������������� ������� ID, 
# � ��� ��� ���� ����������������� ���������� client_id, ������� 
# � ������� ��������� row.names=FALSE �������� �������� ������� ID  
write.table(data3, file="C:/Trees/Example_from_R_to_csv_semicolon.csv",       
            row.names=FALSE, sep=";")

# 2.4 ���������� �� ������ ���������� ���� Excel

# ���������� ���� Excel, �� ��������� ��������� �������������� ������� ID, 
# � ��� ��� ���� ����������������� ���������� client_id, ������� 
# � ������� ��������� row.names=FALSE �������� �������� ������� ID  
write.xlsx2(data3, "C:/Trees/Example_from_R_to_xlsx.xlsx", row.names=FALSE)

# 3. ����� �������� � �����������

# 3.1. ����� ����� ���������� � ����������

# ������� ����� ���������� � ����������
str(data3)

# ������� ������ 6 ����������
head(data3)

# ������� ������ 10 ����������
head(data3, 10)

# ������� ��������� 6 ����������
tail(data3)

# ������� ��������� 10 ����������
head(data3, 10)

# 3.2. ����� ������������ �������� � �����

# ��������� � 4-�� ���������� � ���������� age, ������� ����������� �������� �������, 
# ����� ����������� ����� ������
data3$age[4]

# �������� ������� age � marital_status � ���������� � ��������� example
example <- data3[,c("age","marital_status")]
head(example, 10)

# ��� ��� ����� ���
example=data3[,c("age","marital_status")]

# �������� ������ 5
data3[c(5),]

# �������� ������ 10 ����� � �������� age � marital_status
data3[1:10,c("age","marital_status")]

# �������� ����������, � �������� ������� ����������� ������� credit
# � ���������� � ��������� example
example <- data3[grepl("credit", names(data3))]
head(example, 10)

# 3.3. ���������� ����������

# ��������� ���������� �� ����������� �������� ���������� age 
# � ���������� � ��������� example
example <- data3[order(data3$age),]
head(example, 10)

# ��������� ���������� �� �������� �������� ���������� age 
# � ���������� � ��������� example
example <- data3[order(-data3$age),]
head(example, 10)

# 4. �������� � �����������

# 4.1. ��������� ����� ����������

# ������� ����� ���������� � ����������
str(data3)

# �������������� ���������� tariff_id � open_account_flg, 
# � ������� ����������� �������� � ���������, ����������� �������� ���
# ��� int (�������� � ����� �����), ������� ����������� �� � ��� factor 
# (�������� � ������ ����������� ����������) � ������� ������� as.factor
data3$tariff_id <-as.factor(data3$tariff_id)
data3$open_account_flg <-as.factor(data3$open_account_flg)
str(data3)

# �������������� ���������� credit_sum, score_shk, � ������� ����������� 
# �������� � ����� � ��������� ������, ����������� �������� ��� ��� factor, 
# ������� ����������� �� � ��� numeric (�������� � ����� � ��������� ������)
# � ������� ������� as.numeric.factor, �������������� ������� �� 
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
data3$credit_sum <-as.numeric.factor(data3$credit_sum)
data3$score_shk <-as.numeric.factor(data3$score_shk)
str(data3)

# ������ �������������� ���������� tariff_id ����� ������������� ��� 
# ��������������, ����������� �� � ��� integer (�������� � ����� �����)
# � ������� ������� as.integer 
data3$tariff_id <-as.integer(data3$tariff_id)
str(data3)

# ����������� ���������� tariff_id ������� � ��� factor
data3$tariff_id <-as.factor(data3$tariff_id)

# ����������, ��� ���������� education �������� ����������, ����� �� ������
# ������������� �� � ��� ordered factor (�������� � ������ ���������� ����������)
# � ������� ������� ordered 
data3$education2 <- ordered(data3$education, 
                           levels = c("SCH", "UGR", "GRD", "PGR", "ACD"))
str(data3)

# ������ ��������� ���������� education2
data3$education2 <-NULL

# 4.2 ��������� ����������� ��������

# 4.2.1. ��������� ���������� � ���������� ��������� �� ������ ����������

# ������ ����� ������� �� ���� ��������� ����������
str(data3) 

# ���� ��� ���������� ����� ���� integer ��� numeric, ����� ������� 
# ���������� � ���������� ���������, ���� ���� ���������� ���� factor,
# �� ����� ���� ������ ��������� ��������, ������� ����� ������� ����������
# � ���������� ��������� ����� �������� ��� ����������� (NA)
is.na(data3) <- data3==''

# ��������� ����� Hmisc
library(Hmisc)

# � ������� ������� describe ������ Hmisc ������� ����� ���������� 
# � ����������, � �.�. � � ���������� ��������� 
describe(data3)

# ����������� ����� Hmisc
detach("package:Hmisc", unload=TRUE)

# ����� ������� ������ �� ��������� � ������� ������� sapply
sapply(data3, function(x) sum(is.na(x)))

# 4.2.2. ��������� �������, �������� � ����� 

# �������� �������� � ���������� age � score_shk �������� ����������
data3$age[is.na(data3$age)] <- mean(data3$age, na.rm=TRUE)
data3$score_shk[is.na(data3$score_shk)] <- mean(data3$score_shk, na.rm=TRUE)
 
# �������� �������� � ���������� monthly_income � credit_sum ���������
data3$monthly_income[is.na(data3$monthly_income)] <- median(data3$monthly_income,  
                                                            na.rm=TRUE)
data3$credit_sum[is.na(data3$credit_sum)] <- median(data3$credit_sum,  
                                                    na.rm=TRUE)
 
# �������� �������� � ���������� education � marital_status ������ 
# (������ ����� �������������� ����������), ���������� � ����� ����� 
# �� �����������, ������������ �������� describe ������ Hmisc
data3$education[is.na(data3$education)] <- "SCH"
data3$marital_status[is.na(data3$marital_status)] <- "MAR"

# ���������� � ����� � �������� ����� ����� �������� � ������� ������ 
# imputeMissings, ������� compute ������������� ��������� ��� ��������������
# ���������� � �������, � ��� �������������� ���������� � ����
library(imputeMissings)
values <- compute(data3)
values

# 4.2.3. �������������� ��������� �������� � ����� c ������� ������� impute ������ imputeMissing

# � ������� ������� impute ������ imputeMissing ����� ������������� ������������
# �������� �������������� ���������� � ���������, �������� ��������������
# ���������� � ������
example <- read.csv2("C:/Trees/Example_comma.csv", sep = ',')
is.na(example) <- example==''
head(example, 20)
example_imp <- impute(example, method = "median/mode")
head(example_imp, 20)

# 4.2.4. ������ ��������� ��������� ���������� ��������

# �������� �������� � ���������� living_region ��������� ��������� ��������,
# ��� ����� ��������� �� � ���������� ������ � ������� ������� as.character
data3$living_region <- as.character(data3$living_region)

# �������� �������� � ���������� living_region ��������� ��������� ��������
data3$living_region[is.na(data3$living_region)] <- "�������"

# ����������� ���������� living_region ������� � ������
data3$living_region <- as.factor(data3$living_region)

# 4.2.5. ������ ��������� ��������� ��������� � ������� ������� na.replace ������ imputeTS

# ��������� ����� imputeTS
library(imputeTS)

# �������� �������� � ���������� credit_count � overdue_credit_count
# ��������� ��������� -1 � ������� ������� na.replace
data3$credit_count <- na.replace(data3$credit_count, fill = -1)
data3$overdue_credit_count <- na.replace(data3$overdue_credit_count, fill = -1)

# ����� ������� ������ �� ��������� � ������� ������� sapply
# �� ������ ��������� ����������
sapply(data3, function(x) sum(is.na(x)))

# 4.3. �������� � �������� ����������

# 4.3.1. ������� ����������
data3$client_id <- NULL

# 4.3.2. ������� ����������, � ������� �������� �������� �� ��������� ������ ����������

# ������� ���������� avrzarplata, � ������� �������� �������� 
# �� ���������� ���������� job_position
data3$avrzarplata[data3$job_position=="UMN"] <- 51000
data3$avrzarplata[data3$job_position=="SPC"] <- 63000
data3$avrzarplata[data3$job_position=="INP"] <- 55000
data3$avrzarplata[data3$job_position=="DIR"] <- 60000
data3$avrzarplata[data3$job_position=="ATP"] <- 46000
data3$avrzarplata[data3$job_position=="PNA"] <- 71000
data3$avrzarplata[data3$job_position=="BIS"] <- 86000
data3$avrzarplata[data3$job_position=="WOI"] <- 76000
data3$avrzarplata[data3$job_position=="NOR"] <- 54000
data3$avrzarplata[data3$job_position=="WRK"] <- 77000
data3$avrzarplata[data3$job_position=="WRP"] <- 75000
data3$avrzarplata[data3$job_position=="PNV"] <- 67000
data3$avrzarplata[data3$job_position=="BIU"] <- 43000
data3$avrzarplata[data3$job_position=="PNI"] <- 69000
data3$avrzarplata[data3$job_position=="HSK"] <- 74000
data3$avrzarplata[data3$job_position=="PNS"] <- 44000
data3$avrzarplata[data3$job_position=="INV"] <- 88000
data3$avrzarplata[data3$job_position=="ONB"] <- 62000

# 4.3.3. ������� ����������, ������� �������� ���������� ���� ����������

# ������� ����������, ������� �������� ���������� 
# ����� ������� � ������������ ���������
data3$ratio <- data3$credit_sum/data3$monthly_income
head(data3, 10)

# 4.3.4. ������� ����������, � ������� ������ �������� � ������� ���������� � ��������� ����������

# ��������� ����� dplyr
library(dplyr)

# ������� ��������� ���������, � ������� ���������� ����� ����������,
# ��� �������� ��� ����, ����� �� ����������� �������� ���������
# �������������� �����������, ������������ dplyr 
tmp <-data.frame(data3)

# ��������� ����� ���������� living_region_cnt
# � ������� ������ �������� � ������� ���������� 
# � ��������� ���������� living_region
tmp <- tmp %>%
group_by(living_region) %>%
mutate(living_region_cnt = n())

# ��������� ����� ���������� living_region_cnt � �������� ���������
data3$living_region_cnt <-tmp$living_region_cnt
head(data3, 10)

# 4.3.5. ������� ����������, � ������� ������ �������� � ������� �������� �������������� 
# ����������, ������ �� ������ �������������� ����������

# ������� ��������� ���������, � ������� ���������� ����� ����������,
# ��� �������� ��� ����, ����� �� ����������� �������� ���������
# �������������� �����������, ������������ dplyr 
tmp <-data.frame(data3)

# ������� ����������, � ������� ������ �������� � ������� �������� 
# monthly_income � ��������� ���������� living_region
tmp <- tmp %>%
group_by(living_region) %>%
mutate(mean_income_by_reg = mean(monthly_income))

# ��������� ����� ���������� mean_income_by_reg � �������� ���������
data3$mean_income_by_reg <-tmp$mean_income_by_reg
head(data3, 10)

# ����������� ����� dplyr
detach("package:dplyr", unload=TRUE)

# 4.3.6. ������� �������������� ���������� � ���������� ���������� ���� ����������

# ������� ���������� conj, ������� �������� ����������� ���������� 
# ���� ���������� education � marital_status 
data3$conj <- paste(data3$education, data3$marital_status, sep="+")
head(data3, 10)

# 4.3.7. ������� ����������, � ������� ������ �������� � �������� �������� �������������� ����������

# ������� ���������� log_income, � ������� ������ �������� � �������� ��������
# ���������� monthly_income
data3$log_income <- log(data3$monthly_income)
head(data3, 10)

# 4.3.8. ������� �������������� ����������, � ������� ������ �������� � 
# ����������� �������� ���������� �������������� ����������

# � ������� ������� rowMeans ������� ���������� mean_age_tenure, 
# � ������� ������ �������� � �c��������� �������� ���������� 
# age � credit_month 
data3$mean_age_tenure=rowMeans(data3[,c("age", "credit_month")], na.rm=TRUE)
head(data3, 10)

# 4.3.9. ��������� ������������� (�������) �������������� ���������� �� ������ ����������, �������� �������

# ��������� ����������� �������� ���������� age
min(data3$age, na.rm=T)

# ��������� ������������ �������� ���������� age
max(data3$age, na.rm=T)

# ������ ��������� ����� ���������� agecat �� ������ ����������
# �������� �������������� ���������� age
data3$agecat[data3$age <= 30] <- "�� 18 �� 30 ���"
data3$agecat[data3$age > 30 & data3$age <= 45] <- "�� 31 �� 45 ���"
data3$agecat[data3$age > 45 & data3$age <= 60] <- "�� 46 �� 60 ���"
data3$agecat[data3$age > 60] <- "������ 60 ���"
head(data3, 10)

# ����� ������� �����, ����������� ������� cut
data3$agecat2<-cut(data3$age, c(18,30,45,60,71), include.lowest = TRUE)
head(data3, 10)

# 4.3.10. ��������� ��������������� �������������� ����������

# ��������� ����� memisc
library(memisc)

# � ������� ������� recode ������ memisc c������� ���������� jobcat 
# � ������������ ����������� ���������� job_position
data3$jobcat <- recode(data3$job_position,
"cat1" <- c("UMN", "SPC", "INP", "DIR"),
"cat2" <- c("ATP", "PNA", "BIS"),
"cat3" <- c("WOI", "NOR", "WRK", "WRP"),
otherwise="cat4")

# 4.3.11. ��������� ������������� (�������) �������������� ���������� �� ������ ���������

# ��������� ����� rattle
library(rattle)

# ������������ ������� ���������� age �� ������ ��������� 
# � ���������� ���������� � ����� ���������� age_decile, 
# �� �������� ����� ���������. �������� �������� ��������, 
# ���������� � ������������� ���� ������ ������������ 
# ������������ �����. �������� ����� ��� �� ������ (�� ����� ������) 
# �����: �������� � �� ������, �������� � �� ����, ������ � �� ������.
data3$age_decile<- binning(data3$age, bins=10,
                                        method="quantile", labels=NULL,
                                        ordered=TRUE, weights=NULL)

# 4.3.12. ������� �������� ���������� �� ������ �������� �������������� ����������

# ������� ����� ���������� retired, ������� ��������� �������� "Yes",
# ���� �������� ���������� age ������ 60, � �������� "No" � ��������� ������
data3$retired <- ifelse(data3$age >= 60, c("Yes"), c("No"))
head(data3, 10) 

# 4.3.13. ������� ���������� �� ������ ���������� �������� � ���� ����������

# ��������� ������
example <- read.csv2("C:/Trees/Strings.csv")

# ������� ������
example

# ������ ������� ���������� registration � fact_living �� ���������� ��������
# � ���������� ������� � ���������� matching
example$matching <- (example$registration %in% example$fact_living) & (example$registration %in% example$fact_living)

# ������� ������
example

# ����� ������� ������� ���� ��������, �������������� ������������ 
# ���������� registration � fact_living � ��� char
example$fact_living <- as.character(example$fact_living)
example$registration <- as.character(example$registration) 
example$matching2 <- example$registration==example$fact_living

# ������� ������
example

# 4.4. ��������� �������������� ���������� � ����������

# � ������� ������� summary ������� ��������������
# ���������� � ����������
summary(data3)

# ��������� ����� Hmisc
library(Hmisc)

# � ������� ������� describe ������ Hmisc ������� ��������������
# ���������� � ����������
describe(data3)

# ����������� ����� Hmisc
detach("package:Hmisc", unload=TRUE)

# 4.5. �������������� ����������

# 4.5.1. ��������������� ���������� � ������� ������� names 

# ��������������� ���������� living_region � ���������� region
names(data3)[names(data3)=="living_region"] <- "region"
str(data3)

# ����������� ���������� gender � sex, ������ �� ������ 
names(data3)[1]<-"sex"
str(data3)

# 4.5.2. ��������������� ���������� � ������� ������� rename ������ dplyr

# ��������� ����� dplyr
library(dplyr)

# � ������� ������� rename ������ dplyr
# ��������������� ���������� region � ���������� reg,
# � ���������� tariff_id � ���������� tariff
data3 <- rename(data3, reg=region, tariff=tariff_id)
str(data3)

# ����������� ����� dplyr
detach("package:dplyr", unload=TRUE)

# 4.5.3. ��������������� ���������� � ������� ������� setnames ������ data.table

# ��������� ����� data.table
library(data.table)

# � ������� ������� setnames ������ data.table ����������� ����������
# monthly_income � score_shk
setnames(data3, old=c("monthly_income","score_shk"), new=c("income", "score"))
str(data3)

# ����������� ����� data.table
detach("package:data.table", unload=TRUE)

# 4.6. �������������� ��������� ����������

# 4.6.1. ��������������� ��������� ���������� � ������� ������� recode ������ dplyr

# ��������� ����� dplyr
library(dplyr)

# � ������� ������� recode ������ dplyr ��������������� 
# ��������� ���������� marital_status
data3$marital_status <- recode(data3$marital_status, 
                               MAR="Married", DIV="Divorced", WID="Widowed",
                               UNM="Unmarried", CIV="Civil union")
head(data3, 10)

# ����������� ����� dplyr
detach("package:dplyr", unload=TRUE)

# 4.6.2. ��������������� ��������� ���������� � ������� ������� revalue ������ plyr

# ��������� ����� plyr
library(plyr)

# � ������� ������� revalue ������ plyr ��������������� 
# ��������� ���������� sex
data3$sex <- revalue(data3$sex, c("M"="male", "F"="female"))
head(data3, 10)

# 4.6.3. ��������������� ��������� ���������� � ������� ������� mapvalues ������ plyr

# � ������� ������� mapvalues ������ plyr ��������������� 
# ������� ��������� ���������� sex
data3$sex <- mapvalues(data3$sex, from = c("male", "female"), to = c("M", "F"))
head(data3, 10)

# ����������� ����� plyr
detach("package:plyr", unload=TRUE)

# 4.7. ����������� ������

# �������� ������� �������� ��������� ��� ������� �������� 
# ���������� job_position
aggregate(data3$income, list(data3$job_position), mean)

# �������� ������� �������� ��������� ��� ������� �������� 
# ���������� job_position ����� ������� ��������
aggregate(income ~ job_position, data3, mean)

# �������� ������� �������� ��������� ��� ������� �������� 
# ���������� job_position � ������� ������� tapply
tapply(data3$income, data3$job_position, FUN=mean)

# �������� dplyr � �������� � ������� ���� ������� �������� ��������� 
# ��� ������� �������� ���������� job_position, �������� ��������, ��
# ������������� ��������� �����������, � ������� ���������� income ��������
# � �������� �������� ��� monthly_income
library(dplyr)
tmp %>% 
  group_by(job_position) %>%
  summarise(mean_income_by_job = mean(monthly_income))

# ������ �������� � ������� dplyr ������� �������� ��������� 
# ��� ������ ���������� �������� ���������� job_position � gender
# � ������� ���������� ���������� � result
result <- tmp %>% 
  group_by(job_position, gender) %>%
  summarise(mean_income_gender = mean(monthly_income))

# ��� ������������, � �� ���������� ������ ����������� 
# ������������� data.frame
data.frame(result)

# ����������� ����� dplyr
detach("package:dplyr", unload=TRUE)

# �������� ��������� �������� ��������� ��� ������� �������� 
# ���������� job_position
tapply(data3$income, data3$job_position, FUN=median)

# 5. ������ � ������

# 5.1. ��������� ��� � ������� dd.mm.yyyy (��������, 01.01.2017)

# ��������� CSV ����, ���������� ����, � ��������� data4
data4 <- read.csv2("C:/Trees/Dates.csv")

# �������, ��� �������� ����
head(data4)

# � ������ ����������, ��������������� �����, ��������� � ������� ���� 
# POSIXct � ������� ������� as.POSIXct
data4$date_start <- as.POSIXct(data4$date_start, format="%d.%m.%Y")
data4$date_end <- as.POSIXct(data4$date_end, format="%d.%m.%Y")

# �������, ��� �������� ����
head(data4)

# 5.2. ��������� ��� � ������� dd/mm/yyyy (��������, 01/01/2017)

# ��������� CSV ����, ���������� ����, � ��������� data5
data5 <- read.csv2("C:/Trees/Dates2.csv")

# �������, ��� �������� ����
head(data5)

# � ������ ����������, ��������������� �����, ��������� � ������� ���� 
# POSIXct � ������� ������� as.POSIXct
data5$date_start <- as.POSIXct(data5$date_start, format="%d/%m/%Y")
data5$date_end <- as.POSIXct(data5$date_end, format="%d/%m/%Y")

# �������, ��� �������� ����
head(data5)

# 5.3. ��������� ��� � ������� ddMthyyyy (��������, 01Jan2017)

# ��������� CSV ����, ���������� ����, � ��������� data6
data6 <- read.csv2("C:/Trees/Dates3.csv")

# �������, ��� �������� ����
head(data6)

# ��������� ����� anytime
library(anytime)

# � ������ ����������, ��������������� �����, ��������� � ������� ���� 
# POSIXct � ������� ������� anytime ������������ ������
data6$date_start <- anytime(data6$date_start)
data6$date_end <- anytime(data6$date_end)

# �������, ��� �������� ����
head(data6)

# 5.4. ��������� ��� � ������� dd-Mth-yyyy (��������, 01-Jan-2017)

# # ��������� CSV ����, ���������� ����, � ��������� data7
data7 <- read.csv2("C:/Trees/MFOcredit.csv")

# �������, ��� �������� ���� � ������ 10 �����������
head(data7, 10)

# � ������ ����������, ��������������� �����, ��������� � ������� ���� 
# POSIXct � ������� ������� anytime ������������ ������
data7$date_start <- anytime(data7$date_start)
data7$date_end <- anytime(data7$date_end)

# �������, ��� �������� ���� � ������ 10 �����������
head(data7, 10)

# 5.5. ���������� �������� ����� ������

# ��������� �������� ����� ������ � ���� ��� ���������� data7
data7$diff <- data7$date_end-data7$date_start

# ������� ��������� � ������ 10 �����������
head(data7, 10)

# 5.6. ���������� �� ��� �����, ���������, �������, ����, ���� ������

# �������, ��� �������� ����
str(data4)

# ��������� �� ���������� ��� date_start, ����������� � ���� Date, 
# ���� � ���������� � ���������� year
data4$year <- format(data4$date_start, "%Y")

# � ������� ������� quarters ��������� �� ���������� ��� date_start, 
# ����������� � ���� Date, �������� � ���������� � ���������� quarter
data4$quarter <- quarters(data4$date_start)

# ��������� �� ���������� ��� date_start, ����������� � ���� Date, 
# ���������� ������ ������� � ���������� � ���������� num_of_month
data4$num_of_month <- format(data4$date_start, "%m")

# ��������� �� ���������� ��� date_start, ����������� � ���� Date, 
# ����������� �������� ������� � ���������� � ���������� shortname_of_month
data4$shortname_of_month <- format(data4$date_start, "%b")

# ��������� �� ���������� ��� date_start, ����������� � ���� Date, 
# ������ �������� ������� � ���������� � ���������� fullname_of_month
data4$fullname_of_month <- format(data4$date_start, "%B")

# ��������� �� ���������� ��� date_start, ����������� � ���� Date, 
# ���������� ������ ���� � ���������� � ���������� day
data4$day <- format(data4$date_start, "%d")

# ��������� �� ���������� ��� date_start, ����������� � ���� Date, 
# ����������� �������� ���� ������ � ���������� � ���������� name_of_weekday
data4$name_of_weekday <- format(data4$date_start, "%a")

# ��������� �� ���������� ��� date_start, ����������� � ���� Date, 
# ���������� ������ ���� ������ (0-6, 0 � �����������) 
# � ���������� � ���������� num_of_weekday
data4$num_of_weekday <- format(data4$date_start, "%w")

# ������� ������ 10 ����������
head(data4)

# 6. ������ �� ��������

# 6.1. ��������� �������� �����

# �������, ��� �������� ������ 10 ���������� ���������� 
# job_position (����� ������ 4) � ���������� data3
head(data3[4], 10)

# ��������� ������ (�������� ���������� job_position) � ������ ������� 
data3$job_position <- tolower(data3$job_position)

# �������, ��� �������� ������ 10 ���������� ���������� 
# job_position (����� ������ 4) � ���������� data3
head(data3[4], 10)

# ��������� ������ (�������� ���������� job_position) ������� � ������� ������� 
data3$job_position <- toupper(data3$job_position)

# �������, ��� �������� ������ 10 ���������� ���������� 
# job_position (����� ������ 4) � ���������� data3
head(data3[4], 10)

# 6.2. ����������� ���� ������� �� ��������

# ��������� CSV ���� � ��� ��������, �� ������� ����� ���������� ���
data8 <- read.csv2("C:/Trees/Gender based on middle name.csv")

# ������� ���������� ���, ������� ����� ����� �������� True, ���� ��������� 
# �������� ���������� ������ �������� ������� "���" (����������, ����������) 
# � False � ��������� ������
data8$��� <- grepl("���", data8$������)

# ����������� ��������� ���������� ���
data8$���[data8$���=="FALSE"] <-"�������"
data8$���[data8$���=="TRUE"] <-"�������"

# ������� ���������
head(data8, 10)

# � ������ ������� ����������� �������, ������� ����� ��������� n
# ��������� �������� �� �����  
substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}

# ����������� ���������� ������ � ��� char (�������� � ���������� �����) 
# � ������� ������� as.character
data8$������ <- as.character(data8$������)

# � ������ � ������� ���� ������� �������� � ������ ��������� ��������
# ���������� ������ ��������� 3 ������� � ������� � ����� ���������� ���2
data8$���2 <- substrRight(data8$������, 3)

# ����������� ��������� ���������� ���
data8$���2[data8$���2=="���"] <-"�������"
data8$���2[data8$���2=="���"] <-"�������"

# ������� ���������
head(data8, 10)

# 6.3. �������� ������ �������� �� �����

# � ������� ������� gsub ������ �������� ������ �������������, � �������� 
# ���������� ��������� �������� ���������� ������, ������ �������� ������� � ������,
# ������� ����� �������, ������ �������� � ������, �� ������� �����
# ��������, ������ �������� � ������ ��� ����������, ���������� ��������� ��������
data8$������ <- gsub('_',  "", data8$������)

# ������� ���������
head(data8, 20)

# ������ � ������� gsub ������ �������� �������, �������� 
# ������������� ��������� �������� ���������� �������, �������
# ������ &, � � ������� ������ �������� POSIX [:alpha:] ��� ������� ��������,
# ���������� ������� � ���������� �������2

data8$�������2 <- gsub("[&[:alpha:]]", "", data8$�������)

# ������� ���������
head(data8, 20)

# � ������ �������� ����������� �������� � ������� ����������� ������� substr,
# ��� �������� ������ ����������, ������ �������� ������ ������, 
# ������ �������� � ������� ���������� �������, ������ �������� � 
# ������� ���������� �������, ��������, � ������ ������ ������ �28��� 
# ����� ������ �� ��������� �28�, �2� � ��������� ������, ���������� ������� 1,
# �8� - ��������� ������, ���������� ������� 2 ������ �28 ���, 
# ��������� ������� � ���������� �������3 
data8$�������3 <- substr(data8$�������, 1, 2)

# ������� ���������
head(data8, 20)

# ������ �������� �� �� ����� ������ ������ ���������� � ������� 
# ����������� ������� substring, ��������� ������� � ���������� �������4
data8$�������4 <- substring(data8$�������, 1, 2)

# ������� ���������
head(data8, 20)

# ����������� ���������� ������ � ��� char (�������� � ���������� �����) 
# � ������� ������� as.character
data8$������ <- as.character(data8$������)

# ������� ��������� 3 ������� � ������ ��������
# ���������� ������
data8$������ <- substr(data8$������,1,nchar(data8$������)-3)

# ������� ���������
head(data8, 20)

# 6.4. �������� ������������� �����

# ������� ������������� ������
data9 <- data8[!duplicated(data8), ]
data9

# ��� ����� ������� ������������� ������ � ������� ������� unique
data10 <- unique(data8)

# 6.5. ���������� ������ �������� �� �����

# ����� ������ ����� ���� ����������� �������� � ���������� �������
# ������ ��� ���������
data11 <- read.csv2("C:/Trees/Raw_text.csv")

# ������� ������
data11

# ����������� ������ � ��� char (�������� � ���������� �����) 
# � ������� ������� as.character
data11$raw <- as.character(data11$raw)

# ��������� ����� stringr
library(stringr)

# ��������� ���� �� ������� raw � ������� ������� str_extract 
# ������ stringr � ������� ���������� date
datepattern="[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]"
data11$date <- str_extract(data11$raw, pattern=datepattern)

# ������� ������
data11

# ��� ����� ���
datepattern2 <- "\\d\\d\\d\\d\\-\\d\\d-\\d\\d"
data11$date2 <- str_extract(data11$raw, pattern=datepattern2)

# ������� ������
data11

# ��������� ��������� ����� �� ������� raw � ������� ������� str_extract 
# ������ stringr � ������� ���������� gender 
genderpattern="[0-9]"
data11$gender <- str_extract(data11$raw, pattern=genderpattern)

# ������� ������
data11

# ��������� ####.# �� ������� raw � ������� ������� str_extract 
# ������ stringr � ������� ���������� score 
scorepattern <- "\\d\\d\\d\\d\\.\\d"
data11$score <- str_extract(data11$raw, pattern=scorepattern)

# ������� ������
data11

# ��������� ����� �� ������� raw � ������� ������� str_extract 
# ������ stringr � ������� ���������� city
data11$city <- str_extract(data11$raw, pattern="[A-Z]+")

# ����������� �������� ����� ��������� � ������� 
# ����������� ������� sub
data11$city2 <- sub("[^[:alpha:]]+", "", data11$raw)

# ������� ������
data11


