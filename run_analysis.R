# Run Analysis R Script 

#Deliver follwing  1. Data 2, R code script 3. codebook, 4. Readme
#Approach 
#Merges the training and the test sets to create one data set. -union/merge
#Extracts only the measurements on the mean and standard deviation for each measurement. - only mean,stddev cols from x
#Uses descriptive activity names to name the activities in the data set 
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step above, creates a second, independent tidy data set with - the average of each variable - for each activity(6) and each subject. subject_train(30)



# Load the libs
library(dplyr)
library(data.table)


# Load the features 
features=readLines("features.txt")

#Load the activity lables

activity_lables=read.table("activity_labels.txt")

#Load the Train data
xt=as.data.table(read.table("train/X_train.txt"))
yt=as.data.table(read.table("train/Y_train.txt"))
st=as.data.table(read.table("train/subject_train.txt"))

#Load the test data

xt1=as.data.table(read.table("test/X_test.txt"))
yt1=as.data.table(read.table("test/Y_test.txt"))
st1=as.data.table(read.table("test/subject_test.txt"))



# Combine the data sets
#combine X, Subjects and Activities (Y)

Data = rbind(xt, xt1)
Subject =  rbind(st, st1)
Activity = rbind(yt, yt1)


# Setup Activities for Mutate
setnames(Activity, names(Activity), "Activity")

# Apply Mutate now
Activity_labels=mutate(Activity,Activity=factor(Activity,labels=activity_lables[,2]))


# coerce the feature vector to synctactical name  
feature_labels= make.names(features)

#Fix feature's body names
feature_labels=gsub("fBody","frequencyBody",feature_labels)
feature_labels=gsub("tBody","timeBody",feature_labels)


#Fix the lables with regex
feature_labels=gsub("^X[0-9][0-9]*.","",feature_labels)

#Fix the gravity of features
feature_labels=gsub("tGravity","timeGravity",feature_labels)


#Set the Variable names
setnames(Data, names(Data), feature_labels)
setnames(Subject, names(Subject), "Subject")


#Select only MEAN AND STDDEV
MeanData=select(Data,contains("Mean",ignore.case=TRUE))
StdData=select(Data,contains("std"))

# column bind mean and data
Data1=cbind(MeanData,StdData)
#create the final data set
Final=cbind(Subject,Activity_labels, Data1)


# Arrange it well by the Subject
ArrangedFinal = arrange(Final,Subject)

#Group it per subject and activity 
GroupedFinal = group_by(ArrangedFinal,Subject,Activity)

#summarize the final TIDY DATA SET
SummarizedFinal = summarise_each(GroupedFinal,funs(mean))


# Write it in current directory

write.table(SummarizedFinal,file="FinalSummary.txt", row.name=F)
