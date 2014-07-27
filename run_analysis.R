##
## Coursera Get and Clean Data Course Project
## Usage:
##   source("run_analysis.R")
##   tidyData <- run_analysis()
##   [ The aggregate dataset is saved in tidyset.txt ]

## A function to extract mean(),std() features from the full dataset
## Inputs: sampData: the train or test dataset
##         sampLabs: a vector of all feature lables
## Output: trimmed dataset
subsetMeanStd <- function(sampData, sampLabs) {
    
    #- Extract the features of interest: the ones w/ mean() or std() strings
    featMeanStd <- subset(sampLabs,  grepl("(mean\\(\\)|std\\(\\))", sampLabs$V2))
    #- Modify the labels to improve readability
    featMeanStd[,2] <- gsub('-mean\\(\\)', 'Mean', featMeanStd[,2])
    featMeanStd[,2] <- gsub('-std\\(\\)', 'Std', featMeanStd[,2])
    
    #- Extract the sub-dataset
    meanStdData <- sampData[, featMeanStd[,1]]
    colnames(meanStdData) <- featMeanStd[,2]
    
    meanStdData
}

## Function to produce merged dataset from the fragments
## Input: workDir: Working dir where the 'UCI HAR Dataset' dir resides
## Output: Merged data
mergeData <- function(workDir) {
    
    #- Features (561)
    #- Format: index, label
    fileFeat <- sprintf("%s/features.txt", workDir)
    featLabs <- read.table(fileFeat, header=FALSE, sep="")


    ## Read in "train" feature data, labels and subjects
    ## Extract mean,std features
    sampType <- "train"
    #- Format: 561 column feature_data
    fileX <- sprintf("%s/%s/X_%s.txt", workDir, sampType, sampType)
    trainDF <- read.table(fileX, header=FALSE, sep="")
    #- Extract the features of interest: those w/ mean() or std()
    trainDF <- subsetMeanStd(trainDF, featLabs)
    #- Format: activity_index (1-6)
    filey <- sprintf("%s/%s/y_%s.txt", workDir, sampType, sampType)
    trainLab <- read.table(filey, header=FALSE, sep="")
    colnames(trainLab) <- c("Activity")
    #- Format: subject_id (1-30)
    fileSub <- sprintf("%s/%s/subject_%s.txt", workDir, sampType, sampType)
    trainSub <- read.table(fileSub, header=FALSE, sep="")
    colnames(trainSub) <- c("Subject")
    
    ## Read in "test" feature data, labels and subjects
    ## Extract mean,std features
    sampType <- "test"
    #- Format: 561 column feature_data
    fileX <- sprintf("%s/%s/X_%s.txt", workDir, sampType, sampType)
    testDF <- read.table(fileX, header=FALSE, sep="")
    #- Extract the features of interest: those w/ mean() or std()
    testDF <- subsetMeanStd(testDF, featLabs)
    #- Format: activity_index (1-6)
    filey <- sprintf("%s/%s/y_%s.txt", workDir, sampType, sampType)
    testLab <- read.table(filey, header=FALSE, sep="")
    colnames(testLab) <- c("Activity")
    #- Format: subject_id (1-30)
    fileSub <- sprintf("%s/%s/subject_%s.txt", workDir, sampType, sampType)
    testSub <- read.table(fileSub, header=FALSE, sep="")
    colnames(testSub) <- c("Subject")
    
    #- Merge the train and test data
    trainData <- cbind(trainSub, trainLab, trainDF)
    testData  <- cbind(testSub,  testLab,  testDF)
    wholeData <- rbind(trainData, testData)
    
    wholeData
}

## Run the full analysis
## Output: Tidy data
##         tidyset.txt: File containing the aggregate dataset
run_analysis <- function() {
    workDir <- "./UCI HAR Dataset/"
    if (!file.exists(workDir)) {
        print(paste0("Run this script where ", workDir, " dir exists"))
        return(-1)
    }

    #- Merge dataset
    print("Merging train and test data..")
    tidyData <- mergeData(workDir)
    print("Done!")
    
    ## Replace the activity IDs with names
    #- Activity labels (6)
    #- Format: index, label
    fileAct <- sprintf("%s/activity_labels.txt", workDir)
    actLabs <- read.table(fileAct, header=FALSE, sep="")
    actId <- 1
    for (currLab in actLabs$V2) {
        tidyData$Activity <- gsub(actId, currLab, tidyData$Activity)
        actId <- actId + 1
    }
    
    #- Make agrregate dataset for mean,std features
    #- w.r.t Activity and Subject factors
    print("Making aggregate dataset...")
    tidyData$Subject <- as.factor(tidyData$Subject)
    tidyData$Activity <- as.factor(tidyData$Activity)
    aggrData <- aggregate(tidyData, by=list(Subject=tidyData$Subject,
                                            Activity = tidyData$Activity), mean)
    # Remove the Subject and Activity mean columns
    aggrData[,3] = NULL
    aggrData[,3] = NULL
    write.table(aggrData, "tidyset.txt", sep="\t", row.names=FALSE)
    print("Done writing dataset to tidyset.txt")

    tidyData
}

