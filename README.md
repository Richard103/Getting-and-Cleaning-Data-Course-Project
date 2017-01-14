# Getting-and-Cleaning-Data-Course-Project
Assignment outputs

I create one R script called run_analysis.R that does the following.

    Merges the training and the test sets to create one data set.
    Extracts only the measurements on the mean and standard deviation for each measurement.
    Uses descriptive activity names to name the activities in the data set
    Appropriately labels the data set with descriptive activity names.
    Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Description of steps of the R script

    Preparing the enviroment
    Creating the path to test datasets
    Merging the training and the test sets to create one data set.
    Read datasets and create variables
    Read datasets for test data
    Set column names
    Creating the path to test trainsets
    Reading datasets for train data
    Set column names
    Using descriptive activity names to name the activities in the data set
    Merging test and train data 
    Merging all data in one dataset by rows
    Extracting only the measurements on the mean and standard deviation for each measurement.
    Appropriately labeling the data set with descriptive variable names.
    From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject.
    Saving second dataset

Dependencies

    R script file installs all the dependencies automatically. It depends on data.table and plyr packages. 
