run_analysis <- function() {
  
#		setwd()
	setwd("C:/Users/Ben/Desktop/Data Science certification/getting and cleaning data/project 2")

# 		Loads subject files
	subjects <- rbind( read.table("UCI HAR Dataset/train/subject_train.txt", col.names="Subject"), read.table("UCI HAR Dataset/test/subject_test.txt", col.names="Subject"))
  
#		Loads code files 
	activities <- rbind( read.table("UCI HAR Dataset/train/y_train.txt", col.names="Code"), read.table("UCI HAR Dataset/test/y_test.txt", col.names="Code"))
	activitytable <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("Code", "Label")) 
	activities$Name = activitytable$Label[activities$Code]

#		Loads features files	
	features <- rbind( read.table("UCI HAR Dataset/train/X_train.txt"), read.table("UCI HAR Dataset/test/X_test.txt"))
  
#		function used in selected to state features is the place to select from
	selectThese <- read.table("UCI HAR Dataset/features.txt", col.names=c("Index", "Name"), colClasses=c("integer", "character"))
  
# 		selects mean & standard standard deviation from features
	selected <- selectThese[grep("mean|std", selectThese$Name, ignore.case = TRUE),]
  
#		the tidy data set	  
  tidyFeaturesData <- cbind(subjects, activities)
  
#		builds dataframe from selected called tidyFeaturesData  
	for (i in 1:nrow(selected)) {
		tmp <- data.frame(features[,selected$Index[i]])
		colnames(tmp) <- selected$Name[i]
		tidyFeaturesData <- cbind(tidyFeaturesData, tmp)}
  
#		 builds dataframe containing mean
	meanActivitySubject <- as.data.frame( aggregate(tidyFeaturesData[,-(1:3)], list(Subject=tidyFeaturesData$Subject, Activity=tidyFeaturesData$Name), mean))
  
	out_means
}

	out_means <- run_analysis()
	write.table(out_means, "./averageForSubjectAndActivity.csv")