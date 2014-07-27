# CodeBook for UCI HAR Combined Dataset
Description: This code book describes the variables, the output data, and 
any transformations or processing performed to clean up the data. 

## The Raw Input

* A total of 561 `features` read from "features.txt"
* A total of 6 `activities` read from "activity_labels.txt"
* Features raw data for the `train` dataset read from "train/X_train.txt"
* Corresponding activity and subject IDs read from
  "train/y_train.txt" and "train/subject_train.txt", respectively.
* Similar data read for `test` dataset.

## Data Transformation

* A subset of raw features data, containing mean and std variables, are
  extracted for train and test datasets.
* These subset data are individually combined (cbind) to include subject,
  activity and features variables.
* Descriptive names are used to mark the columns.
* Finally the two datasets were merged (rbind) to produce the full dataset.
* The Activity IDs are replaced with corresponding names, as required by 
  the course. Both Subject (col-1) and Activity (col-2) variables are made
  into factor variables. THIS IS THE DESIRED TIDY DATASET.
* An aggregate dataset is created to contain means of each of Subject and
  Activity categories.

## The Output

* To run the analysis: `source("run_analysis.R")` followed by
  `tidyData <- run_analysis()`.
* The tidyData is the tidy data.frame we intend to produce.
* The created `tidyset.txt` file contains the aggregate dataset.

