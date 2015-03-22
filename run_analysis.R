#Author:Brandon Hu
#Purpose:Getting and Cleaning Data Course Project
#Notes:
#Created a data directory to store the train and test data 
#downloaded from the project site

#Question 1: Merge the training data with the test data

#Read in the training data set in a table format and creates data frame from it
trainData<-read.table("./data/train/X_train.txt")
#find the dimension of the training data set
dim(trainData) #7352 obs and 561 variables
#Read in the labels of the training data set in a table format and creates data frame from it
trainLabels<-read.table("./data/train/y_train.txt")
#find the dimension of the training labels
dim(trainLabels) #7352 obs and 1 variable
#Read in the subjects of the training data set in a table format and creates data frame from it
trainSubjects<-read.table("./data/train/subject_train.txt")
#find the dimension of the training subjects
dim(trainSubjects) #7352 obs and 1 variable

#Read in the test data set in a table format and creates data frame from it
testData<-read.table("./data/test/X_test.txt")
dim(testData) #2947 obs and 561 variables
#Read in the labels of the test data set in a table format and creates data frame from it
testLabels<-read.table("./data/test/y_test.txt")
dim(testLabels) #2947 obs and 1 variables
#Read in the subjects of the test data set in a table format and creates data frame from it
testSubjects<-read.table("./data/test/subject_test.txt")
dim(testSubjects) #2947 obs and 1 variables

#Merge the train and test data sets
mergeData <- rbind(trainData,testData)
dim(mergeData) #Expect to be 10299 obs and 561 variables
#Merge the train and test data labels
mergeLabels<-rbind(trainLabels,testLabels)
dim(mergeLabels) #Expect to be 10299 obs and 1 variable
#Merge the train and test data subjects
mergeSubjects<-rbind(trainSubjects,testSubjects)
dim(mergeSubjects) #Expect to be 10299 obs and 1 variable

#Question 2:Extracts only the measurements on the mean and standard deviation for each measurement. 
#Read up the features_info.txt and realized the features.txt stores all the measures mean and std dev
measurementData<-read.table("./data/features.txt")
dim(measurementData) #561obs and 2 variables
head(measurementData) #Take a peak of the data to find out how to extract the mean & std
#From the previous results realize that mean data naming convention is ...mean()...
#and std naming convention is ...std()...
#retrieve the mean or std indices since the naming convention pattern is known
meanstdIndices<-grep("mean\\(\\)|std\\(\\)", measurementData[,2])
#count the number of indices
length(meanstdIndices) #66
#Extract the data by subsetting using the indices
mergeData <- mergeData[,meanstdIndices]
dim(mergeData) #find out the extraction is correct, 10299 obs by 66 variable expected
#Rename the column names of the merge data to Mean & Std
#Remove the ()
names(mergeData)<-gsub("\\(\\)","",measurementData[meanstdIndices,2])
#Capitalize mean to Mean
names(mergeData)<-gsub("mean","Mean",names(mergeData))
#Capitalize std to Std
names(mergeData)<-gsub("std","Std",names(mergeData))
#Remove the -
names(mergeData)<-gsub("-","",names(mergeData))

#Question 3: Uses descriptive activity names to name the activities in the data set
#Read in the activity data in a table format and creates data frame from it
activityData<-read.table("./data/activity_labels.txt")
dim(activityData)
#remove the _ from the 2nd and 3rd row
activityData[,2]<-tolower(gsub("_","",activityData[,2]))
#uppercase the 2nd wording for 2nd and 3rd row
substr(activityData[2,2],8,8)<-toupper(substr(activityData[2,2],8,8))
#uppercase the 2nd wording for 2nd and 3rd row
substr(activityData[2,2],8,8)<-toupper(substr(activityData[2,2],8,8))
#subset to get the labels to match the numbers e.g. 1 = Walking
activityLabels<-activityData[mergeLabels[,1],2]
mergeLabels[,1]<-activityLabels
#rename the column name of the mergeLabels
names(mergeLabels)<-"activities"

#Question 4:Appropriately labels the data set with descriptive variable names. 
#Rename the column name of the mergeSubjects
names(mergeSubjects)<-"subjects"
cleanData<-cbind(mergeSubjects,mergeLabels,mergeData)
dim(cleanData)
write.table(cleanData,"merged_data.txt",row.names=FALSE) #write out the 1st dataset

# Step5. Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject. 
subjectTotal <- length(table(mergeSubjects)) # 30
activityTotal <- dim(activityData)[1] # get the obs for activity data
varTotal <- dim(cleanData)[2] # get the variables for cleanData, 68
result <- matrix(NA, nrow=subjectTotal*activityTotal, ncol=varTotal) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanData)
row <- 1
for(i in 1:subjectTotal) {
  for(j in 1:activityTotal) {
    result[row, 1] <- sort(unique(mergeSubjects)[, 1])[i]
    result[row, 2] <- activityData[j, 2]
    bool1 <- i == cleanData$subjects
    bool2 <- activityData[j, 2] == cleanData$activities
    result[row, 3:varTotal] <- colMeans(cleanData[bool1&bool2, 3:varTotal])
    row <- row + 1
  }
}
head(result)
write.table(result, "data_with_means.txt",row.names=FALSE) # write out the 2nd dataset