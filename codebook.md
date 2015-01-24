The mean_output.txt file is the output of run_analysis() function in run_analysis.R.
The run_analysis() function processes the UCI HAR dataset from following URL as 
instructed in the assignment: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The mean_output.txt contains 81 columns of 180 rows of data. The means of each colums
are described below.

1.subjects: indicates the id of test subjects from the origin dataset. range from 1 to 30.

2.activity: the activities of the proformed actitivies while the data was obtained.
        including six factors: WALKING,WALKING_UPSTAIRS,WALKING_DOWNSTAIRS, SITTING, STANDING,LAYING

3-81: indicate the mean value of 79 variables for each actitivy, subject by subject.
        the variables include the estimated mean(.mean) and the standard deviation(.str) of every 
        feature vectors from the original dataset as listed below (the -XYZ stands for 3-axial directions
        of the measured signals as describled in the original dataset).

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
