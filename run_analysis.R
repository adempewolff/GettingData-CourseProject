## Script to download, import and tidy the "Human Activity Recognition using
## Smartphones" dataset.
##
## Data Source:
## Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes
## -Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
## Hardware-Friendly Support Vector Machine. International Workshop of Ambient 
## Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
##
## Created by Austin Dempewolff (adempewolff@gmail.com) as part of the Coursera
## "Getting Data" course's final project.

## Load required packages and throw error if not installed.

required <- c("dplyr", "tidyr")
success <- sapply(required, require, character.only = TRUE)
if(!all(success)) {
     stop(paste("Please ensure the following package is installed:", 
                required[!success], "\n", sep = " "))
}
rm(required, success)

## Download and unzip the data (after checking to ensure that it hasn't
## already been downloaded).

path <- file.path('data', 'UCI_HAR_Dataset.zip')
fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if(!dir.exists('data')) { dir.create('data') }
if(!file.exists(path)) {
     print('downloading data, this may take some time')
     download.file(fileurl, destfile = path)
} else { print('zipped data found locally') }
temp <- tempdir()
     unzip(path, exdir = temp)
rm(path, fileurl)

## Create required filepaths and store in list: filepaths
source('reqfiles.R')
rm(temp)
     
## Get variable names
varnames <- read.table(filepaths$features)
varnames <- tolower(varnames$V2)
     
## Define function to read in, merge and label all files for test or train
readin <- function(x) {
     files <- c('x', 'y', 'subject')
     files <- paste(files, x, sep = '')
     output <- lapply(files, function(x) {
          print(paste("Reading in", x))
          tmp <- read.table(filepaths[[x]])
          print('Success')
          tmp
     })
     print('Merging tables')
     names(output[[1]]) <- varnames
     output <- data.frame(output[[3]], output[[2]], output[[1]])
     names(output)[1:2] <- c('subject', 'activity')
     print('Success')
     output
}

# Read in and label data
testdata <- readin('test')
traindata <- readin('train')
rm(varnames)

## combine test & train datasets then wrap in tbl
fulldata <- rbind.data.frame(testdata, traindata)
rm(testdata, traindata)
fulldata <- tbl_df(fulldata)
     
## Change subject & activity to factors and label accordingly
activitylabels <- read.table(filepaths$activitylabels)
fulldata <- mutate(fulldata, subject = factor(subject),
                   activity = factor(activity, labels = activitylabels$V2))

## Select desired variables

## Group by activity and summarize

## Give more readable labels

## Export
     



