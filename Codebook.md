# Project Codebook

## Description of the study: who did it, why they did it, how they did it.
### The scientists and labs
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)  
1 - Smartlab - Non-Linear Complex Systems Laboratory  
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy.   
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living  
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain  
activityrecognition '@' smartlab.ws  

### The purpose of the study
One of the big areas for data analysis at the moment is within the wearables domain, particularly fitness/health wearables. Manufacturers are competing to develop not just the most accurate measurements, but also the best predictive algorithms. By being able to accurately identify the type of activity and the position of the user, manufacturers can use this information to provide new analysis and new features.

These scientists donated this data set to the University of California, Irvine (UCI) for public use.[1]

## Sampling information: what was the population studied, how was the sample drawn, what was the response rate.
As taken from the study's homepage[1]:
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain." 

## Technical information about the files themselves: number of observations, record length, number of records per observation, etc.
The test and training sets were drawn from the same original observations, so have the same structure.
X_test.txt has 2947 rows, each with 561 different measurements.
y_test.txt has 2947 rows, each with one numeric code (the activity).
subject_test.txt has 2947 rows, each with one numeric identifier (the user).

X_train.txt has 7352 rows, each with the same 561 different measurements as the test set.
y_train.txt has 7352 rows, each with one numeric code (the activity).
subject_train.txt has 7352 rows, each with one numeric identifier (the user).

The Inertial Signals folders and files in the "test" and "train" folders are not used, so are not documented here.

There are also two common files used across both sets of data.
activity_labels.txt has six rows, with the first column being the numeric activity code and the second column being a string with the activity name.
features.txt has 561 rows, with the first column being the numeric feature code and the second column being a string with the feature name.

The output file, final_tidy.txt, has 180 rows and 68 columns, not including headers. The remainder of this codebook will focus on the output file only.

## Structure of the data within the (output) file: hierarchical, multiple cards, etc.
The output file is ultimately represented as a single flat file, where each row lists the 66 means of the relevant measurements for one user-activity combination.
Logically, because the first six rows all relate to user 1, the next six rows to user 2, and so on, the data could easily be redisplayed in a hierarchical format.

## Details about the (output) data: columns in which specific variables can be found, whether they are character or numeric, and if numeric, what format.

Note: Body acceleration is defined as total acceleration minus the acceleration due to gravity.
Note: Jerk is a change in acceleration, calculated as the derivative of the original measurement. For example, BodyAccJerk is the derivative of BodyAcc (in _g_), and BodyGyroJerk is the derivative of BodyGyro (in rad/_s_)

Column | Variable Name | Range | Units | Aggregation method in the output file | Description of the original measurement
-------|---------------|-------|-------|-------------|-----------------------------------------------------------|
1      | subject       |  1-30 | (none)| group by    | A numeric identifier for each user in the study.
2      | activity      | (1-6) | (none)| group by    | A string representing one of six possible activities tracked in the study. Each string is also associated with a numeric code, given here, which is used for cross-referencing the data. Note that only the full string factor is within the file.
       |               | (1)   | (none)| | LAYING
       |               | (2)   | (none)| |SITTING
       |               | (3)  | (none)| | STANDING
       |               | (4)   | (none)| | WALKING
       |               | (5)   | (none)| | WALKING_DOWNSTAIRS
       |               | (6)   | (none)| | WALKING_UPSTAIRS
