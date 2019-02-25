library(data.table)
library(dplyr)

subdirectory <- "UCI\ HAR\ Dataset/"

features <- read.table(paste0(subdirectory, "features.txt"), header = FALSE)
features <- as.data.table(features)

x_train_df <- read.table(paste0(subdirectory, "train/X_train.txt"), header = FALSE, col.names = features$V2)
x_test_df <- read.table(paste0(subdirectory, "test/X_test.txt"), header = FALSE, col.names = features$V2)
y_train_df <- read.table(paste0(subdirectory, "train/y_train.txt"), header = FALSE, col.names = c("activity_id"))
y_test_df <- read.table(paste0(subdirectory, "test/y_test.txt"), header = FALSE, col.names = c("activity_id"))
subject_train <- read.table(paste0(subdirectory, "train/subject_train.txt"), header = FALSE, col.names = c("subject"))
subject_test <- read.table(paste0(subdirectory, "test/subject_test.txt"), header = FALSE, col.names = c("subject"))


act_names <- read.table(paste0(subdirectory, "activity_labels.txt"))

# 1 merges the training and the test sets to create one
x_df <- rbind(x_train_df, x_test_df)
y_df <- rbind(y_train_df, y_test_df)
subject_df <- rbind(subject_train, subject_test)

# 2 Extracts only the measurements on the mean and standard deviation for each measurement.
measures <- grep("[a-zA-Z]+-(mean|std)\\(\\)", features$V2)
x_selected_df <- x_df[,measures]

# Uses descriptive activity names to name the activities in the data set
y_dt <- as.data.table(y_df)
get_activity_name <- function(activity_num) {
    act_names[activity_num, 2]
}
y_dt[,activity_name:=get_activity_name(activity_id)]

raw_colnames <- names(x_selected_df)
colnames(x_selected_df) <- tolower(gsub("_$","", gsub("\\.{1,3}", "_", raw_colnames)))
tidy_data <- cbind(x_selected_df, activity_name = y_dt$activity_name, subject = subject_df$subject)

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
grouped_by_activity_subject <- group_by(tidy_data, activity_name, subject)
summarized <- summarize_all(grouped_by_activity_subject, mean)

write.table(summarized, row.names = FALSE, file = "samsung_summarized.txt")