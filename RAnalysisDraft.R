##call libraries needed

##download .zip folder into R

#First, create a tempfile
connection <-  tempfile()
##download the files into the tempfile
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", connection)
#unzip contents of the connection file
unzip(connection)

##Get X-Test into the test_x table
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt")
##Get X_train into the train_x table
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt")
##Grab the subject id from the test and train tables, will be merged with the corresponding _x table
train_subject
test_subject
##Grab the activity id from the test and train tables, will be merged with the corresponding _x table
activity_train
activity_test
##Grab the features_labels file for use later in renaming activites after it is merged

##Unlink the connection tempfile
unlink(connection)


##Test and Train will need to be merged using rbind. After that initial merge, we will need to find the columns
##with -mean or -std in the name from the features.txt file. This means that will need to take features.txt and
##make it a vector to append as the merged datasets headers. Then subset based on column names with  mean or std
##in the name.


##the y_ files show the activity of each measurement from activity_labels.txt. This will need merged as well to
##show the differences between each activity. So before test and train can be merged, the match y_ needs cbinded
##then that column should be changed to prevent a re-sort or reorder of records.

##Determine if each measurement has a mean or standard deviation


##bind rows of test and train
complete <- rbind(test_x, train_x)