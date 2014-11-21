### Coursera Getting and Cleaning Data Course Project

#### Script "run_analysis.R"

The purpose of the script is to collect data from the text files
provided and prepare a tidy data set as indicated in the
project description. The script consists of the following
parts:

1. Collects and merges all the data in one dataset. Assuming
that the data is available in the folder "UCI HAR Dataset" located in the working directory, the script will:
  * for the "train" dataset, load the subject IDs, the activity IDs, the feature data and the
   inertial data present in the inertial folder
   into separate numerical arrays. These arrays have all the same  number of rows.
  * merge them into one dataset named "train_set"
   using`cbind()`.
  * repeat the two steps above for the "test" data set to obtain a second array named "test_set".
  * merge the train and test dataset in one dataset using `rbind()`.
2. Assigns the labels "Subject_ID" and "Activity" to the first two columns of the dataset and names the columns containing the feature data using the features names found in the file "feature.txt".
3. Selects only the columns whose name contains the _exact_ strings "mean()" or "std()", plus the columns containing the subject IDs and the activity IDs (first and second column respectively). This generates a new dataset named "sts".
4. In this dataset, substitutes the activity IDs with the activity names using the file "activity_labels.txt". This is achieved using `sapply()` to find the activity name corresponding to each activity ID:
```R
act_lab <- read.table("./UCI HAR Dataset/activity_labels.txt")
activities_names <- sapply(sts[,2], function(x) act_lab[act_lab[,1] == x, 2])```

  Also, modifies the columns names corresponding to the features data by replacing the parentheses with multiple dots, and then substituting two or more dots with a single dot.
5. Creates a new dataset called "new_dataset" using the function `aggregate()` to group the data by Subject ID and Activity and calculates the average of each variable for each group. Transforms this dataset from wide to long form using `melt()`. The columns of the final dataset are "Activity", "Subject.ID", "Feature.Name" and "Feature.Average".
