#----------------------------------------------------------------
#  Student/Programmer:  Raymond C. Harris
#  Completed:           7/24/2017
#  Assignment GIT Repo: https://github.com/harrisr/CleanDataProgrammingAssignment
#  Code File:           run_analysis.R
#----------------------------------------------------------------
# This blog post within the Week #4 Discussion Forums, by David Hook was very helpful:
#
#  https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
#
#
# Instructions from the Johns Hopkins Week #4 Assignment page:
#
# The purpose of this project is to demonstrate your ability to collect, 
# work with, and clean a data set.
#
# Review criteria
#
# 1.  The submitted data set is tidy.
#
# 2. The Github repo contains the required scripts.
#
# 3. GitHub contains a code book that modifies and updates the available codebooks with 
# the data to indicate all the variables and summaries calculated, 
# along with units, and any other relevant information.
#
# 4. The README that explains the analysis files is clear and understandable.
#
# 5. The work submitted for this project is the work of the student who submitted it.
#
# Getting and Cleaning Data Course Project
#
# The purpose of this project is to demonstrate your ability to collect, work with, 
# and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
# You will be graded by your peers on a series of yes/no questions related to the project. 

# You will be required to submit: 
# 1) a tidy data set as described below, 
# 2) a link to a Github repository with your script for performing the analysis, and 
# 3) a code book that describes the variables, the data, and any transformations or 
# work that you performed to clean up the data called CodeBook.md. You should also 
# include a README.md in the repo with your scripts. 
#
#
# You should create one R script called run_analysis.R that does the following.
#
# 1. Merges the training and the test sets to create one data set.
#
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#
# 3. Uses descriptive activity names to name the activities in the data set
#
# 4. Appropriately labels the data set with descriptive variable names.
#
# 5. From the data set in step 4, creates a second, independent tidy data set with the 
#    average of each variable for each activity and each subject.
# 
# Good luck!
#
#
# Please upload the tidy data set created in step 5 of the instructions. 
#
# Please upload your data set as a txt file created with 
#     write.table()   using row.name=FALSE 
# (do not cut and paste a dataset directly into the text box, 
# as this may cause errors saving your submission).
#
# Please submit a link to a Github repo with the code for performing your analysis. 
# The code should have a file run_analysis.R in the main directory that can be 
# run as long as the Samsung data is in your working directory. 
# The output should be the tidy data set you submitted for part 1. 
# You should include a README.md in the repo describing how the script works 
# and the code book describing the variables.
# 
# Files included in project:
# 1.  script:             run_analysis.R
# 2.  tidy output data:   tidy_output_data.txt
# 3.  readme:             README.md
# 4.  codebook:           codebook.md
# 5.  misc info:          features_info.txt / readme.txt
# 5.  raw data:           activity_labels.txt
#                         features.txt
#                         X_train.txt
#                         y_train.txt
#                         Subject_train.txt
#                         X_test.txt
#                         y_test.txt
#                         Subject_test.txt
#----------------------------------------------------------------

#install.packages("data.table")
#install.packages("reshape2")

library(data.table)
library(reshape2)


display_info <- function(obj) {
  message(typeof(obj))
  message(dim(obj))
  message(head(obj))
}

# when you would download and run this script, you would necessarily change this
# to be your actual local subdirectory...
#setwd("C:\\myfiles\\coursera_datasci\\CleanDataProgrammingAssignment")

# read in the activity labels (e.g. 1 WALKING; 4 SITTING, etc...)

activity_names <- fread("activity_labels.txt", col.names = c("activity_num", "activity_name"))
head(activity_names)


# read in the features (e.g. 1 tBodyAcc-mean()-X; 2 tBodyAcc-mean()-Y; 3 tBodyAcc-mean()-Z, etc...)

feature_names <- fread("features.txt", col.names = c("feature_num", "feature_name"))


# extract the index numbers of only the MEAN/STD features the instructions mentioned

necessary_features <- grep("(mean|std)\\(\\)", feature_names[, feature_name])


# create a list of feature names, based on the previous subset selection

feature_list <- feature_names[necessary_features, feature_name]


# remove the ugly parentheses from the feature names

