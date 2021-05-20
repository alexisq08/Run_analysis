
#  1. Merge the training and test sets to create one data set

#First I have to read the data

#names
features <- read.table("C:/Users/AlexisJose/Documents/Rstudio/Projects/Getting_and_cleaning_data/P_assignment/Run_analysis/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", col.names = c("n", "function"))
act_labels <- read.table("C:/Users/AlexisJose/Documents/Rstudio/Projects/Getting_and_cleaning_data/P_assignment/Run_analysis/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

#Test
subject_test <- read.table("C:/Users/AlexisJose/Documents/Rstudio/Projects/Getting_and_cleaning_data/P_assignment/Run_analysis/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table("C:/Users/AlexisJose/Documents/Rstudio/Projects/Getting_and_cleaning_data/P_assignment/Run_analysis/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", col.names = features$function.)
Y_test <- read.table("C:/Users/AlexisJose/Documents/Rstudio/Projects/Getting_and_cleaning_data/P_assignment/Run_analysis/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt", col.names = "code")

#Train
subject_train <- read.table("C:/Users/AlexisJose/Documents/Rstudio/Projects/Getting_and_cleaning_data/P_assignment/Run_analysis/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
X_train <- read.table("C:/Users/AlexisJose/Documents/Rstudio/Projects/Getting_and_cleaning_data/P_assignment/Run_analysis/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", col.names = features$function.)
Y_train <- read.table("C:/Users/AlexisJose/Documents/Rstudio/Projects/Getting_and_cleaning_data/P_assignment/Run_analysis/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt", col.names = "code")

#Merge the data

X_merged <- rbind(X_test, X_train)
Y_merged <- rbind(Y_test, Y_train)
subject_merged <- rbind(subject_test, subject_train)
data_merged <- cbind(subject_merged, Y_merged, X_merged)

# 2. Extract only the measurements on the mean and std for each measurement

extracted <- select(data_merged, subject, code, contains("mean"), contains("std"))

# 3. Use descriptive activity names to name the activities in the data set

wnames <- extracted %>%
  merge(act_labels, by="code") %>%
  mutate(code = activity) %>%
  select(-c(activity)) %>%
  rename(activity = code) %>%
  relocate(subject)

# 4. Appropriately label the data set with descriptive variable names

names(wnames)<-gsub("Acc", "Accelerometer", names(wnames))
names(wnames)<-gsub("Gyro", "Gyroscope", names(wnames))
names(wnames)<-gsub("BodyBody", "Body", names(wnames))
names(wnames)<-gsub("Mag", "Magnitude", names(wnames))
names(wnames)<-gsub("^t", "Time", names(wnames))
names(wnames)<-gsub("^f", "Frequency", names(wnames))
names(wnames)<-gsub("tBody", " TimeBody", names(wnames))
names(wnames)<-gsub("-mean()", "Mean", names(wnames), ignore.case = TRUE)
names(wnames)<-gsub("-std()", "STD", names(wnames), ignore.case = TRUE)
names(wnames)<-gsub("-freq()", "Frequency", names(wnames), ignore.case = TRUE)
names(wnames)<-gsub("angle", "Angle", names(wnames))
names(wnames)<-gsub("gravity", "Gravity", names(wnames))

# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

Data <- wnames %>%
  group_by(subject, activity) %>%
  summarise_all(.funs = mean) %>%
  write.table("DataResult.txt", row.names = FALSE)

