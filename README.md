---
title: "Getting and Cleaning Data Course Project"
author: "Brandon Hu"
date: "Sunday, March 22, 2015"
output: html_document
---

* Unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename the folder as "data".

* Ensure the folder "data" and the run_analysis.R script are both in the current working directory in RStudio.

* Use source("run_analysis.R") command in RStudio.

- Two output files are generated in the current working directory:
    * merged_data.txt: Contains a data frame, *cleanData*, with 10299*68 dimension
    - data_with_means.txt: Contains a data frame, *result*, with 180*68 dimension
  
* Finally, use data <- read.table("data_with_means.txt") command in RStudio to read the file. In total, there are 6 activities and 30 subjects, 180 rows with all combinations for each of the 66 features.