feature_list <- gsub('[()]', '', feature_list)




# read in the TRAIN measurement data, but only the STD/MEAN columns as specified
# the "column names" are "V1 / V2 etc..." which is not useful

train_measurements <- fread("X_train.txt")[, necessary_features, with = FALSE]

# replace the "column names" with the MEANINGFUL names we scrubbed

data.table::setnames(train_measurements, colnames(train_measurements), feature_list)

# read in the activity numbers the correspond with the labels
# we read in earlier (e.g. 1 WALKING; 4 SITTING, etc...)

train_activities <- fread("y_train.txt", col.names = c("activity"))

# read in the numbers of the human test subjects (1 thru 30)

train_subjects <- fread("subject_train.txt", col.names = c("subject_num"))

train_data <- cbind(train_subjects, train_activities, train_measurements)
display_info(train_data)


# read in the TEST measurement data, but only the STD/MEAN columns as specified
# the "column names" thus far were "V1 / V2 etc..." which is useless

test_measurements <- fread("X_test.txt")[, necessary_features, with = FALSE]

# replace the "column names" with the MEANINGFUL names we scrubbed

data.table::setnames(test_measurements, colnames(test_measurements), feature_list)

# read in the activity numbers the correspond with the labels
# we read in earlier (e.g. 1 WALKING; 4 SITTING, etc...)

test_activities <- fread("y_test.txt", col.names = c("activity"))

# read in the numbers of the human test subjects (1 thru 30)

test_subjects <- fread("subject_test.txt", col.names = c("subject_num"))

test_data <- cbind(test_subjects, test_activities, test_measurements)
display_info(test_data)


# now  ** SMUSH TOGETHER ** the two sets of data
combined_data <- rbind(train_data, test_data)

# right now the data looks something like this:
#combined_data
#   subject_num activity tBodyAcc-mean-X tBodyAcc-mean-Y tBodyAcc-mean-Z
#1:           1        5       0.2885845     -0.02029417     -0.13290514
#2:           1        5       0.2784188     -0.01641057     -0.12352019
#str(combined_data)
#Classes 'data.table' and 'data.frame':	10299 obs. of  68 variables:
#$ subject_num              : int  1 1 1 1 1 1 1 1 1 1 ...
#$ activity                 : int  5 5 5 5 5 5 5 5 5 5 ...
#$ tBodyAcc-mean-X          : num  0.289 0.278 0.28 0.279 0.277 ...
#$ tBodyAcc-mean-Y          : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
#$ tBodyAcc-mean-Z          : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...


# we need to convert the activity number to the activity name to be more readable
# convert the "activity" into a factor

combined_data[["activity"]] <- factor(
                                  combined_data[, activity]
                                  , levels = activity_names[["activity_num"]]
                                  , labels = activity_names[["activity_name"]]
                                 )

# ** now ** the data looks something like this:
#combined_data
#   subject_num         activity tBodyAcc-mean-X tBodyAcc-mean-Y tBodyAcc-mean-Z
#1:           1         STANDING       0.2885845     -0.02029417     -0.13290514
#2:           1         STANDING       0.2784188     -0.01641057     -0.12352019
#10295:      24 WALKING_UPSTAIRS       0.3101546     -0.05339125     -0.09910872
#str(combined_data)
#Classes 'data.table' and 'data.frame':	10299 obs. of  68 variables:
#$ subject_num              : int  1 1 1 1 1 1 1 1 1 1 ...
#$ activity                 : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 5 5 5 5 5 5 5 5 5 5 ...
#$ tBodyAcc-mean-X          : num  0.289 0.278 0.28 0.279 0.277 ...
#$ tBodyAcc-mean-Y          : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...



# now the instructions say to :
# create an independent tidy data set with:
# the average of each variable, for each activity, and each subject.

# convert the "subject_num" into a factor

combined_data[["subject_num"]] <- as.factor(combined_data[, subject_num])

#> str(combined_data)
#Classes 'data.table' and 'data.frame':	10299 obs. of  68 variables:
#$ subject_num              : Factor w/ 30 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
#$ activity                 : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 5 5 5 5 5 5 5 5 5 5 ...
#$ tBodyAcc-mean-X          : num  0.289 0.278 0.28 0.279 0.277 ...
#$ tBodyAcc-mean-Y          : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...

