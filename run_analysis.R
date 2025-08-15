#Install required libraries
library(dplyr)

#Download data if necessary

filename <- "HAR_data.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method = "curl")
}

#Check if file unzipped
if (!file.exists("UCI HAR Dataset")){ 
  unzip(filename)
}

#Generate required data frames

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#Merge the test and training data sets
X <- rbind(x_test, x_train)
Y <- rbind(y_test, y_train)
sub <- rbind(subject_test, subject_train)
merged_data <- cbind(sub, Y, X)

#Extract only the mean and std dev for each measurement
clean_data <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

#Rename the codes to descriptive activity titles 
clean_data$code <- activities[clean_data$code, 2]

#Replace column title abbreviations with full term for clarity
names(clean_data)[2] = "activity"
names(clean_data)<-gsub("^t", "Time", names(clean_data))
names(clean_data)<-gsub("^f", "Frequency", names(clean_data))
names(clean_data)<-gsub("-mean()", "Mean", names(clean_data), ignore.case = TRUE)
names(clean_data)<-gsub("-std()", "STD", names(clean_data), ignore.case = TRUE)
names(clean_data)<-gsub("-freq()", "Frequency", names(clean_data), ignore.case = TRUE)
names(clean_data)<-gsub("tBody", "TimeBody", names(clean_data))
names(clean_data)<-gsub("Acc", "Accelerometer", names(clean_data))
names(clean_data)<-gsub("Gyro", "Gyroscope", names(clean_data))
names(clean_data)<-gsub("Mag", "Magnitude", names(clean_data))
names(clean_data)<-gsub("BodyBody", "Body", names(clean_data))
names(clean_data)<-gsub("angle", "Angle", names(clean_data))
names(clean_data)<-gsub("gravity", "Gravity", names(clean_data))

#Get average of each variable for every activity/subject and store in a text file
tidy_data <- clean_data %>% group_by(subject, activity) %>% summarise_all(mean)
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)