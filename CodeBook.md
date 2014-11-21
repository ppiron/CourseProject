### Coursera Getting and Cleaning Data Course Project

#### Codebook for the tidy dataset created at point 5 (new_dataset.txt)

* Name of the dataset: new_dataset.txt
* Number of variables: 4
* Number of values: 11880

###### Brief description of the dataset

The dataset has been created by sub-setting a larger dataset containing the values of 561 variables ("features") calculated from raw data.
The raw data consists of measurements of acceleration and angular velocity collected by sensors worn by 30 subjects while performing 6 activities.

Each features values is labeled by the subjects ID and the activity ID, and multiple values (corresponding to different sampling windows) are present for each pair.

From the initial dataset, the variables representing a mean or a standard deviation have been extracted and processed to obtain the averages for each subject and activity.
The final tidy dataset "new_dataset.txt" contains these averages, formatted into "long" format (one row per variable for each subject-activity pair).

###### Description of the variables

1. Variable name: Activity
  * Position: 1
  * Type: character (factor).
  * Unique values: 6
  * Description: activity performed by the subject when the data was collected.
2. Variable name: Subject.ID
  * Position: 2
  * Type: numeric (int).
  * Range: 1-30
  * Description: unique integer identifying each subject.
3. Variable name: Feature
    * Position: 3
    * Type: character.
    * Unique values: 66
    * Description: name of the variable ("feature") for which the group average has been calculated.
4. Variable name: Feature.Average
    * Position: 4
    * Type: numeric.
    * Description: group average of the variable "Feature" (i.e., average value for each activity-subject pair).