combined_data <- reshape2::melt(data = combined_data, id = c("subject_num", "activity"))

#str(combined_data)
#Classes 'data.table' and 'data.frame':	679734 obs. of  4 variables:
#$ subject_num: Factor w/ 30 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
#$ activity   : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 5 5 5 5 5 5 5 5 5 5 ...
#$ variable   : Factor w/ 66 levels "tBodyAcc-mean-X",..: 1 1 1 1 1 1 1 1 1 1 ...
#$ value      : num  0.289 0.278 0.28 0.279 0.277 ...
#combined_data
#subject_num         activity                 variable      value
#1:           1         STANDING          tBodyAcc-mean-X  0.2885845
#2:           1         STANDING          tBodyAcc-mean-X  0.2784188
#3:           1         STANDING          tBodyAcc-mean-X  0.2796531
#4:           1         STANDING          tBodyAcc-mean-X  0.2791739
#5:           1         STANDING          tBodyAcc-mean-X  0.2766288
#---                                                                 
#679730:          24 WALKING_UPSTAIRS fBodyBodyGyroJerkMag-std -0.6188288
#679731:          24 WALKING_UPSTAIRS fBodyBodyGyroJerkMag-std -0.5925070
#679732:          24 WALKING_UPSTAIRS fBodyBodyGyroJerkMag-std -0.6179484
#679733:          24 WALKING_UPSTAIRS fBodyBodyGyroJerkMag-std -0.6549599
#679734:          24 WALKING_UPSTAIRS fBodyBodyGyroJerkMag-std -0.6252073


combined_data <- reshape2::dcast(data=combined_data, subject_num+activity ~ variable, fun.aggregate=mean)


#str(combined_data)
#'data.frame':	180 obs. of  68 variables:
#$ subject_num              : Factor w/ 30 levels "1","2","3","4",..: 1 1 1 1 1 1 2 2 2 2 ...
#$ activity                 : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 1 2 3 4 5 6 1 2 3 4 ...
#$ tBodyAcc-mean-X          : num  0.277 0.255 0.289 0.261 0.279 ...
#$ tBodyAcc-mean-Y          : num  -0.01738 -0.02395 -0.00992 -0.00131 -0.01614 ...
#$ tBodyAcc-mean-Z          : num  -0.1111 -0.0973 -0.1076 -0.1045 -0.1106 ...

#combined_data
#subject_num           activity tBodyAcc-mean-X tBodyAcc-mean-Y
#1             1            WALKING       0.2773308    -0.017383819
#2             1   WALKING_UPSTAIRS       0.2554617    -0.023953149
#3             1 WALKING_DOWNSTAIRS       0.2891883    -0.009918505
#4             1            SITTING       0.2612376    -0.001308288
#5             1           STANDING       0.2789176    -0.016137590
#6             1             LAYING       0.2215982    -0.040513953
#7             2            WALKING       0.2764266    -0.018594920
#8             2   WALKING_UPSTAIRS       0.2471648    -0.021412113
#9             2 WALKING_DOWNSTAIRS       0.2776153    -0.022661416
#10            2            SITTING       0.2770874    -0.015687994
#11            2           STANDING       0.2779115    -0.018420827
#12            2             LAYING       0.2813734    -0.018158740
#13            3            WALKING       0.2755675    -0.017176784
#14            3   WALKING_UPSTAIRS       0.2608199    -0.032410941
#tBodyAcc-mean-Z tBodyAcc-std-X tBodyAcc-std-Y tBodyAcc-std-Z
#1       -0.11114810   -0.283740259    0.114461337    -0.26002790
#2       -0.09730200   -0.354708025   -0.002320265    -0.01947924
#3       -0.10756619    0.030035338   -0.031935943    -0.23043421



data.table::fwrite(x=combined_data, file="tidy_output_data.txt", quote=FALSE)


verify_tidy_data <- fread("tidy_output_data.txt")
head(verify_tidy_data)
