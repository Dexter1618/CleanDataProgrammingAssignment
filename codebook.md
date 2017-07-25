#Study design

How the data was collected:

The data in this programming assignment was downloaded from this URL:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original ZIP file was unzipped, and only the necessary raw data files were extracted from the nested subdirectory structure, and placed into this one top-level project subdirectory

#Code book

##Description of the original raw data files


##FEATURES_INFO.TXT

Describes all the data that was collected in the study


##README.TXT

Describes *how* all the data that was collected in the study.  Also describes all the raw data files.

##ACTIVITY_LABELS.TXT

Contains the "legend" for translating the numeric "activity numbers" into meaningful activity names

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

##FEATURES.TXT

Contains the features that data was collected for, in the X, Y and Z axes.  For example:

1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y
3 tBodyAcc-mean()-Z
4 tBodyAcc-std()-X
5 tBodyAcc-std()-Y
6 tBodyAcc-std()-Z
10 tBodyAcc-max()-X
11 tBodyAcc-max()-Y
12 tBodyAcc-max()-Z
13 tBodyAcc-min()-X
14 tBodyAcc-min()-Y
15 tBodyAcc-min()-Z
41 tGravityAcc-mean()-X
42 tGravityAcc-mean()-Y
43 tGravityAcc-mean()-Z

##X_train.txt: 

Training set

##y_train.txt: 

Training labels

##X_test.txt: 

Test set

##y_test.txt: 

Test labels

##subject_train.txt: 
##subject_test.txt: 

Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30


#Data Merging and Cleansing Methodology

1. Merged all the ACTIVITY / FEATURE / SUBJECT / TRAIN data into one data set

2. Merged all the ACTIVITY / FEATURE / SUBJECT / TEST data into one data set

3. Filtered out and retained only the measurements regarding the mean and standard deviation for each measurement

4. Replaced the meaningless feature numbers with meaningful names

5. Scrubbed the measurement names to be a little more readable (took out parentheses)

6. Merged the shiny new meaningful TEST and TRAIN data into one large dataset

7. Replaced the meaningless activity numbers with meaningful names

8. Converted the activities and features and measurements into factors so data could be transformed

9. Reshape the data into long lists, so means and standard deviations could be performed on all the measurements

10. Reshape the data into a collapsed and wide *NEW* tidy data set with the average of each variable for each activity and each subject

11. Read in the new tidy dataset ane examine it to ensure it really was saved in the desired format
