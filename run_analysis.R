run_analysis <- function(){
        library(plyr)
        library(reshape2)
        
        ## connect the train and test datasets
        train.x <- file("./UCI HAR Dataset/train/X_train.txt","r")
        train.y <- file("./UCI HAR Dataset/train/y_train.txt","r")
        train.subject <- file("./UCI HAR Dataset/train/subject_train.txt","r")
                
        test.x <- file("./UCI HAR Dataset/test/X_test.txt","r")
        test.y <- file("./UCI HAR Dataset/test/y_test.txt","r")
        test.subject <- file("./UCI HAR Dataset/test/subject_test.txt","r")
        
        ## merge two datasets through mergedata() function
        merge.x <- mergedata(train.x,test.x,"numeric")
        merge.y <- mergedata(train.y,test.y)
        merge.subject <- mergedata(train.subject,test.subject)
        
        ## close the connections
        close(train.x); close(train.y); close(train.subject)
        close(test.x); close(test.y); close(test.subject)
                
        ## read the feature.txt and activity_label.txt into a data frame, 
        ## to get the variables' and the activities' names 
        features.df <- ldply(strsplit(readLines("./UCI HAR DATAset/features.txt")," "))
        col.names <- as.vector(features.df[,2])
        actlabel.df <- ldply(strsplit(readLines("./UCI HAR DATAset/activity_labels.txt")," "))
        actlabel.df$V2 <-as.factor(actlabel.df$V2) 
        
        ## set colums names of merge.x, merge.y and merge.subject for 
        ## latter usage
        colnames(merge.x) <- col.names
        colnames(merge.y) <- "activity"
        colnames(merge.subject) <- "subjects"
                        
        ## subset the measurements on mean and standard deviation from 
        ## data frame merge.x
        mean.cols <- grep("mean",features.df[,2])
        std.cols <- grep("std",features.df[,2])
        sub.cols <- sort(c(mean.cols,std.cols))
        sub.x.df <- merge.x[,sub.cols]
        sub.df <- cbind(merge.subject, merge.y, sub.x.df)
        
        ## a for loop to replace activity variable by activity names
        for (i in 1:nrow(actlabel.df)){
                sub.df$activity <- gsub(actlabel.df[i,1],actlabel.df[i,2],sub.df$activity)
        }
        sub.df$activity <- as.factor(sub.df$activity)
        
        ## split groups by subjects variable
        sub.sp <- split(sub.df,sub.df$subjects)
        sub.cast.ls <- lapply(sub.sp,casting)
        
        for (i in 1:length(sub.cast.ls)){
                if (i==1) {output.df <- sub.cast.ls[[i]]; next}
                else{output.df <- rbind(output.df, sub.cast.ls[[i]])}
        }
        
        write.table(output.df, file="mean_output.txt", row.name=FALSE)
}

## a function to cache and merge two datasets
mergedata <- function(data1,data2,class="factor"){
       m <- read.table(data1,colClasses = class)
       n <- read.table(data2,colClasses = class)
       mergedata <- rbind(m,n)
       m <- NULL; n <- NULL
       mergedata
}

casting <- function(data="data.frame") {
        data.melt <- melt(data,id.vars=c("subjects","activity"))
        data.cast <- dcast(data.melt, subjects + activity ~ variable,mean)
        data.cast
}