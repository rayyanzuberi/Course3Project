library(tidyverse)
library(data.table)

#set working directory
setwd('~/Documents/Coding/RStudio Course/Course3Project')

#download zip file
if(file.exists('data.zip')) {
  print('zip file present')
} else {
  download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'data.zip')
}

#unzip zip file
if(dir.exists('UCI HAR Dataset')) {
  print('Directory Already Downloaded and Unzipped Successfully')
} else {
  unzip('data.zip')
}

#define features of the document
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("count","feature"))

#define activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity label", "activity"))

#file that indicates which subject performed what
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

#values for testing data
featuresList <- features$feature
xTest <- read.table("UCI HAR Dataset/test/X_test.txt",col.names=featuresList)

#values for labels for testing data
yTest<-read.table("UCI HAR Dataset/test/y_test.txt", col.names="activity label")

#file that indicates which subject performed what
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

#values for testing data
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = featuresList)

#values for labels for testing data
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity label")

# Bind columns into test and training set
test <- cbind(subjectTest, xTest, yTest)
train <- cbind(subjectTrain, xTrain, yTrain)

#bind all rows together
combined <- rbind(test, train)

#filter for mean and standard deviation
headingOfCombined <- names(combined)
combinedFilteredForMeanAndSD<-grep(".*mean.*|.*std.*", ignore.case=TRUE, headingOfCombined)
selectedData <- combined %>% select(subject, combinedFilteredForMeanAndSD)

#fix all variable names
names(selectedData) <- gsub("[.]", "", names(selectedData))
names(selectedData) <- gsub('^t', 'Time ', names(selectedData))
names(selectedData) <- gsub('Freq', 'Frequency ', names(selectedData))
names(selectedData) <- gsub('^f', 'Frequency ', names(selectedData))
names(selectedData) <- gsub('Acc', 'Accelerometer ', names(selectedData))
names(selectedData) <- gsub('mean', ' Mean ', names(selectedData))
names(selectedData) <- gsub('std', ' Standard Deviation ', names(selectedData))
names(selectedData) <- gsub('X', 'in the X dimension', names(selectedData))
names(selectedData) <- gsub('Y', 'in the Y dimension', names(selectedData))
names(selectedData) <- gsub('Z', 'in the Z dimension', names(selectedData))
names(selectedData) <- gsub('[Gg]ravity', ' Gravity ', names(selectedData))
names(selectedData) <- gsub('Gyro', 'Gyroscope ', names(selectedData))
names(selectedData) <- gsub('BodyBody', 'Body ', names(selectedData))
names(selectedData) <- gsub('Body', 'Body ', names(selectedData))
names(selectedData) <- gsub('Jerk', 'Jerk ', names(selectedData))
names(selectedData) <- gsub('Mag', 'Magnitude ', names(selectedData))
names(selectedData) <- gsub('MeanGravity', 'Mean Gravity ', names(selectedData))
names(selectedData) <- gsub('anglein', 'angle in', names(selectedData))
names(selectedData) <- gsub('angletBody', 'angle Time Body', names(selectedData))
names(selectedData) <- gsub('  ', ' ', names(selectedData))

#define activity variables
names(selectedData)[2] = "activity_List"

#creating the relevant output table
outputTable <- selectedData %>%
  group_by(subject, activity_List) %>% #groups into subjects and activities
  summarise_all(list(mean)) #determines the mean of each

#writing the actual file
write.table(outputTable, "outputFile.txt", row.name=FALSE)

#read out the resulting file
read.table('outputFile.txt')

