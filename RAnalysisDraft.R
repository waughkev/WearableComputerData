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


##Rename features_labels to remove commas and dashes, first three will cover X,Y, and Z axis
features_labels$V2 <- gsub("-X", "_X_Axis", features_labels$V2)
features_labels$V2 <- gsub("-Y", "_Y_Axis", features_labels$V2)
features_labels$V2 <- gsub("-Z", "_Z_Axis", features_labels$V2)
##Come back to this one, after all the changing it might not be needed
features_labels$V2 <- gsub("-", "_", features_labels$V2)
features_labels$V2 <- gsub(",", "_", features_labels$V2)

##Determine feature_labels that start with t and change label name to include time
features_labels$V2 <- gsub("tBody", "Time_Body", features_labels$V2)
features_labels$V2 <- gsub("tGravity", "Time_Gravity", features_labels$V2)

##Determine feature_labels that start with f and change label to include frequency
features_labels$V2 <- gsub("fBody", "Frequency_Body", features_labels$V2)

##Determine feature_labels that contain "Acc" and change to "_Accelerometer"
features_labels$V2 <- gsub("Acc", "_Accelerometer_", features_labels$V2)
##Determine feature_labels that contain Gyro and change to "Gyrometer"
features_labels$V2 <- gsub("Gyro", "_Gyrometer_", features_labels$V2)

##get some weird double underscores, removingthem here
features_labels$V2 <- gsub("__", "_", features_labels$V2)

##Eliminate the () since those could cause issues, replace with _function_results
features_labels$V2 <- gsub("\\()", "_Function_Results", features_labels$V2)

##Change mean and standard deviation abbreviations as well.
features_labels$V2 <- gsub("_mean_", "_Mean_", features_labels$V2)
features_labels$V2 <- gsub("_std_", "_Standard_Deviation_", features_labels$V2)


##Add features as header of the test_x and train_x data
colnames(test_x) <-features_labels$V2
colnames(train_x) <-features_labels$V2


##Add names to the subject_test and subject_train data
colnames(subject_test) <- "Subject_ID"
colnames(subject_train) <- "Subject_ID"


##Add column names to the activity test and train data sets
colnames(activity_test) <- "Activity_Performed"
colnames(activity_train) <- "Activity_Performed"


##Both test and train will get the activity_ and subject_ will be binded to the corresponding dataset
test_plus_activity_plus_subject <- cbind(test_x, activity_test, subject_test)
train_plus_activity_plus_subject <- cbind(train_x, activity_train, subject_train)


##Change data in the Activity column from a number to a name, would like to do a for loop to cover dynamic values
test_plus_activity_plus_subject$Activity_Performed[test_plus_activity_plus_subject$Activity_Performed==1] <- "Walking"
test_plus_activity_plus_subject$Activity_Performed[test_plus_activity_plus_subject$Activity_Performed==2] <- "Walking_Upstairs"
test_plus_activity_plus_subject$Activity_Performed[test_plus_activity_plus_subject$Activity_Performed==3] <- "Walking_Downstairs"
test_plus_activity_plus_subject$Activity_Performed[test_plus_activity_plus_subject$Activity_Performed==4] <- "Sitting"
test_plus_activity_plus_subject$Activity_Performed[test_plus_activity_plus_subject$Activity_Performed==5] <- "Standing"
test_plus_activity_plus_subject$Activity_Performed[test_plus_activity_plus_subject$Activity_Performed==6] <- "Laying"

##Same thing above but for train data
train_plus_activity_plus_subject$Activity_Performed[train_plus_activity_plus_subject$Activity_Performed==1] <- "Walking"
train_plus_activity_plus_subject$Activity_Performed[train_plus_activity_plus_subject$Activity_Performed==2] <- "Walking_Upstairs"
train_plus_activity_plus_subject$Activity_Performed[train_plus_activity_plus_subject$Activity_Performed==3] <- "Walking_Downstairs"
train_plus_activity_plus_subject$Activity_Performed[train_plus_activity_plus_subject$Activity_Performed==4] <- "Sitting"
train_plus_activity_plus_subject$Activity_Performed[train_plus_activity_plus_subject$Activity_Performed==5] <- "Standing"
train_plus_activity_plus_subject$Activity_Performed[train_plus_activity_plus_subject$Activity_Performed==6] <- "Laying"
##unique(test_plus_activity_plus_subject$Activity) should show the text values above and nothing else


##Test and Train will need to be merged using rbind.
##bind rows of test and train
complete_data <- rbind(test_plus_activity_plus_subject, train_plus_activity_plus_subject)

##Variables for Activity and SubjectID respectively
Activity_Performed <- complete_data$Activity_Performed
Subject_ID <- complete_data$Subject_ID
##After that initial merge, we will need to find the columns with _Mean_ or _Standard_Deviation_
##in the name. Then subset based on on those parameters.

##This will grab the columns with "_Mean_ in the column name
mean_data <- complete_data[, grepl("_Mean_" , names(complete_data))]
##This will grab the columns with "_Standard_Deviation_" in the column name
std_data <- complete_data[, grepl("_Standard_Deviation_" , names(complete_data))]
##Determine if each measurement has a mean or standard deviation

##Combination of the two above tables and the final two columns of the complete data table
final_data <- cbind(mean_data, std_data, Activity_Performed, Subject_ID)



