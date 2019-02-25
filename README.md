# getting_and_cleaning_data
Getting and Cleaning Data course project
Maksim Kouznetsov

Using dataset obtained at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

developed by 
Jorge L. Reyes-Ortiz(1,2), Davide Anguita(1), Alessandro Ghio(1), Luca Oneto(1) and Xavier Parra(2)
1 - Smartlab - Non-Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy. 
2 - CETpD - Technical Research Centre for Dependency Care and Autonomous Living
Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain
activityrecognition '@' smartlab.ws

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

run_analysis.R contains a script that
- assumes that the current working directory contains the unzipped dataset directory "UCI HAR Dataset"
- reads the training and test data and merges them, adding the subject and activity columns
- among measurement columns retains only the ones containing mean and standard deviation for the measurement (throwing away min, max, etc.)
- modifies the column names to be friendlier
- replaces activity ids with activity names for readability
- creates a summary dataframe that averages measures for each subject/activity combination
- writes out the new dataset into file "samsung_summarized.txt"

