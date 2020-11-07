# You should create one R script called run_analysis.R that does the following.
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

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




head(subtest,3)
