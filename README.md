## README

This repository contains scripts used to import, clean and analyze the UCI HAR dataset.  They were developed as part of the Coursera Getting Data course's final project.  For more information on the project and the dataset it uses, please see "CodeBook.md".

The assigned task was to create a script which:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The assigned tasks were completed with two scripts:

* run_analysis.R -- the main script
* filepaths.R -- a script called by run_analysis.R which generates the filepaths neccesary to import and merge the data

#### **Usage instructions**
Download the two scripts to your working directory and run:

    > source("run_analysis.R")

If you have a working internet connection, the script will attempt to download the dataset automatically.  Otherwise, you should download [UCI_HAR_Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) manually, and place it in a folder called 'data' created in your working directory.

The output of the script is a tabular text file called "HAR\_meanstd_avg.txt".  Additionally, the original full cleaned dataset and the narrow meanstd dataset are both left in memory in case you would like to run further analysis on either.

#### **Requirements**

* "run_analysis.R" and "filepaths.R" must both be in your working directory
* You must either (a) have a working internet connection or (b) have already manually downloaded the dataset as described in the previous section
* You must have packages dplyr and tidyr installed, the script will try to warn you if it can't find them

The script was developed on a Linux machine, but was written to be platform independent (ie. all filepaths created with file.path() function).

Testing was done in the following environment:
OS: Ubuntu 15.04
Kernel: 3.19.0-58-generic #64-Ubuntu
RStudio: version 0.99.892
R: 3.2.3 (2015-12-10)
dlpyr: version 0.4.3
tidyr: version 0.4.1

#### **run_analysis.R**

In brief, the script performed the following steps:  

1. Downloads the [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) if not found locally
2. Unzips the dataset to a temporary directory if not already found unzipped
3. Reads in and label the _test_ and _train_ datasets
    * Merges _x_, _y_, and _activity_ tables
    * Labeles _subject_ and _activity_ columns accordingly
4. Combines _test_ and _train_ datasets
5. Changes _subject_ and _activity_ columns to factor variables
    * Gives factors human readable labels
6. Assigns variable names for dataset, fixing duplicates
    * The _bandsEnergy_ variables were all missing (xyz) axis labels.  This is fixed using the assumed order (1) x, (2) y, (3) z.
7. Selects only mean() and std() variables and saves to a new dataframe
    * New dataframe is stored as _meanstd_
    * Old dataframe is left in memory as _fulldata_
8. Groups by subject and activity and computed an average for each group
9. Reshapes into a narrow dataset
    * Gathers variables into one one column and converts to factor variable
    * Puts averages for each variable/group in a second new column
10. Exports to the tabular text file: "HAR_meanstd_avg.txt"

For more details, please see comments within the script itself.

#### **filepaths.R**
This script builds a list with file paths to all the neccesary files in the UCI HAR dataset.  It defines the function _filepaths()_ to do this--mostly to save space, but this function could also be used to rebuild the file path lists if any of the directory names are changed.

The returned list is assigned to _filepaths_.  It is a list of 27 character vectors of length 1, where the character vectors contain the filepaths and the corresponding labels contain the file names.

run_analysis.R does not use all of the files in the UCI HAR dataset, but all filepaths are included in case the user wants to import other data.

The script is called automatically by run_analysis.R and there is no need to call it manually.

#### **Contact**

Please direct any questions to Austin Dempewolff at adempewolff@gmail.com
