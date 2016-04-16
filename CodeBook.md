#**Codebook**
###Getting Data Final Project
####Austin Dempewolff - adempewolff@gmail.com

----------------------------------------------------------------------------------------------------------

###**Table of Contents**
1. Introduction
2. Study Design: The Original Experiment and Dataset
3. Data Preparation, Cleaning, Analysis and Reshaping
4. Codebook: Variables and Structure of Final Dataset
5. Data Source

----------------------------------------------------------------------------------------------------------

###**1. Introduction**
As a final project for the Coursera Getting Data course, data from the UCI HAR Dataset was

1. acquired
2. imported into R
3. cleaned and labelled accordingly
4. subjected a subset of the data to a basic analysis (averages by group)
5. made narrow
6. exported to a tabular text file

The original dataset comes from a Smartlab experiment at the University of Genoa where 30 volunteers conducted 6 different activites while wearing a smartphone with a built in accelerometer and gyroscope. Measurements on all 3 axises were collected from these devices and a number of estimates where the calculated--all of which was then assembled into the UCI HAR dataset.

After importing and cleaning the dataset, I took the mean and standard deviation values for each measurement and calculated average values for each participant and each activity.  The resulting dataset is the subject of this codebook.

----------------------------------------------------------------------------------------------------------

###**2. Study Design: The Original Experiment and Dataset:**

In the words of the original researchers:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
> 
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 
> 
> For each record it is provided:
> 
> - Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
> - Triaxial Angular velocity from the gyroscope. 
> - A 561-feature vector with time and frequency domain variables. 
> - Its activity label. 
> - An identifier of the subject who carried out the experiment.

