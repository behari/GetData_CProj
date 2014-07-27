# Getting and Cleaning Data: Course Project

## Introduction
The objective is to merge the UCI Human Activity Recognition dataset from
its fragments and produce an aggregate dataset of means. 

## Raw data
In the 'UCI HAR Dataset' dir the README.txt explains the details of the 
experiment and processing steps followed to obtain the data fragments. In
train and test subdirs X_*.txt and y_*.txt files contain the data and the
activity labels, respectively and subject_*.txt contain the test subject Ids.

## Script and the tidy dataset
The run_analysis.R script found in the repository provides functions to 
produce a merged tidy dataset and produce an aggregate dataset of means
into a file tidyset.txt.

## Requisites:
 - Merges the training and the test sets to create one data set.
 - Extracts only the measurements on the mean and standard deviation for each measurement
 - Uses descriptive activity names to name the activities in the data set
 - Appropriately labels the data set with descriptive activity names. 
 - Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Usage of the script

1. Extract the UCI HAR Dataset into a working dir where run_analysis.R
   script is.
2. To run the analysis:
   source("run_analysis.R")
   tidyData <- run_analysis()
3. The tidyData is the whole dataset. The aggregate dataset is saved into
   a tidyset.txt file.

### Functions:
 `mergeData`: Produces a merged dataset from the fragments
 `subsetMeanStd`: Is called by mergeData to extract mean/std subset data
 `run_analysis`: The main function to run the analysis

## Code Book
The CodeBook.md file explains the transformations performed and the 
resulting data and variables.

