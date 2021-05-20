# Run_analysis

#  1. Merge the training and test sets to create one data set

Steps:
  1- Read the data
  2- Merge the data by groups considering the number of observations and variables
  3- Merge all columns and rows needed

# 2. Extract only the measurements on the mean and std for each measurement

Steps:
  1- Select the variables that contain "mean" on their title

# 3. Use descriptive activity names to name the activities in the data set

Steps:
  1- Merge the Data Set of the previous step with the Activity Labels by Code
  2- Mutate the columns Code and Activity in order to assign the correct label to each number
  3- select all columns except "activity" because we already have this information in "Code"
  4- rename "Code" with "Activity"
  5- relocate "subject" to make it the first column
  
# 4. Appropriately label the data set with descriptive variable names

Steps:
  1- replace all acronyms and prefixes with the full words according to the Code Book
  2- Capitalize all the first letters 

# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

Steps:

  1- Group data by subject and activity
  2- Summarize data using the mean function for all variables
  3- Save the txt file with the resulting data set 
