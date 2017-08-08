*********************************
# **Getting and Cleaning data**
********************************
## Codebook
This codebook contains the information on the data and variables in the tidyData and the steps explaining how the raw data is transformed into the tidyData.
### Raw Data
The raw data for this project is obtained from this site http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The data can be downloaded using this link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

Human Activity Recognition Using Smartphones. The data is collected as part of an experiment from accelerometers in the Samsung Galaxy S smartphone to identify a human activity based on their movements.
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

### Transforming raw data to tidy data

As part of the Getting and Cleaning Data Course, my aim is to combine the test and train data and provide a tidy data as a result.
Steps to transform is scripted in run_Analysis.R

##### Steps involved in run_Analysis.R

1. Read the training data files X_train.txt, y_train.txt, subject_train.txt into variables train, train_a and train_s respectively (a - activity, s - subject_id).
2. Read the training data files X_test.txt, y_test.txt, subject_test.txt into variables test, test_a and test_s respectively.
3. Using the function _cbind()_ add the train_a and train_s (each is a single column data) columns to the train data so they form the 562nd and 563rd column. Similarly add test_a and test_s to the test dataset.
4. Now using _rbind()_ add the train and test data by rows and store it in a variable _HAR_.
5. Now store the character vector of feature names in the featureName dataset by reading the features.txt file.
6. Using the _colnames()_ function add the column names from featureName data to the first 561 columns.
7. Next we use _grep()_ function to find the indices of columns containing std and mean and subset the HAR dataset using this indices.
8. Read the activity_labels.txt and store it in variable activity_labels. Find the order of activity numbers in HAR dataset and set the factor labels from the activity_labels in the same order.
9. Now to appropriately label the column names with descriptive names we use _gsub()_ function and passing it each column name with a _for loop_.
10. Finally using _group_by()_ to group the HAR data by activity and subject_id and summarising each non-grouping column with _mean()_ function. The result is stored in a variable called _tidyData_.

### Tidy Data

The final tidy data contains 180 rows(30 subjects each doing 6 activtiy) and 81 columns(Activity, subject_id and all the columns containing mean or standard deviation measurements).
The activity column labels the activity each subject performed. There are total of 6 activities each subject performs.
1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING

Subject_id takes value between 1 to 30 as the number of volunteers for this experiment is 30. Each activity and subject_id form unique rows of 180 i.e., each of the observation corresponds to the average of all the values for the measurements(column) in the particular activity and subject_id combination.
