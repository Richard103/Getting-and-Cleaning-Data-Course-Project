# Create one R script called run_analysis.R that does the following.

# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names.
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# Preparing the enviroment

if(!require("data.table")) {
    install.packages("data.table")
}

library(data.table)

if(!require("plyr")) {
    install.packages("plyr")
}

library(plyr)

# Creating the path to test datasets
path1 <- file.path("~", "./data/UCI HAR Dataset/", "activity_labels.txt")
path2 <- file.path("~", "./data/UCI HAR Dataset/", "features.txt")
path3 <- file.path("~", "./data/UCI HAR Dataset/test/", "subject_test.txt") 
path4 <- file.path("~", "./data/UCI HAR Dataset/test/", "X_test.txt") 
path5 <- file.path("~", "./data/UCI HAR Dataset/test/", "y_test.txt") 

# 1) Merging the training and the test sets to create one data set.
# Read datasets and create variables
activity <- read.table(path1, header = FALSE)[,2]
features <- read.table(path2, header = FALSE)[,2]

# Read datasets for test data
subject_test <- read.table(path3, header = FALSE)
X_test <- read.table(path4, header = FALSE)
y_test <- read.table(path5, header = FALSE)

# Set column names
names(X_test) <- features
names(subject_test) = "Subject"

# Creating the path to test trainsets
path6 <- file.path("~", "./data/UCI HAR Dataset/train/", "subject_train.txt") 
path7 <- file.path("~", "./data/UCI HAR Dataset/train/", "X_train.txt") 
path8 <- file.path("~", "./data/UCI HAR Dataset/train/", "y_train.txt") 

# Reading datasets for train data
subject_train <- read.table(path6)
X_train <- read.table(path7)
y_train <- read.table(path8)

# Set column names
names(X_train) <- features
names(subject_train) = "Subject"

# 3) Using descriptive activity names to name the activities in the data set

y_test[,2] = activity[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
y_train[,2] = activity[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")

# Merging test and train data 
dataTest <- cbind(as.data.table(subject_test), y_test, X_test)
dataTrain <- cbind(as.data.table(subject_train), y_train, X_train)

# Merging all data in one dataset by rows
oneData <- rbind(dataTrain, dataTest, fill = TRUE)

# 2) Extracting only the measurements on the mean and standard deviation for each measurement.
extract <- grepl("mean|std", features)
extractedData <- X_test[, extract]


# 4) Appropriately labeling the data set with descriptive variable names.
names(oneData) <- gsub("^t", "time", names(oneData))
names(oneData) <- gsub("^f", "frequency", names(oneData))
names(oneData) <- gsub("Acc", "Accelerometer", names(oneData))
names(oneData) <- gsub("Gyro", "Gyroscope", names(oneData))
names(oneData) <- gsub("Mag", "Magnitude", names(oneData))
names(oneData) <- gsub("BodyBody", "Body", names(oneData))

# 5) From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject.
# secondDataset = dcast(melted, Subject + Activity_Label ~ variable, mean)
secondData <- aggregate(. ~Subject + Activity_ID, oneData, mean)
secondData <- secondData[order(secondData$Subject,secondData$Activity_ID),]

# Saving second dataset
write.table(secondData, file = "./tidyDataset.txt")

