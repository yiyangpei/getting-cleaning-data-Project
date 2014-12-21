

# Step 0: Reads data
# The following functions assume that the downloaded data are in the folder "UCI HAR Dataset
# in the current working directory.

# Read Test Data
subject_test <-read.table("./UCI\ HAR\ Dataset/test/subject_test.txt", sep="")
y_test <-read.table("./UCI\ HAR\ Dataset/test/y_test.txt", sep="")
X_test <-read.table("./UCI\ HAR\ Dataset/test/X_test.txt", sep="")
data_test <- cbind(subject_test,y_test, X_test)

# Read Train Data
subject_train <-read.table("./UCI\ HAR\ Dataset/train/subject_train.txt", sep="")
y_train <-read.table("./UCI\ HAR\ Dataset/train/y_train.txt", sep="")
X_train <-read.table("./UCI\ HAR\ Dataset/train/X_train.txt", sep="")
data_train <- cbind(subject_train, y_train, X_train)



# Step 1: Merges the training and the test sets to create one data set.
data <- rbind(data_train,data_test)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

# Read Feature Names
feature_names <- read.table("./UCI\ HAR\ Dataset/features.txt", sep="")

#mean_std_ind <- grepl("mean\\(",feature_names[,2]) | grepl("std\\(",feature_names[,2])
mean_std_ind <- grepl("-(mean|std)[(]",feature_names[,2])
data_mean_std <- data[,c(TRUE,TRUE,mean_std_ind)]

# Step 3: Uses descriptive activity names to name the activities in the data set
# Replace the activity lables in integer values with descriptive ones indicated below 

# 1 WALKING
# 2 WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4 SITTING
# 5 STANDING
# 6 LAYING

data_mean_std[data_mean_std[,2]==1,2]="WALKING"
data_mean_std[data_mean_std[,2]==2,2]="WALKING_UPSTAIRS"
data_mean_std[data_mean_std[,2]==3,2]="WALKING_DOWNSTAIRS"
data_mean_std[data_mean_std[,2]==4,2]="SITTING"
data_mean_std[data_mean_std[,2]==5,2]="STANDING"
data_mean_std[data_mean_std[,2]==6,2]="LAYING"

# Step 4: Appropriately labels the data set with descriptive variable names.
feature_names_mean_std <-as.character(feature_names[mean_std_ind,2]) 
# Remove the parenthesis
feature_names_mean_std <- gsub("[()]","",feature_names_mean_std)
colnames(data_mean_std) <-c("Subject", "Activity", feature_names_mean_std) 

# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# install.packages("reshape2")
library(reshape2)
mdata_mean_std <- melt(data_mean_std, id=c("Subject","Activity"))
data_tidy <- dcast(mdata_mean_std,Subject+Activity~variable, mean)


# Step 6: Writes the tidy data to a file called "Data_Tidy.txt"
write.table(data_tidy, file="Data_Tidy.txt",row.name=FALSE)

