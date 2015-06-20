# Download and extract the data

sourceUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataDir <- "./data"
localPath <- paste(dataDir, "galaxy_s.zip", sep = "/")

if(!file.exists(dataDir))
  dir.create(dataDir)

if(!file.exists(localPath)) {
  download.file(sourceUrl, destfile = localPath, mode="wb")
  dateDownloaded <- date()
  
  unzip(localPath, exdir = dataDir)
}

################################
# Step 1 & (most of) Step 4
# Merge and Label the datasets
################################

# Read the labels
dataset.dir <- paste(dataDir, "UCI HAR Dataset", sep="/")
labels.data <- read.table(paste(dataset.dir, "features.txt", sep="/"), header=FALSE)
labels.data_asvector <- as.vector(labels.data[,2])

# Read the training data
training.dir <- paste(dataset.dir, "train", sep="/")
training.data <- read.table(paste(training.dir, "X_train.txt", sep="/"), header=FALSE, col.names = labels.data_asvector)
training.subjects <- read.table(paste(training.dir, "subject_train.txt", sep="/"), header=FALSE, col.names = c("subject"))
training.activity <- read.table(paste(training.dir, "y_train.txt", sep="/"), header=FALSE, col.names = c("activity_id"))
training.all <- cbind(training.data, training.subjects, training.activity)

# Read the test data
testing.dir <- paste(dataset.dir, "test", sep="/")
testing.data <- read.table(paste(testing.dir, "X_test.txt", sep="/"), header = FALSE, col.names = labels.data_asvector)
testing.subjects <- read.table(paste(testing.dir, "subject_test.txt", sep="/"), header=FALSE, col.names = c("subject"))
testing.activity <- read.table(paste(testing.dir, "y_test.txt", sep="/"), header=FALSE, col.names = c("activity_id"))
testing.all <- cbind(testing.data, testing.subjects, testing.activity)

# All the data!
data.all <- rbind(training.all, testing.all)

################################
# Step 2
# Extract only the means and standard deviations
################################
labels.data_asvector.mean <- grep("-mean", labels.data_asvector, value = FALSE)
labels.data_asvector.std <- grep("-std", labels.data_asvector, value = FALSE)

# this is kind of a hack, I know the last two columns are the subject and activity
labels.mean_std_subject_activity <- c(labels.data_asvector.mean, labels.data_asvector.std, 562, 563)
data.means_and_std <- data.all[,labels.mean_std_subject_activity]


################################
# Step 3
# Apply the activity names
################################
labels.activity <- read.table(paste(dataset.dir, "activity_labels.txt", sep="/"), header=FALSE, col.names = c("activity_id", "activity_name"))
data.labeled_activity <- merge(data.means_and_std, labels.activity, by="activity_id", sort = FALSE)
data.labeled_activity <- subset(data.labeled_activity, select=-c(activity_id))


################################
# Step 5
# Apply the activity names
################################
library(plyr)
activity_averages_by_subject_and_activity <- ddply(data.labeled_activity, .(subject, activity_name), numcolwise(mean))
write.table(activity_averages_by_subject_and_activity, file=paste(dataDir, "data.txt", sep="/"), row.names = FALSE)