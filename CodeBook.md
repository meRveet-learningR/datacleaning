The ```run_analysis.R``` script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

1. Dataset download
* Dataset was downloaded and extracted from zip folder called ```UCI HAR Dataset```

2. Assign each data to varible
* ```xtrain <- train/Xtrain.txt``` : 7352 rows, 561 columns, contains recorded features train data
* ```ytrain <- train/ytrain.txt``` : 7352 rows, 1 columns, contains train data of activities’code labels
* ```subtrain <- train/subject_train.txt```: 7352 rows, 1 columns, contains  train data of 21/30 volunteer subjects being observed

* ```xtest<- test/X_test.txt```: 7352 rows, 1 columns, contains recorded features test data
* ```ytest<- test/Y_test.txt```: 7352 rows, 1 columns, contains test data of activities’code labels
* ```subtest<- test/subect_test.txt```: 7352 rows, 1 columns, contains test data of 9/30 volunteer test subjects being observed

* ```features<- /features.txt```: 561 rows, 2 columns, contains features from the accelerometer and gyroscope 3-axial raw signals
* ```labels<- activity_labels.txt```: 6 rows, 2 columns, contains the activities performed when the corresponding measurementts were collected and its labels


3. Labelling the varibles by using names by indexing ```features```and strings: ```activityid```, ```subid```
* Using **colnames()** to call out the names and storing ```features[,2]```, "activityid" and "subid" into each varible's name.
* ```tolower()``` was used to convert all headers to lower caps, and ```gubsub``` were used to remove `'` from the headers
* For ```labels``` string "actvityid" and "activitylabel" was use to name the headers
* labelling was done on ```xtrain```, ```ytrain```, ```subtrain```, ```xtest```, ```ytest``` and ```subtest```. ```labels```


4. Merges the training and test sets into one data
* Using **cbind()**   each of the following data (```subtrain```, ```ytrain```, ```xtrain```) were merged into ```mtrain```.: 7352 rows, 563 columns
* Using **cbind()**  each of the following data (```subtest```, ```ytest```, ```xtest```) were merged into ```mtest```.: 2947 rows, 563 columns
* Using 88rbind()** each of the following data (```mtrain```, ```mtest```) were merged into ```all```.: 10299 rows, 88 columns

5. Extracting only mean and standard deviation for each measurement
* ```meandata``` was formed by using **grep()** to filter out "subid" | "activityid" | "mean" | "std" from **names(all)**.: 10299 rows, 88 varibles

6. Matching activityid to activity labels to form ```tidydata```
* **merge()** was used to fill up the rows that matches the ```activityid``` varible on both ```labels``` and ```meandata```.

7. Tidying of headers to descriptive names
**library(mgsub)** was deployed 
```x``` <- short forms of headers
```y```<- long forms of headers
* **mgsub()** was used to replace short forms in headers to descriptive headers.

8. Summarising data by grouping according to subject id. and activity of each subject and avg of each feature.
* Using **groupby()** to group ```activitylabel```
* Using **summarise_all() to average the observations of each feature in according to each activities of individual subject.

9. Saving the data onto .txt file.
* **write.table()** was used to form table and store in txt file. 
