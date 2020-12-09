"
You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
"

library(dplyr)
library(stringr)

#Step 1: Read all files necessary and then merge the appropriate files to one data set

labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

subject1 <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subject2 <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)

x1 <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
x2 <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

y1 <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
y2 <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)

subject <- rbind(subject1, subject2)
x <- rbind(x1, x2)
y <- rbind(y1, y2)

"
View(labels)
View(features)
View(subject)
View(x)
View(y)
"

#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

onlyMeanAndStdFeatures <- features[str_detect(features$V2, "mean") | str_detect(features$V2, "std"),]
#View(onlyMeanAndStdFeatures)

# remove all non mean and std from x
indices <- onlyMeanAndStdFeatures[, "V1"]
colNames <- onlyMeanAndStdFeatures[, "V2"]
xOnlyMeanAndStdCols <- x[, indices]

#Step 3: Uses descriptive activity names to name the activities in the data set

colnames(labels) <- c("labelid", "activity")
colnames(features) <- c("featureid", "feature")

#Step 4: Appropriately labels the data set with descriptive variable names.
colnames(subject) <- c("subjectId")
colnames(xOnlyMeanAndStdCols) <- colNames
#View(xOnlyMeanAndStdCols)
colnames(y) <- c("labelId")

#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
mergedDS <- cbind(subject, y, xOnlyMeanAndStdCols)
#View(xAndSubject)

averageDS <- mergedDS %>%
    group_by(subjectId, labelId) %>%
    summarise(across(everything(), list(mean)))

#View(averageDS)
write.table(averageDS, file = "tidyDataSet.txt", row.name=FALSE)
print(averageDS)
