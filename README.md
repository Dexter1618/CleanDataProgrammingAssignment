#Getting and Cleaning Data : Programming Assignment

By: Raymond C. Harris

#Purpose

Demonstrate our ability to collect, work with, and clean a data set.

# Review criteria

1. The submitted data set is tidy.

2. The Github repo contains the required scripts.

3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.

4. The README that explains the analysis files is clear and understandable.

5. The work submitted for this project is the work of the student who submitted it.

#Description of the Project

The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. 

#Required Submissions

1) a tidy data set as described below, 

2) a link to a Github repository with your script for performing the analysis, and 

3) a code book that describes the variables, the data, and any transformations or 
work that you performed to clean up the data called CodeBook.md. You should also 
include a README.md in the repo with your scripts. 

#Source of the original Raw Data

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#R Script file description (run_analysis.R)

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Good luck!
    

#Miscellaneous Information

##Minimum information required in the codebook:

1. Information about the variables (including units!) in the data set 
   not contained in the tidy data

2. Information about the summary choices you made

3. Information about the experimental study design you used


##Principies of the "tidy dataset" (by Hadley Wickham):

1. Each variable you measure should be in one column

2. Each different observation of that variable should be in a different row

3. There should be one table for each "kind" of variable

4. If you have multiple tables, they should include a column in the table 
   that allows them to be joined or merged

#Miscellaneous Background (from the course project description)

One of the most exciting areas in all of data science right now is wearable computing - see for example this article:

http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/

Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


