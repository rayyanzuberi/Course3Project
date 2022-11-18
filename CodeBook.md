Codebook File

1. Data Used
All data was derived from the UCI HAR Dataset.

Data Included
-activity_labels.txt -> activityLabels data table
-features.txt -> features data table
-subject_test.txt -> subjectTest data table
-X_test.txt -> xTest data table
-y_text.txt -> ytest data table
-subject_train.txt -> subjectTrain data table
-X_train.txt -> xTrain data table
-y_train.txt -> ytrain data table

2. Variables and Process
-Because the files in the data are quite large, the col.names parameter is specified
in order to ensure only the wanted columns are extracted. Values from features.txt is used to
extract the relevant features from the testing testing data. In the same way, values from
activityLabels is used to extract infromation from the y dataset.

-data columns are bound together using cbind and rows are bound together using rbind. The
end result is the full collated dataset in the variable combined. The data columns (or rather the names of the columns) are filtered for those that contain either the mean or the standard deviation using the grep command and regex. This leaves the selectedData data table.

-the mean and standard deviation columns are difficult to read. The gsub command is used to make a number of amendments to make these easier to read.

-data from these tables are then grouped by subject and activity label. The mean is then derived for each activity for each of the participants. This table is outputted in the outputTable and the outputFile.txt.

3. Changes made in variable names
gsub is used to make a number of changes to the data.
-First, all dots are removed from the names.
-t is replaced with time
-f and Freq are replaced with Frequency
-Acc replaced with accelerometer
-Gyro replaced with Gyroscope
-BodyBody replaced with Body
-tBody replaced with Time Body
-Mag replaced with Magnitude
-dimension letter replaced with 'in the _ dimension'
-changes to spacing and capitalization to ensure greater clarity

Aside from these changes, no changes were made to the date from the earlier codebook specified by the source material. The source codebook and other helper files such as features_info.txt or features_info.txt or the UCI HAR dataset specific README.txt should be examined for more precise definitions or additional information related to variables.


