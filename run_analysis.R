library(plyr)

#Index of mean and std variables
KEPT_FEAT_INDEX <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543)
READ_COLUMN_INDICATOR <- rep("NULL", 561)
READ_COLUMN_INDICATOR[KEPT_FEAT_INDEX] <- "numeric"

#Add good labels for mean and std features
FEATURES <- c("BodyAccX_mean", "BodyAccY_mean", "BodyAccZ_mean", "BodyAccX_std", "BodyAccY_std", "BodyAccZ_std")
FEATURES <- c(FEATURES, "GravityAccX_mean", "GravityAccY_mean", "GravityAccZ_mean", "GravityAccX_std", "GravityAccY_std", "GravityAccZ_std")
FEATURES <- c(FEATURES, "BodyAccJerkX_mean", "BodyAccJerkY_mean", "BodyAccJerkZ_mean", "BodyAccJerkX_std", "BodyAccJerkY_std", "BodyAccJerkZ_std")
FEATURES <- c(FEATURES, "BodyGyroX_mean", "BodyGyroY_mean", "BodyGyroZ_mean", "BodyGyroX_std", "BodyGyroY_std", "BodyGyroZ_std")
FEATURES <- c(FEATURES, "BodyGyroJerkX_mean", "BodyGyroJerkY_mean", "BodyGyroJerkZ_mean", "BodyGyroJerkX_std", "BodyGyroJerkY_std", "BodyGyroJerkZ_std")
FEATURES <- c(FEATURES, "BodyAccMag_mean", "BodyAccMag_std")
FEATURES <- c(FEATURES, "GravityAccMag_mean", "GravityAccMag_std")
FEATURES <- c(FEATURES, "BodyAccJerkMag_mean", "BodyAccJerkMag_std")
FEATURES <- c(FEATURES, "BodyGyroMag_mean", "BodyGyroMag_std")
FEATURES <- c(FEATURES, "BodyGyroJerkMag_mean", "BodyGyroJerkMag_std")
FEATURES <- c(FEATURES, "fBodyAccX_mean", "fBodyAccY_mean", "fBodyAccZ_mean", "fBodyAccX_std", "fBodyAccY_std", "fBodyAccZ_std")
FEATURES <- c(FEATURES, "fBodyAccJerkX_mean", "fBodyAccJerkY_mean", "fBodyAccJerkZ_mean", "fBodyAccJerkX_std", "fBodyAccJerkY_std", "fBodyAccJerkZ_std")
FEATURES <- c(FEATURES, "fBodyGyroX_mean", "fBodyGyroY_mean", "fBodyGyroZ_mean", "fBodyGyroX_std", "fBodyGyroY_std", "fBodyGyroZ_std")
FEATURES <- c(FEATURES, "fBodyAccMag_mean", "fBodyAccMag_std")
FEATURES <- c(FEATURES, "fBodyAccJerkMag_mean", "fBodyAccJerkMag_std")
FEATURES <- c(FEATURES, "fBodyGyroMag_mean", "fBodyGyroMag_std")
FEATURES <- c(FEATURES, "fBodyGyroJerkMag_mean", "fBodyGyroJerkMag_std")

#Read in data for the variables corresponding to mean and std measurements
trainData <- read.table("./data/train/X_train.txt", sep = "", colClasses = READ_COLUMN_INDICATOR, header = FALSE)
testData <- read.table("./data/test/X_test.txt", sep = "", colClasses = READ_COLUMN_INDICATOR, header = FALSE)

activityData <- rbind(trainData, testData)
names(activityData) <- FEATURES

#Read in subject identification info, append to data frame
trainSubjects <- read.table("./data/train/subject_train.txt", sep="", header=FALSE)
testSubjects <- read.table("./data/test/subject_test.txt", sep="", header=FALSE)
subjects <- rbind(trainSubjects, testSubjects)
names(subjects) <- c("subject")
activityData <- cbind(activityData, subjects)

#Read in activity data, use to append correct descriptive activity labels
trainActivityID <- read.table("./data/train/y_train.txt", sep="", header=FALSE)
testActivityID <- read.table("./data/test/y_test.txt", sep="", header=FALSE)
activityLabelID <- read.table("./data/activity_labels.txt", colClasses = c("NULL", "character"), sep="", header=FALSE)
activityID <- rbind(trainActivityID, testActivityID)
activityData$activity <- activityLabelID[activityID[,1],1]

#Average data from same subject doing same activity
aggregatedData <- aggregate(activityData[,1:66], list(subject = activityData$subject, activity = activityData$activity), mean)
write.table(aggregatedData, file = "./averageData.txt", row.names=FALSE)