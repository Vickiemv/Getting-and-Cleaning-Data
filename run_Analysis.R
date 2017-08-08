#***************************************************************************#
# **********************Requirements of run_Analysis.R**********************#
# 1.Merges the training and the test sets to create one data set.
# 2.Extracts only the measurements on the mean and standard deviation for
#   each measurement.
# 3.Uses descriptive activity names to name the activities in the data set
# 4.Appropriately labels the data set with descriptive variable names.
# 5.From the data set in step 4, creates a second, independent tidy data set
#   with the average of each variable for each activity and each subject.
#***************************************************************************#

# Download the required file
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFile<-"getdata_projectfiles_UCI HAR Dataset.zip"
exDir<-"./data"
if(!file.exists(destFile)){
        download.file(fileUrl,destfile = destFile)
     }
unzip(destFile,exdir = exDir)
setwd("./data/UCI HAR Dataset")

# 1.Merge the test and train datasets
# Complete the training and test sets by adding activity labels and subjects to the 
# X-test and X-train data sets.

##*************Prepare TRAIN dataset*************##

train<-read.table("./train/X_train.txt")
train_s<-read.table("./train/subject_train.txt")
train_a<-read.table("./train/y_train.txt")
train<-cbind(train,train_s,train_a)

##*************Prepare TEST dataset*************##

test<-read.table("./test/X_test.txt")
test_s<-read.table("./test/subject_test.txt")
test_a<-read.table("./test/y_test.txt")
test<-cbind(test,test_s,test_a)

# Row bind to merge train and test dataset
HAR<-rbind(train,test)

# Rename the Columns with feature names (columns 562 & 563 are 
# subject id and activity columns)
featureName<-read.table("./features.txt")
colNameA<-"Activity"
colNameS<-"Subject ID"
colnames(HAR)<-c(as.character(featureName[,2]),colNameS,colNameA)

# 2.Extracts only the measurements on the mean and standard deviation for
#   each measurement.

# Using grep() function to extract the indices of column names containing 
# mean or std and subset the required columns (columns 562 & 563 are 
# subject id and activity columns)
measurement_name<-names(HAR)
measurement_index_req<-grep(".*mean.*|.*std.*",measurement_name)
HAR<-HAR[,c(562,563,measurement_index_req)]

# 3.Uses descriptive activity names to name the activities in the data set

activity_labels<-read.table("activity_labels.txt")
activity_labels[,2]<-gsub("_"," ",activity_labels[,2]) 

# use unique() function to determine the order of the first instance of each activity
# and use this to change the order of the activity_labels data.
order<-unique(HAR$Activity)
activity_labels<-activity_labels[order,]

# Use factor() to change the activity numbers to their respective labels
HAR$Activity<-factor(HAR$Activity,levels = order,labels = activity_labels[,2])

# 4.Appropriately labels the data set with descriptive variable names.

colName<-colnames(HAR)
for (i in 1:length(colName)) 
{
        colName[i] = gsub("\\()","",colName[i])
        colName[i] = gsub("-std","StdDev",colName[i])
        colName[i] = gsub("-mean","Mean",colName[i])
        colName[i] = gsub("^(t)","time",colName[i])
        colName[i] = gsub("^(f)","freq",colName[i])
        colName[i] = gsub("Mag","Magnitude",colName[i])
}
# Rename the column names with more descriptive names
colnames(HAR)<-colName

# 5.From the data set in step 4, creates a second, independent tidy data set
#   with the average of each variable for each activity and each subject.
#   One row one observation, one column one variable
require(dplyr)
tidyData<-HAR%>%
        group_by(Activity,`Subject ID`)%>%
        summarise_all(mean)

#SAVE the Tidy Data
write.table(tidyData,file = "./tidyData.txt",row.names = FALSE,sep = " ")
