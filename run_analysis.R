## Script to download, import and tidy the "Human Activity Recognition using
## Smartphones" dataset. Creates a table which contains the averages for a
## number of variables by activity and subject.  Please see the readme file
## and codebook for more information.
##
## Data Source:
## Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes
## -Ortiz. Human Activity Recognition on Smartphones using a Multiclass 
## Hardware-Friendly Support Vector Machine. International Workshop of Ambient 
## Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
##
## Script written by Austin Dempewolff (adempewolff@gmail.com) as part of the
## Coursera "Getting Data" course's final project.


## Load required packages and throw error if not installed.
required <- c("dplyr", "tidyr")
success <- sapply(required, require, character.only = TRUE)
if(!all(success)) {
     stop(paste("Please ensure the following package is installed:", 
                required[!success], "\n", sep = " "))
}
rm(required, success)


## Download data if not found locally
path <- file.path('data', 'UCI_HAR_Dataset.zip')
fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if(!dir.exists('data')) { dir.create('data') }
if(!file.exists(path)) {
     print('Downloading data, this may take some time...')
     download.file(fileurl, destfile = path)
     print('Success')
} else { print('Zipped data found locally') }
rm(fileurl)


## Unzip to temporary directory if not already done
temp <- tempdir()
if(!dir.exists(file.path(temp, 'UCI HAR Dataset'))) {
     print('Unzipping data...')
     unzip(path, exdir = temp)
     print('Success')
} else {
     print('Using existing unzipped files')
}
rm(path)


## Create required filepaths and store in 'filepaths' (list)
print('Getting filepaths...')
source('filepaths.R')
rm(temp, filepath)
print('Success')

     
## Define function to read in and merge for test or train
readin <- function(x) {
     files <- c('x', 'y', 'subject')
     files <- paste(files, x, sep = '')
     output <- lapply(files, function(x) {
          print(paste('Reading in ', x, '...', sep = ''))
          tmp <- read.table(filepaths[[x]])
          print('Success')
          tmp
     })
     print('Merging tables...')
     output <- data.frame(output[[3]], output[[2]], output[[1]])
     names(output)[1:2] <- c('subject', 'activity')
     print('Success')
     output
}

# Read in and label data
testdata <- readin('test')
traindata <- readin('train')
rm(readin)

## combine test & train datasets then wrap in tbl
print('Combining test and train datasets...')
fulldata <- rbind.data.frame(testdata, traindata)
rm(testdata, traindata)
fulldata <- tbl_df(fulldata)
print('Success')
     
## Change subject & activity to factors and label accordingly
print('Creating factors and labeling...')
activitylabels <- read.table(filepaths$activitylabels)
activitylabels <- tolower(activitylabels$V2)
activitylabels <- sub('_', ' ', activitylabels)
fulldata <- mutate(fulldata, subject = factor(subject),
                   activity = factor(activity, labels = activitylabels))
rm(activitylabels)

## Get variable names, fix duplicate variables (the bandsEnergy columns are all
## missing xyz axis-labels), and label dataset
varnames <- read.table(filepaths$features)
varnames <- tolower(varnames$V2)
xyzseq <- rep(c('-x','-y','-z'), each = 14, times = 3)
counter <- 1
for(i in seq_along(varnames)) {
     if(grepl('bandsenergy()', varnames[i])) {
          varnames[i] <- sub('$', xyzseq[counter], varnames[i])
          counter <- counter + 1
     }
}
varnames <- append(c('subject', 'activity'), varnames)
names(fulldata) <- varnames
rm(counter, i, xyzseq, varnames, filepaths)
print('Success')


## Select desired variables and save to new table
print('Selecting variables...')
meanstd <- select(fulldata, subject, activity, contains('-mean()'), 
                  contains('-std()'))
print('Success')


## Group by activity and summarize
print('Grouping by activity/subject and summarizing...')
meanstd <- group_by(meanstd, subject, activity) %>% summarize_each(funs(mean))
print('Success')


## Make narrow - gather columns 3-68 into a column called "variable"
## and convert to factor variable
tidymeanstd <- gather(meanstd, "variable", "mean", 3:68) %>%
     mutate(variable = factor(variable))


## Export to text file
print('Writing results to HAR_meanstd_strata_avg.txt...')
write.table(tidymeanstd, file ='HAR_meanstd_avg.txt', row.name=FALSE)
print('Success')



