# You should create one R script called run_analysis.R that does the following.
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(mgsub, plyr, data.table, stats)

#reading values from training folder
xtrain<- read.table("./train/X_train.txt")
ytrain<- read.table("./train/y_train.txt")
subtrain<- read.table("./train/subject_train.txt")

#reading values from test folder
xtest<- read.table("./test/X_test.txt")
ytest<- read.table("./test/Y_test.txt")
subtest<- read.table("./test/subject_test.txt")

#reading values from features
features<- read.table("./features.txt")

#reading activity labels
labels<- read.table("./activity_labels.txt")

#labeling colnames for training set
colnames(xtrain)<- features [,2]
colnames(ytrain)<- "activityid"
colnames(subtrain)<- "subid"
names(xtrain)<- tolower(gsub(",", "" , names(xtrain)))

#labeling colnames for test set 
colnames(xtest)<- features [,2]
colnames(ytest)<- "activityid"
colnames(subtest)<- "subid"
names(xtest)<- tolower(gsub(",", "" , names(xtest)))

#labeling colnames for activity label list
colnames(labels)<- c("activityid", "activitylabel")

###(1)###
#merging all data sets
mtrain<- cbind(subtrain, ytrain, xtrain)
mtest<- cbind(subtest, ytest,xtest)
all<- rbind(mtrain,mtestt)

###(2)###
#extracting columns with mean data for each variable using grep to call for column number to subset columns into meandata 
# "|" is used to search up  
meandata<- all[,grep("subid|activityid|mean|std" , names(all))]

###(3)###
#matching activityid to activity labels 
tidydata<- merge(meandata, labels,by = "activityid", all.x = T)

###(4)###
#substituting variables names with tidy names
x<- c("acc", "gyro", "bodybody", "mag", "^t", "^f", "tbody", "-mean\\(\\)", "-std\\(\\)", "-freq\\(\\)", "angle", "gravity")
y<- c("accelerometer", "gyroscope", "body", "magnitude", "time", "frequency", "timebody", "mean", "std", "frequency", "angle", "gravity")
names(tidydata) <- mgsub(names(tidydata), pattern = x, replacement =  y)

###(5)###
#summarising data by grouping according ot subject id and activity of each subject with average of each feature 
finaldata<- tidydata %>% 
                group_by(subid, activitylabel) %>%
                summarise_all(funs(mean))

write.table(finaldata, "finaldata.txt, row.name=F")