features_info.txt:

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and > tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they > were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to > remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals > (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
> 
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using > the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
> 
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, > fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
> 
> These signals were used to estimate variables of the feature vector for each pattern:  
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
> 
> tBodyAcc-XYZ
> tGravityAcc-XYZ
> tBodyAccJerk-XYZ
> tBodyGyro-XYZ
> tBodyGyroJerk-XYZ
> tBodyAccMag
> tGravityAccMag
> tBodyAccJerkMag
> tBodyGyroMag
> tBodyGyroJerkMag
> fBodyAcc-XYZ
> fBodyAccJerk-XYZ
> fBodyGyro-XYZ
> fBodyAccMag
> fBodyAccJerkMag
> fBodyGyroMag
> fBodyGyroJerkMag
> 
> The set of variables that were estimated from these signals are: 
> 
> mean(): Mean value
> std(): Standard deviation
> mad(): Median absolute deviation 
> max(): Largest value in array
> min(): Smallest value in array
> sma(): Signal magnitude area
> energy(): Energy measure. Sum of the squares divided by the number of values. 
> iqr(): Interquartile range 
> entropy(): Signal entropy
> arCoeff(): Autorregresion coefficients with Burg order equal to 4
> correlation(): correlation coefficient between two signals
> maxInds(): index of the frequency component with largest magnitude
> meanFreq(): Weighted average of the frequency components to obtain a mean frequency
> skewness(): skewness of the frequency domain signal 
> kurtosis(): kurtosis of the frequency domain signal 
> bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
> angle(): Angle between to vectors.
> 
> Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
> 
> gravityMean
> tBodyAccMean
> tBodyAccJerkMean
> tBodyGyroMean
> tBodyGyroJerkMean

----------------------------------------------------------------------------------------------------------

###**3. Data Preparation, Cleaning, Analysis and Reshaping:**

The data was downloaded, imported, cleaned, analyzed, reshaped and exported using the script run\_analysis.R which is described in detail in the file README.md.  The script was run on an Ubuntu 15.04 system (64bit) in RStudio (Version 0.99.892) using R version 3.2.3 (2015-12-10).  The script uses the _dlpyr_ (version 0.4.3) and _tidy_ (version 0.4.1) packages.

In brief, the script performed the following steps:  

1. Downloaded the [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) if not found locally
2. Unzipped the dataset to a temporary directory if not already found unzipped
3. Read in and label the _test_ and _train_ datasets
    * Merged _x_, _y_, and _activity_ tables
    * Labeled _subject_ and _activity_ columns accordingly
4. Combined _test_ and _train_ datasets
5. Changed _subject_ and _activity_ columns to factor variables
    * Gave factors human readable labels
6. Assigned variable names for dataset, fixing duplicates
    * The _bandsEnergy_ variables were all missing (xyz) axis labels.  This was fixed using the assumed order (1) x, (2) y, (3) z.
7. Selected only mean() and std() variables and saved to a new dataframe
    * New dataframe is stored as _meanstd_
    * Old dataframe is left in memory as _fulldata_
8. Grouped by subject and activity and computed an average for each group
9. Reshaped into a narrow dataset
    * Gathered variables into one one column and convert to factor variable
    * Put averages for each variable/group in a second new column
10. Exported to the tabular text file: "HAR_meanstd_avg.txt"


----------------------------------------------------------------------------------------------------------

###**4. Codebook: Variables and Structure of Final Dataset**

The exported dataset is narrow and long with four columns:  

1. _subject_
2. _activity_
3. _variable_
4. _mean_

Each row represents the average of all observations of a specific variable for a given subject engaged in a given activity.

####**Column: _subject_**
An integer between 1-30 which is the unique ID for each participant in the experiment

####**Column: _activity_**
Describes which activity the subject was performing for each record.  There are six possible values:

1. "walking"
2. "walking upstairs"
3. "walking downstairs"
4. "sitting"
5. "standing"
6. "laying"

####**Column: _variable_**
One of 66 variables for which a summary statistic (average by group) has been calculated.  There are 17 measurements--8 of which have _x_, _y_ and _z_ components--and each of these has a variable for mean and standard deviation of signals within the sample window ( (8*3 + 9) \* 2 = 66 ). 

#####**Linear Acceleration (_acc_)**  
All acceleration variables were calculated from the Samsung Galaxy S II smartphone's built in accelerometer which provided signal data for all 3 axes (see section 2 for more information on sampling rate and noise filters used).  These raw signals were then separated into body and gravity components using a low pass filter—isolating acceleration due to the subject's movements (body) from the effects of gravity (see section 2 for details).

+ **Body variables**
    + **Time domain variables**  
    Time domain variables (prefixed with “t”) show amplitude of acceleration signal as a function of time.
        + **tbodyacc-XYZ**  
        Means and standard deviations of data representing triaxial body linear acceleration.  
            + _tbodyacc-mean()-x_
            + _tbodyacc-std()-x_
            + _tbodyacc-mean()-y_
            + _tbodyacc-std()-y_
            + _tbodyacc-mean()-z_
            + _tbodyacc-std()-z_
        + **tbodyaccmag**  
        Mean and standard deviation of data representing the three-dimensional magnitude of body linear acceleration.
            + _tbodyaccmag-mean()_
            + _tbodyaccmag-std()_
        + **tbodyaccjerk-XYZ**  
        Means and standard deviations of data representing triaxial jerk derived from triaxial body linear accelerator signals. 
            + _tbodyaccjerk-mean()-x_
            + _tbodyaccjerk-std()-x_
            + _tbodyaccjerk-mean()-y_
            + _tbodyaccjerk-std()-y_
            + _tbodyaccjerk-mean()-z_
            + _tbodyaccjerk-std()-z_
        + **tbodyaccjerkmag**  
        Mean and standard deviation of data representing the three-dimensional magnitude of jerk derived from triaxial body linear acceleration signals.
            + _tbodyaccjerkmag-mean()_
            + _tbodyaccjerkmag-std()_
    + **Frequency domain variables**  
    Frequency domain variables (prefixed with “f”), show amplitude of acceleration signal as a function of frequency.  These signals were obtained by using a Fast Fourier Transform on the corresponding time-domain signals (see section 2 for more details).
        + **fbodyacc-XYZ**  
        Means and standard deviations of frequency domain data representing triaxial body linear acceleration
            + _fbodyacc-mean()-x_
            + _fbodyacc-std()-x_
            + _fbodyacc-mean()-y_
            + _fbodyacc-std()-y_
            + _fbodyacc-mean()-z_
            + _fbodyacc-std()-z_
        + **fbodyaccmag**  
        Means and standard deviations of frequency domain data representing the three-dimensional magnitude of body linear acceleration
            + _fbodyaccmag-mean()_
            + _fbodyaccmag-std()_
        + **fbodyaccjerk-XYZ**  
        Means and standard deviations of frequency domain data representing triaxial jerk derived from triaxial body linear accelerator signals
            + _fbodyaccjerk-mean()-x_
            + _fbodyaccjerk-std()-x_
            + _fbodyaccjerk-mean()-y_
            + _fbodyaccjerk-std()-y_
            + _fbodyaccjerk-mean()-z_
            + _fbodyaccjerk-std()-z_
        + **fbodyaccjerkmag** 
        Mean and standard deviation of frequency domain data representing  the three-dimensional magnitude of jerk derived from triaxial body linear acceleration signals
            + _fbodyaccjerkmag-mean()_
            + _fbodyaccjerkmag-std()_
+ **Gravity Variables**
    + **Time domain variables**  
    (see above)
        + **tgravityacc-XYZ**  
        Means and standard deviations of data representing the portions of triaxial linear acceleration attributed to gravity.
            + _tgravityacc-mean()-x_
            + _tgravityacc-std()-x_
            + _tgravityacc-mean()-y_
            + _tgravityacc-std()-y_
            + _tgravityacc-mean()-z_
            + _tgravityacc-std()-z_
        + **tgravityaccmag**  
        Mean and standard deviation of data representing the three-dimensional magnitude of linear acceleration due to gravity.
            + _tgravityaccmag-mean()_
            + _tgravityaccmag-std()_

#####**Angular velocity (_gyro_)**  
All angular velocity variables were calculated from the Samsung Galaxy S II smartphone's built in gyroscope which provided signal data for all 3 axes (see section 2 for more information on sampling rate and noise filters used).

+ **Body variables**
    + **Time domain variables**  
    Time domain variables (prefixed with “t”) show amplitude of angular velocity signal as a function of time.
        + **tbodygyro-XYZ**  
        Means and standard deviations of data representing triaxial body angular velocity.
            + _tbodygyro-mean()-x_
            + _tbodygyro-std()-x_
            + _tbodygyro-mean()-y_
            + _tbodygyro-std()-y_
            + _tbodygyro-mean()-z_
            + _tbodygyro-std()-z_
        + **tbodygyromag**  
        Mean and standard deviation of data representing the three-dimensional magnitude of body angular velocity
            + _tbodygyromag-mean()_
            + _tbodygyromag-std()_
        + **tbodygyrojerk-XYZ**  
        Means and standard deviations of data representing triaxial jerk derived from triaxial body angular velocity signals. 
            + _tbodygyrojerk-mean()-x_
            + _tbodygyrojerk-std()-x_
            + _tbodygyrojerk-mean()-y_
            + _tbodygyrojerk-std()-y_
            + _tbodygyrojerk-mean()-z_
            + _tbodygyrojerk-std()-z_
        + **tbodygyrojerkmag**  
        Means and standard deviations of data representing the three dimensional magnitude of triaxial jerk derived from triaxial body angular velocity signals.
            + _tbodygyrojerkmag-mean()_
            + _tbodygyrojerkmag-std()_
    + **Frequency domain variables**  
    Frequency domain variables (prefixed with “f”), show amplitude of angular velocity signal as a function of frequency.  These signals were obtained by using a Fast Fourier Transform on the corresponding time-domain signals (see section 2 for more details).
        + **fbodygyro-XYZ**  
        Means and standard deviations of frequency domain data representing triaxial body angular velocity signals.
            + _fbodygyro-mean()-x_
            + _fbodygyro-std()-x_
            + _fbodygyro-mean()-y_
            + _fbodygyro-std()-y_
            + _fbodygyro-mean()-z_
            + _fbodygyro-std()-z_
        + **fbodygyromag**  
        Mean and standard deviation of frequency domain data representing the three-dimensional magnitude of body angular velocity
            + _fbodygyromag-mean()_
            + _fbodygyromag-std()_
        + **fbodygyrojerkmag**  
        Mean and standard deviation of frequency domain data representing the three dimensional magnitude of triaxial jerk derived from triaxial body angular velocity signals.
            + _tbodygyrojerkmag-mean()_
            + _tbodygyrojerkmag-std()_

####**Column: _mean_**
The average calculated for all values of a given variable for a given subject and given activity.  For example, the average of all values of _tbodyaccmag-mean()_ for _subject 23_ when they are _walking_.

As all "features [were] normalized and bounded within [-1,1]" by the authors of the original experiment, the calculated averages should also be bounded within -1 and 1.

----------------------------------------------------------------------------------------------------------

###**5. Data Source**

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012