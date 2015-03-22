---
title: "Getting and Cleaning Data Course Project CodeBook"
author: "Brandon"
date: "Monday, March 23, 2015"
output: html_document
---

This code book describes the variables, the data, and any transformations or work that is performed to clean up the data  

A full description is available at the site where the data was obtained:

* http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Data for the project:

* https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The data was clean using run_analysis.R script, the following describes the logic and contents of the R script in detail:

1. Store the training data set (/data/train/X_train.txt), training data labels (/data/train/y_train.txt) and training data subjects (/data/train/subject_train.txt) in *trainData*, *trainLabels* and *trainSubjects* dataframes respectively
    
2. Store the test data set (/data/test/X_train.txt), test data labels (/data/test/y_train.txt) and test data subjects (/data/test/subject_train.txt) in *testData*, *testLabels* and *testSubjects* dataframes respectively
    
3. Merge the train data set with the test data set to generate a *mergeData* dataframe. Merge the train labels data set with the test labels data set to generate a *mergeLabels* dataframe. Merge the train subjects data set with the test subjects data set to generate a *mergeSubjects* dataframe.

4. Store the data in features.txt file from the "/data" folder to a variable called *measurementData*. Next extract the measurements on the mean and standard deviation. This results in a 66 indices list. Subset of mergeData with the 66 corresponding columns.

5. Clean the column names of the subset by removing the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.

6. Store the activity_labels.txt file from the "./data"" folder and store the data in a variable called *activityData*.

7. Store the activity names in the second column of *activityData*. Need to make all names to lower cases as recommended in R best practice. If the name has an underscore between letters,  remove the underscore and capitalize the letter immediately after the underscore.

8. Transform the values of *mergeLabels* according to the *activityData* data frame.

9. Merge the *mergeSubjects*, *mergeLabels* and *mergeData* by column to get a new clean 10299x68 data frame, *cleanData*. Properly name the first two columns, "subjects" and "activities" in lowercase. The "subjects" column contains integers that range from 1 to 30 inclusive; the "activities" column contains 6 kinds of activity names; the last 66 columns contain measurements.

10. Write the *cleanData* out to "merged_data.txt" file in current working directory.

11. Finally, generate a second independent tidy data set with the average of each measurement for each activity and each subject. 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. Then, for each combination, calculate the mean of each measurement with the corresponding combination. So, after initializing the result data frame and performing the two for-loops, a 180x68 data frame is stored a variable, *result*.

12. Write the *result* variable out to "data_with_means.txt" file in current working directory.