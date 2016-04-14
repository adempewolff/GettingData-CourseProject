#Codebook
###Getting Data Final Project
####Austin Dempewolff - adempewolff@gmail.com

----------------------------------------------------------------------------------------------------------

##Table of Contents
1. Introduction
2. The Original Experiment and Dataset
3. Data Preparation and Cleaning
4. Variables and Structure of Final Dataset

----------------------------------------------------------------------------------------------------------

##Introduction
As a final project for the Coursera Getting Data course, data from the UCI HAR Dataset was (1) acquired, (2) imported into R, (3) cleaned and labelled according, (4) subjected to a basic analysis to a subset of the data, (5) made narrow and (6) exported to a tabular text file.

The original dataset comes from an Smartlab experiment at the University of Genoa where 30 volunteers conducted 6 different activites while wearing a smartphone with a built in accelerometer and gyroscope. Measurements on all 3 axises were collected from these devices and a number of estimates where the calculated--all of which was then assembled into the UCI HAR dataset.

After importing and cleaning the dataset, I took the mean and standard deviation values for each measurement and calculated average values for each participant and each activity.  The resulting dataset is the subject of this codebook.

----------------------------------------------------------------------------------------------------------

##The Original Experiment and Dataset:

In the words of the original researchers:

>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
>
>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 
>
>For each record it is provided:
>
>- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
>- Triaxial Angular velocity from the gyroscope. 
>- A 561-feature vector with time and frequency domain variables. 
>- Its activity label. 
>- An identifier of the subject who carried out the experiment.

----------------------------------------------------------------------------------------------------------

##Data Preparation and Cleaning:


