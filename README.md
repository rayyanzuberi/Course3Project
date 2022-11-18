# Course3Project

In this repository data is derived from the data.zip file. This file is unzipped
to give the UCI HAR dataset in the run_analysis.R script. This script includes
provisions for accessing all of the data, reading all files into R using the 
R read.table() function, and then binding these files together. The column names
are then cleaned using the gsub() command. Lastly, data is grouped and the mean
of all values for each subject for each activity is returned.