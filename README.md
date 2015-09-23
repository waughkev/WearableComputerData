# WearableComputer Data Project
This repository will cover the Coursera Getting and Cleaning Data Course Project. This data will contain a collection of variables from the UCI Human Activity Study.  In  particular, this project will look into certain aspects of the data given, notably the means and standard deviations of the recordings. The recordings cover the accelerometer and gyroscope of a Samsung Galaxy II Smartphone attached to the waist of 30 subjects. The accelerometer and gyroscope created records for specific actions such as movement of the individual during a certain task.


##Desired Outcome
When completed, this data will contain the averages of the mean and standard deviation functions recorded, grouped by Axis and device used. Each average will be grouped based on the activity performed and the subject it was performed by. This aspect should be able to be used to determine correlation between an activity and the readings of the Accelerometer and Gyroscope.

##Project Contents
- RAnalysis.R script that takes data from the UCI Human Activity Study and converts the data into the Tidy_Data.csv file for further analysis
- Tidy_Data.csv file containing a subset of the UCI Human Activity Training and Test data, with averages of the Means and Standard Deviations of each of the six activities performed, sorted by subject
- CodeBook.txt which covers the variable labels and their definitions

Reference Study
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012