### emargsm's course project for getdata-030, July 2015.
### Assumptions:        file structure is UCI HAR Dataset/test and UCI HAR Dataset/train, etc.
###                     The folder "UCI HAR Dataset" is found in the current working directory
###                     reshape2 is available
### 

start_prep <- function(basedir = getwd()) {
        currdir <- getwd()
        
        ## Because we can assume that the data is in the current working
        ## directory, AND that it is in the same file structure in all
        ## cases, we can explicitly make the path.
        basedir <- paste(currdir,"/UCI Har Dataset/",sep='',collapse='')
        

        #if(is.null(basedir)) {
                #homedir <- "/Users/msmith"
                #homedir <- "C:/Users/emargsm/"
                #dropdir <- "Dropbox/Coursera/getdata-030/UCI Har Dataset/"
                #basedir <- paste(homedir,dropdir, sep='')
        #}
        
        if(!length(grep("UCI",dir()))) {
                message("The required files do not appear to be in your current working directory.")
                message("Please use setwd() to go to the appropriate location and re-run.")

                ## No point continuing to run. Make the user start over.
                stop("The dataset folder was not found.")
        }
        
        setwd(basedir)
        
        ## Read in the feature names and activity names, as we will use these 
        ## for each data type.
        features <- read.table("features.txt")
        activities <- read.table("activity_labels.txt")
        
        get_dir <- function() currdir
        get_base <- function() basedir
        get_features <- function() features
        get_activities <- function() activities
        
        list(get_dir = get_dir,
             get_base = get_base,
             get_features = get_features,
             get_activities = get_activities)
}

complete_set <- function(base_dir = getwd(), curr_set = "test", my_environment) {
        
        setwd(curr_set)
        
        
        ## Reuse the features and activities data
        
        features <- my_environment$get_features()
        activities <- my_environment$get_activities()
        
        
        ## Read in the x, y, and subject files in this folder
        
        x_file <- paste(c("X_",curr_set,".txt"), sep = "", collapse = "")
        y_file <- paste(c("y_",curr_set,".txt"), sep = "", collapse = "")
        sub_file <- paste(c("subject_",curr_set,".txt"), sep = "", collapse = "")
        
        
        ## Read the data from the files into variables
        
        x <- read.table(x_file)
        y <- read.table(y_file)
        subject <- read.table(sub_file)

        ## Looking at the files, features.txt has two columns. [,1] is the numeric
        ## code for each title, and [,2] is the long-form (text) name.
        ## X_test has as many columns as features.txt has rows. Logically, this means
        ## that we can turn features into the names of X_test.

        names(x) <- features[,2]

        
        ## For the moment, add text labels to y based on activities info.
        ## First, add a column of "NA" to the end of the current y-frame.
        ## While we're at it, name the columns in y.
        
        y_val <- cbind(y,rep("NA"))
        names(y_val) <- c("activity.code","activity")

        
        ## Now that that's done, replace the "NA"s with the actual activity names.
        ## In other words, for each row in y_val, do a lookup comparing the 
        ## activity code in y_val to the activity code & name in 'activities'.
        ## Use the set.activities() function.
        
        y_val$activity <- apply(y_val, 1, FUN = set.activity, activities = activities)

        
        ## now cbind y_val text names to x_test
        
        new_data <- cbind(x,y_val)
        

        ##  Use cbind to attach the subject information to the test info.
        
        names(subject) <- c("subject")
        tidy_data <- cbind(new_data,subject)
        
        
        ## As a record of the output, write the tidy data for each set in the 
        ## current -- i.e., test or training -- folder.
        
        filename <- paste(c(curr_set,"_output.txt"), sep = "",collapse = "")
        write.table(tidy_data, file=filename, row.names = FALSE)
        
        
        ## Return to the original location
        
        print(paste(c("Going back to",base_dir),sep=" ",collapse=' '))
        setwd(base_dir)
        
        
        ## Return the tidied set data.
        #print(class(tidy_data))
        tidy_data
        
}

set.activity <- function(y,activities) {
        last_col = ncol(y)
        y[last_col] <- activities[y[1],2]
}

rowjoin_sets <- function(files_to_join = c()) {
        ## This function does not actually return the expected output.
        ## It is not used while running the script at the moment.
        ## The idea is to make this as function-based as possible, so I will
        ## come back and try to fix this, among other inefficiencies.
        
        full_data <- do.call("rbind",files_to_join)
        
        ## Return the bound values.
        full_data
        
}

main <- function() {
        
        ## We are assuming that reshape2 is available. Let's make that explicit.
        require(reshape2)
        
        ## Use start_prep to set everything up.
        ## Then store the basic info (current dir, base dir, etc.)
        
        environment_setup <- start_prep()
        my_dir <- environment_setup$get_dir()
        my_base <- environment_setup$get_base()
        features <- environment_setup$get_features()
        activities <- environment_setup$get_activities()
       
        #print(paste("Currently in this directory:",my_dir))
        
        
        ## Tidy up the test & training data.
        ## Add the activity code, activity name, and subject columns.
        
        #print("Finalising the test data set.")
        tidy_test <- complete_set(base_dir = my_base, curr_set = "test", environment_setup)
        
        #print("Finalising the training data set.")
        tidy_train <- complete_set(base_dir = my_base, curr_set = "train", environment_setup)
        
        
        ## join the sets -- work out some way of making this a function.
        ## all of the rowjoin attempts seem to treat each column separately.

        full_dataset <- rbind2(tidy_test,tidy_train)
        
        
        ## Subset out the mean / stddev vals. In this case, we are being strict.
        ## mean() is not the same as meanFreq().
        ## Don't forget to keep the activity and subject columns, for 
        ## dcasting later.

        mean_cols <- grep('-mean()',names(full_dataset),fixed=TRUE)
        stdev_cols <- grep('-std()',names(full_dataset))
        
        full_measures <- unique(c(mean_cols,stdev_cols))
        full_measures <- sort(full_measures)
        
        
        ## We know the order of our columns, so we know that activity names 
        ## are in the penultimate column and the subject numbers are in 
        ## the last column. Rather than using explicit numbers, use the current
        ## column dimension.
        
        all_cols <- ncol(full_dataset)
        uncast_measures <- full_dataset[,c(full_measures,(all_cols-1),all_cols)]

        
        ## To 'show our work' for step 3, write the subsetted tidy data to
        ## a file in the current directory. PWD = 'UCI Har Dataset'
        
        write.table(uncast_measures, file="uncast_tidy.txt", row.names = FALSE)
        
        
        ## Get the mean per subject & activity
        ## With 6 activities and 30 subjects, this should give us 180 observations
        ## across the 66 measurements subset above.
        ## In this case, we want to keep our data wide, but we want to iterate
        ## over the activity name and subject number.
        
        melt_measures <- melt(uncast_measures,id.vars = c("activity","subject"))
        tidy_means <- dcast(melt_measures, subject + activity ~ variable, mean)
        
        ## Now write the finalised tidy data to the current directory.
        write.table(tidy_means, file="final_tidy.txt", row.names = FALSE)
        
        
        ## Return the use back to her/his original directory.
        #print(paste(c("Returning you to",my_dir),sep = " ",collapse = " "))
        setwd(my_dir)
        #print(paste("You are now back in", getwd()))
}

main()
