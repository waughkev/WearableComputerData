##call libraries needed

##download .zip folder into R

#First, create a tempfile
connection <-  tempfile()
##download the files into the tempfile
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", connection)
#unzip contents of the connection file
unzip(connection)

##Get X-Test into the test_x table
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
##Get X_train into the train_x table
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
##Grab the subject id from the test and train tables, will be merged with the corresponding _x table
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
##Grab the activity id from the test and train tables (y_), will be merged with the corresponding _x table
activity_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
activity_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
##Grab the features_labels file for use later in renaming features after it is merged
features_labels <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
##Grab the activity labels file for use in renaming activities after it is merged
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
##Unlink the connection tempfile
unlink(connection)


##Add features as header of the test_x and train_x data
colnames(test_x) <-features_labels$V2
colnames(train_x) <-features_labels$V2


##Add names to the subject_test and subject_train data
colnames(subject_test) <- "Subject ID"
colnames(subject_train) <- "Subject ID"


##Add column names to the activity test and train data sets
colnames(activity_test) <- "Activity"
colnames(activity_train) <- "Activity"


##Both test and train will get the activity_ and subject_ will be binded to the corresponding dataset
test_plus_activity_plus_subject <- cbind(test_x, activity_test, subject_test)
train_plus_activty_plus_subject <- cbind(train_x, activity_train, subject_train)

#Activity will be renamed based on the matching number value of the activity_labels data. Similar to an excel VLookUP?

##Test and Train will need to be merged using rbind. After that initial merge, we will need to find the columns
##with -mean or -std in the name. Then subset based on column names with  mean or std
##in the name.


##the y_ files show the activity of each measurement from activity_labels.txt. This will need merged as well to
##show the differences between each activity. So before test and train can be merged, the match y_ needs cbinded
##then that column should be changed to prevent a re-sort or reorder of records.

##Determine if each measurement has a mean or standard deviation


##bind rows of test and train
complete <- rbind(test_x, train_x)