#unzip data set
unzip("./getdata-projectfiles-UCI HAR Dataset.zip")

#get test data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
test_data <- cbind(subject_test, y_test, x_test)

#get trainging data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
train_data <- cbind(subject_train, y_train, x_train)

#merge the two
merged_data <- rbind(test_data, train_data)
sortmerge <- order(merged_data$V1, merged_data$V2)
merged_data <- merged_data[sortmerge, ]

#name the variables
features <- read.table("./UCI HAR Dataset/features.txt")
variables <- c("Subject", "Activity", as.character(features$V2))
names(merged_data) <- variables

#use descriptive names for Activity values
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activity_labels <- as.character(activity_labels$V2)
merged_data$Activity <- activity_labels[merged_data$Activity]

#extract just means and standard deviation
VarWithMean <- grep("mean\\(\\)", variables)
VarWithStd <- grep("std\\(\\)", variables)
VarWeWant <- c(1:2, VarWithMean,VarWithStd)
VarWeWant <- sort(VarWeWant)
merged_data <- merged_data[ , VarWeWant]

#average variables for each subject and each actvity
library(reshape2)
melted_data <- melt(merged_data, id = c("Subject", "Activity"))
final_data <- dcast(melted_data, Subject + Activity ~ variable, fun.aggregate = mean)
write.table(final_data, "./final_data.txt", row.names = FALSE)