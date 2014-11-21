
################### GETTING AND CLEANING DATA###################################

################### COURSE PROJECT #############################################

#1. COLLECT ALL THE DATA IN ONE DATASET

#Load the "train" data in separate arrays
features_train <- matrix(scan("./UCI HAR Dataset/train/X_train.txt"), nrow = 7352, byrow = TRUE)
subject_ID_train <- scan("./UCI HAR Dataset/train/subject_train.txt")
activity_train <- scan("./UCI HAR Dataset/train/y_train.txt")
file_list_train <- list.files(path = "./UCI HAR Dataset/train/Inertial Signals/", pattern="*.txt", full.names=TRUE)
data_train <- numeric()
for (fname in file_list_train) {
        b <- matrix(scan(fname), nrow = 7352, byrow = TRUE)
        data_train <- cbind(data_train, b)
}
#Merge all the "train" data in one dataset
train_set <- cbind(subject_ID_train, activity_train, features_train, data_train)

#Load the "test" data in separate arrays
features_test <- matrix(scan("./UCI HAR Dataset/test/X_test.txt"), nrow = 2947, byrow = TRUE)
subject_ID_test <- scan("./UCI HAR Dataset/test/subject_test.txt")
activity_test <- scan("./UCI HAR Dataset/test/y_test.txt")
file_list_test <- list.files(path = "./UCI HAR Dataset/test/Inertial Signals/", pattern="*.txt", full.names=TRUE)
data_test <- numeric()
for (fname in file_list_test) {
        b <- matrix(scan(fname), nrow = 2947, byrow = TRUE)
        data_test <- cbind(data_test, b)
}
#Merge all the "test" data in one dataset
test_set <- cbind(subject_ID_test, activity_test, features_test, data_test)

#Merge "train" and "test" data in one dataset (a numeric matrix)
dataset <- rbind(train_set, test_set)

#2. LABELS THE SUBJECT, ACTIVITY AND FEATURE COLUMNS

feat_names <- read.table("./UCI HAR Dataset/features.txt")
feat_names <- as.character(feat_names[,2])
colnames(dataset)[1:(length(feat_names) + 2)] <- c("Subject.ID", "Activity.ID", feat_names)

#3. EXTRACTS THE COLUMNS WITH THE MEAN AND STANDARD DEVIATION

# Only the columns with the exact names "mean()" and "std()" are extracted, plus the first two columns
bl <- grepl("mean()", colnames(dataset), fixed = TRUE) | grepl("std()", colnames(dataset), fixed = TRUE)
sts <- dataset[, c(TRUE,TRUE,bl[3:length(bl)])]

#4. SUBSTITUTES THE ACTIVITY IDs WITH THE ACTIVITY NAMES AND 'CLEANS' THE FEATURES NAMES

act_lab <- read.table("./UCI HAR Dataset/activity_labels.txt")
activities_names <- sapply(sts[,2], function(x) act_lab[act_lab[,1] == x, 2])
# The matrix 'sts' is converted into a dataframe because a matrix cannot include both character and
#numeric data. This authomatically changes the features names by substituting parentheses with dots. 
sts_df <- data.frame(sts)
# Two or three consecutive dots are replaced by one dot in the features names
a <- colnames(sts_df)
a <- gsub("(\\.){2,3}", "\\.", a)
colnames(sts_df) <- a
sts_df[, 2] <- activities_names
colnames(sts_df)[2] <- "Activity"

# 5. CREATES A NEW DATAFRAME WITH THE AVERAGES BY ACTIVITY AND SUBJECT

new_dataset <- aggregate(sts_df[,3:ncol(sts_df)], by = sts_df[c("Activity", "Subject.ID")], FUN = mean)
require(reshape2)
new_dataset <- melt(new_dataset, id.vars = c(1,2), variable.name = "Feature.Name", value.name = "Feature.Average")
write.table(new_dataset, "./new_dataset.txt", row.name = FALSE)
