## This script builds a list with file paths to all the neccesary files in the 
## UCI HAR dataset.  It uses a function to do this--mostly to save space, but
## this function could also be used to rebuild the file path lists if any of 
## the directory names changed.

filepath <- function(w = 'UCI HAR Dataset', x = 'test', y = 'train',
                     z = 'Inertial Signals') {
               list(root           = file.path(temp,w),
                    activitylabels = file.path(temp,w, 'activity_labels.txt'),
                    features       = file.path(temp,w, 'features.txt'),
                    subjecttest    = file.path(temp,w,x, 'subject_test.txt'),
                    xtest          = file.path(temp,w,x, 'X_test.txt'),
                    ytest          = file.path(temp,w,x, 'y_test.txt'),
                    bodyaccxtest   = file.path(temp,w,x,z, 'body_acc_x_test.txt'),
                    bodyaccytest   = file.path(temp,w,x,z, 'body_acc_y_test.txt'),
                    bodyaccztest   = file.path(temp,w,x,z, 'body_acc_z_test.txt'),
                    bodygyroxtest  = file.path(temp,w,x,z, 'body_gyro_x_test.txt'),
                    bodygyroytest  = file.path(temp,w,x,z, 'body_gyro_y_test.txt'),
                    bodygyroztest  = file.path(temp,w,x,z, 'body_gyro_z_test.txt'),
                    totalaccxtest  = file.path(temp,w,x,z, 'total_acc_x_test.txt'),
                    totalaccytest  = file.path(temp,w,x,z, 'total_acc_y_test.txt'),
                    totalaccztest  = file.path(temp,w,x,z, 'total_acc_z_test.txt'),
                    subjecttrain   = file.path(temp,w,y, 'subject_train.txt'),
                    xtrain         = file.path(temp,w,y, 'X_train.txt'),
                    ytrain         = file.path(temp,w,y, 'y_train.txt'),
                    bodyaccxtrain  = file.path(temp,w,y,z, 'body_acc_x_train.txt'),
                    bodyaccytrain  = file.path(temp,w,y,z, 'body_acc_y_train.txt'),
                    bodyaccztrain  = file.path(temp,w,y,z, 'body_acc_z_train.txt'),
                    bodygyroxtrain = file.path(temp,w,y,z, 'body_gyro_x_train.txt'),
                    bodygyroytrain = file.path(temp,w,y,z, 'body_gyro_y_train.txt'),
                    bodygyroztrain = file.path(temp,w,y,z, 'body_gyro_z_train.txt'),
                    totalaccxtrain = file.path(temp,w,y,z, 'total_acc_x_train.txt'),
                    totalaccytrain = file.path(temp,w,y,z, 'total_acc_y_train.txt'),
                    totalaccztrain = file.path(temp,w,y,z, 'total_acc_z_train.txt')
               )
            }
filepaths <- filepath()