3      | tBodyAcc.mean.X | [-1,1] | _g_, standard gravity units | average | The mean of body acceleration along the X-axis in the time domain
4      | tBodyAcc.mean.Y	| [-1,1] | _g_ | average | The mean of body acceleration along the Y-axis in the time domain
5| tBodyAcc.mean.Z	| [-1,1] | _g_ | average | The mean of body acceleration along the Z-axis in the time domain
6| tBodyAcc.std.X	| [-1,1] | _g_ | average | The standard deviation of body acceleration along the X-axis in the time domain
7| tBodyAcc.std.Y	| [-1,1] | _g_ | average | The standard deviation of body acceleration along the Y-axis in the time domain
8| tBodyAcc.std.Z	| [-1,1] | _g_ | average | The standard deviation of body acceleration along the Z-axis in the time domain
9| tGravityAcc.mean.X	| [-1,1] | _g_ | average | The mean of gravitational acceleration along the X-axis in the time domain
10| tGravityAcc.mean.Y | [-1,1] | _g_ | average | The mean of gravitational acceleration along the Y-axis in the time domain	
11| tGravityAcc.mean.Z| [-1,1] | _g_ | average | The mean of gravitational acceleration along the Z-axis in the time domain	
12| tGravityAcc.std.X	| [-1,1] | _g_ | average | The standard deviation of gravitational acceleration along the X-axis in the time domain	
13| tGravityAcc.std.Y	| [-1,1] | _g_ | average | The standard deviation of gravitational acceleration along the Y-axis in the time domain	
14| tGravityAcc.std.Z	| [-1,1] | _g_ | average | The standard deviation of gravitational acceleration along the Z-axis in the time domain	
15| tBodyAccJerk.mean.X	| [-1,1] | _g_ | average | The mean of body acceleration jerk along the X-axis in the time domain
16| tBodyAccJerk.mean.Y	| [-1,1] | _g_ | average | The mean of body acceleration jerk along the Y-axis in the time domain	
17| tBodyAccJerk.mean.Z	| [-1,1] | _g_ | average | The mean of body acceleration jerk along the Z-axis in the time domain	
18| tBodyAccJerk.std.X	| [-1,1] | _g_ | average | The standard deviation of body acceleration jerk along the X-axis in the time domain	
19| tBodyAccJerk.std.Y	| [-1,1] | _g_ | average | The standard deviation of body acceleration jerk along the Y-axis in the time domain	
20| tBodyAccJerk.std.Z	| [-1,1] | _g_ | average | The standard deviation of body acceleration jerk along the Z-axis in the time domain	
21| tBodyGyro.mean.X	| [-1,1] | rad/_s_ | average | The mean of body angular momentum along the X-axis in the time domain	
22| tBodyGyro.mean.Y	| [-1,1] | rad/_s_ | average | The mean of body angular momentum along the Y-axis in the time domain
23 |tBodyGyro.mean.Z	| [-1,1] | rad/_s_ | average | The mean of body angular momentum along the Z-axis in the time domain
24| tBodyGyro.std.X	 | [-1,1] | rad/_s_ | average | The standard deviation of body angular momentum along the X-axis in the time domain
25| tBodyGyro.std.Y	| [-1,1] | rad/_s_ | average | The standard deviation of body angular momentum along the Y-axis in the time domain
26| tBodyGyro.std.Z	| [-1,1] | rad/_s_ | average | The standard deviation of body angular momentum along the Z-axis in the time domain
27| tBodyGyroJerk.mean.X	| [-1,1] | rad/_s_ | average | The mean of body angular momentum jerk along the X-axis in the time domain
28| tBodyGyroJerk.mean.Y	| [-1,1] | rad/_s_ | average | The mean of body angular momentum jerk along the Y-axis in the time domain
29| tBodyGyroJerk.mean.Z	| [-1,1] | rad/_s_ | average | The mean of body angular momentum jerk along the Z-axis in the time domain
30| tBodyGyroJerk.std.X	| [-1,1] | rad/_s_ | average | The standard deviation of body angular momentum jerk along the X-axis in the time domain
31| tBodyGyroJerk.std.Y	| [-1,1] | rad/_s_ | average | The standard deviation of body angular momentum jerk along the Y-axis in the time domain
32| tBodyGyroJerk.std.Z	| [-1,1] | rad/_s_ | average | The standard deviation of body angular momentum jerk along the Z-axis in the time domain
33| tBodyAccMag.mean()	| [-1,1] | rad/_s_ | average | The mean of the magnitude of body acceleration in the time domain
34| tBodyAccMag.std()	| [-1,1] | rad/_s_ | average | The standard deviation of the magnitude of body acceleration in the time domain
35| tGravityAccMag.mean()	| [-1,1] | _g_ | average | The mean of the magnitude of gravitational acceleration in the time domain
36| tGravityAccMag.std()	| [-1,1] | _g_ | average | The standard deviation of the magnitude of gravitational acceleration in the time domain
37| tBodyAccJerkMag.mean()	| [-1,1] | _g_ | average | The mean of the magnitude of body acceleration jerk in the time domain
38| tBodyAccJerkMag.std()	| [-1,1] | _g_ | average | The standard deviation of the magnitude of body acceleration jerk in the time domain
39| tBodyGyroMag.mean()	| [-1,1] | rad/_s_ | average | The mean of the magnitude of body angular momentum in the time domain
40| tBodyGyroMag.std()	| [-1,1] | rad/_s_ | average | The standard deviation of the magnitude of body angular momentum in the time domain
41| tBodyGyroJerkMag.mean()	| [-1,1] | rad/_s_ | average | The mean of the magnitude of body angular momentum jerk in the time domain
42| tBodyGyroJerkMag.std()	| [-1,1] | rad/_s_ | average | The standard deviation of the magnitude of body angular momentum jerk in the time domain
43| fBodyAcc.mean.X	| [-1,1] | _g_ | average | The mean of body acceleration along the X-axis in the frequency domain
44| fBodyAcc.mean.Y	| [-1,1] | _g_ | average | The mean of body acceleration along the Y-axis in the frequency domain
45| fBodyAcc.mean.Z	| [-1,1] | _g_ | average | The mean of body acceleration along the Z-axis in the frequency domain
46| fBodyAcc.std.X	| [-1,1] | _g_ | average | The standard deviation of body acceleration along the X-axis in the frequency domain
47| fBodyAcc.std.Y	| [-1,1] | _g_ | average | The standard deviation of body acceleration along the Y-axis in the frequency domain
48| fBodyAcc.std.Z	| [-1,1] | _g_ | average | The standard deviation of body acceleration along the Z-axis in the frequency domain
49| fBodyAccJerk.mean.X	| [-1,1] | _g_ | average | The mean of body acceleration jerk along the X-axis in the frequency domain
50| fBodyAccJerk.mean.Y	| [-1,1] | _g_ | average | The mean of body acceleration jerk along the Y-axis in the frequency domain
51| fBodyAccJerk.mean.Z	| [-1,1] | _g_ | average | The mean of body acceleration jerk along the Z-axis in the frequency domain
52| fBodyAccJerk.std.X	| [-1,1] | _g_ | average | The standard deviation of body acceleration jerk along the X-axis in the frequency domain
53| fBodyAccJerk.std.Y	| [-1,1] | _g_ | average | The standard deviation of body acceleration jerk along the Y-axis in the frequency domain
54| fBodyAccJerk.std.Z	| [-1,1] | _g_ | average | The standard deviation of body acceleration jerk along the Z-axis in the frequency domain
55| fBodyGyro.mean.X	| [-1,1] | rad/_s_ | average | The mean of body angular momentum along the X-axis in the frequency domain
56| fBodyGyro.mean.Y	| [-1,1] | rad/_s_ | average | The mean of body angular momentum along the Y-axis in the frequency domain
57| fBodyGyro.mean.Z	| [-1,1] | rad/_s_ | average | The mean of body angular momentum along the Z-axis in the frequency domain
58| fBodyGyro.std.X	| [-1,1] | rad/_s_ | average | The standard deviation of body angular momentum along the X-axis in the frequency domain
59| fBodyGyro.std.Y	| [-1,1] | rad/_s_ | average | The standard deviation of body angular momentum along the Y-axis in the frequency domain
60| fBodyGyro.std.Z	| [-1,1] | rad/_s_ | average | The standard deviation of body angular momentum along the Z-axis in the frequency domain
61| fBodyAccMag.mean()	| [-1,1] | _g_ | average | The mean of the magnitude of body acceleration in the frequency domain
62| fBodyAccMag.std()	| [-1,1] | _g_ | average | The standard deviation of the magnitude of body acceleration in the frequency domain
63| fBodyBodyAccJerkMag.mean()	| [-1,1] | _g_ | average | The mean of the magnitude of body acceleration jerk in the frequency domain
64| fBodyBodyAccJerkMag.std()	| [-1,1] | _g_ | average | The standard deviation of the magnitude of body acceleration jerk in the frequency domain
65| fBodyBodyGyroMag.mean()	| [-1,1] | rad/_s_ | average | The mean of the magnitude of body angular momentum in the frequency domain
66| fBodyBodyGyroMag.std()	| [-1,1] | rad/_s_ | average | The standard deviation of the magnitude of body angular momentum in the frequency domain
67| fBodyBodyGyroJerkMag.mean()	| [-1,1] | rad/_s_ | average | The mean of the magnitude of body angular momentum jerk in the frequency domain
68| fBodyBodyGyroJerkMag.std() | [-1,1] | rad/_s_ | average | The standard deviation of the magnitude of body angular momentum jerk in the frequency domain


[1] [UCI Study homepage](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)         Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
