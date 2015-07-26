# Course Project (getdata-030)
A repository for the "Getting and Cleaning Data" project.
## Introduction
As part of the "Getting and Cleaning Data" course offered by Coursera, all students are required to do the following:
  1. Read in a number of files
  2. Merge them
  3. Take a subset of the merged data
  4. Perform a calculation on combinations of the data  
For this project, I have written a script named run_analysis.R that performs these steps. The following sections will describe the script in more detail.

## Quick Start
Put the run_analysis.R script into the same directory where you have unzipped the [source data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The folder "UCI Har Dataset" and the script run_analysis.R should be on the same level.  
Because the script itself contains a call to the main() function within the file, simply sourcing should be sufficient to run the tidying and analysis. However, an explicit main() might be necessary.  
After the script has finished, the final tidy dataset will be in a file called "final_tidy.txt" under the "UCI Har Dataset" folder.
## Explanation
### Assumptions
First, the data must be downloaded and unzipped. The data can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
After unzipping the original download, the file structure should look like this:
  - UCI Har Dataset
    - test
      - Inertial Signals (folder unused during the script)
      - subject_test.txt
      - X_test.txt
      - y_test.txt
    - training
      - Inertial Signals (folder unused during the script)
      - subject_test.txt
      - X_test.txt
      - y_test.txt
    - activity_labels.txt
    - features.txt
    - features_info.txt
    - README.txt  
Second, the script should be run from the directory that contains the base data directory. In other words, running dir() in the working directory should show both run_analysis.R and "UCI Har Dataset/". A check is run at the start of the script to confirm this.
Third, I have tried to rely mostly on the basic R functions, even when this is not the most efficient. However, I have had to require the reshape2 package. This is used to melt and cast the data into its final form.  

### Preparing the environment
This function of the script starts by storing the current working directory, so that we can return the user when the script is done. Next, because of our assumptions, we create our base analysis directory as curr_dir + "/UCI Har Dataset/". Before performing any actual manipulation of the data, we make sure that the dataset folder is in the same directory as the script. If it is not, we stop the script and tell the user to change directories.
Assuming the script and folder are together, we go into the "UCI Har Dataset" folder and read in the features and activities files, features.txt and activity_labels.txt. These will be used to make our data more readable later.

### Reading & tidying the original data sets
Once the common data (features & activities) has been read in, we can read the rest of the data.
For each subfolder (test and train), do the following:
 1. Enter the subfolder
 2. Read the X data (measurements), Y data (activities), and subject data (users) into tables
 3. Label the X data with the feature names from features.txt
 4. Add a column to the Y data so that each row has the activity name as well as the activity code
 5. Use cbind to attach the Y data to the end of the X data
 6. Use cbind to attach the subject data to the end of the data produced in step 5
 7. (Temporary) To show the work done, write a file with the joined/tidied data to the current subfolder
 8. Return to the base directory ("UCI Har Dataset") 
 9. Return the joined/tidied data to the main part of the script

### Merging the data
After both sets of data have been read and tidied, it is time to merge the data. We know that each set has the same number of columns, in the same order, so we can use rbind() to append the training data to the test data. This results in one large file of tidy wide data (10299 rows by 564 columns).

### Subsetting the data
We have been asked to limit our final data to only the mean and standard deviation data. In this case, I have chosen to interpret that strictly. My run_analysis.R script only keeps the activity names, the subject numbers, and the measurement columns that have 'mean()' or 'std()', and drops all other columns, including any with 'meanFreq()'. This leaves 10299 rows but only 68 columns.

### Reshaping the data and calculating the final figures
As our final manipulation, we have been asked to group the data by activity and user and then get the mean. In other words, row 1 becomes user 1's laying data, row 2 is user 1's sitting data, ..., row 7 is user 2's laying data, ..., and the last row is user 30's walking_upstairs data. This gives us final dimensions of 180 rows (30 users with 6 activities each) by 68 columns (user, activity, and the 66 measurements).
This is done by using the reshape2::melt and reshape2::dcast functions. Using melt() with id.vars of user & activity turns our data from wide to long. Then, dcast() brings it back to wide with the combinations we need. In addition, for each combination of user, activity, and measurement, it calculates the mean of all of those measurement values.
With our data in its final form, we write our output into final_tidy.txt.

## Sources
[The getdata-030 assignment page](https://class.coursera.org/getdata-030/human_grading/view/courses/975114/assessments/3/submissions)  
Associated threads in the Coursera discussion forum, including [this FAQ](https://class.coursera.org/getdata-030/forum/thread?thread_id=37)  
[The original UCI data page](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)  
[RStudio's markdown cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)  
[R-Bloggers' CodeBook tutorial](http://www.r-bloggers.com/reading-codebook-files-in-r/)  
