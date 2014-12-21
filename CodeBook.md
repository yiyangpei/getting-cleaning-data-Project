## Codebook 

This is a codebook decribes how to clean up the original data to obtain the tidy data set required for the course project.  


### Original data
The original data can be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The description of the original data can be found
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


### Steps to clean up the original data as coded in run_analysis.R

* Merges the training and the test sets to create one data set.

The step reads the following data from the downloaded orignial data: subject_test.txt, y_test.txt, X_test.txt, subject_train, y_train.txt, X_train.txt. 
It then merges them according to the following format.

Column 1      | Column 2     | Column 3-563 (561 features)
------------- | -------------| -------------
subject_train | y_train | X_train
subject_test  | y_test  | X_test

The result "data"" is a data frame of dimension 10299 x 563.

* Extracts only the measurements on the mean and standard deviation for each measurement. 

The step reads feature.txt file and extracts the features that contains either "mean(" or "std(".
It then extracts from "data" the following columns: column 1, column 2, 66 columns from col 3-561 that contains the selected features. 

The result "data_mean_std" is a data frame of dimension 10299 x 68.


* Uses descriptive activity names to name the activities in the data set.

The step replaces the integer values in Column 2 with the following descriptive values:

1 WALKING

2 WALKING_UPSTAIRS

3 WALKING_DOWNSTAIRS

4 SITTING

5 STANDING

6 LAYING



* Appropriately labels the data set with descriptive variable names. 
This step labels column 1 and 2 as "Subject" and "Acitivity". 
The rest of the columns according to the extracted feature names. Remove the parenthesis in the feature names
 


* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Tidy data set

The tidy data set "data_tidy" contains a data fame of dimension 180 x 68. 

* Column 1: 

Subject: An identifier of the subject who carried out the experiment. It ranges from 1 to 30.

* Column 2: 

Activity: The acitivity performed by the subject. It contains the following six values: 
        WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING. 

* Column 3-68: 

Feature variables. The values are bounded within [-1,1]. Interpretation of the feature variables are as follows: 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean: Mean value
std: Standard deviation

Note that mean and std in the final tidy data set is alsoaveraged over different observations. 
