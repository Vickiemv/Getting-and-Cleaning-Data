# Getting-and-Cleaning-Data

*******************************************************
## Human Activity Recognition Using Smartphones Dataset
*******************************************************
  This is a Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.
  This project entails cleaning the above dataset obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The raw dataset has been randomly partioned into training data and test data while training data contains observations from 70% of the subjects and test data contains the rest.
 
 An R-script called [run_Analysis.R](https://github.com/Vickiemv/Getting-and-Cleaning-Data/blob/master/run_Analysis.R) was created so that it does the following
 
    1.Merges the training and the test sets to create one data set.
    2.Extracts only the measurements on the mean and standard deviation for each measurement.
    3.Uses descriptive activity names to name the activities in the data set
    4.Appropriately labels the data set with descriptive variable names.
    5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
 A codebook describing the variables, data and the transformation steps to clean the data is also included in this repository.
 
 Finally the [tidy_data](https://github.com/Vickiemv/Getting-and-Cleaning-Data/blob/master/tidyData.txt) is also available in the repo.
