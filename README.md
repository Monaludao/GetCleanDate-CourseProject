the folders is uploaded for the course project assignment of "Getting and Cleaning 
Data" course on coursera.com

the run_analysis.R file contains 3 functions: run_analysis, mergedata and casting
the mean_output.txt is the output of the run_analysis function
the code book.md indicates the variables in the mean_output.txt

## run_analysis function
the main function is the run_analysis functino as demanded in the project instruction.
overall, the function including 4 parts.
### first part: load packages
In this assignment, "plyr" and "reshape2" packages will be used

### second part: merge train and test datasets
The idea is to build another function called "mergedata" to merge train and test 
datasets as there are 3 datasets needed to be merged. Thus the datasets are firstly 
connected by file() function (6 files in total), and passed to mergedata() function.
Close() function is used to close the connections in the end of this part.

### third part: deal with the variables' name and activity labels
The variables' name in "merge.x" and the activity labels in "merge.y" are described 
as text files in the original datasets (features.txt and activity_labels.txt). 
So the idea is to read them into data frames in the first place for further usage.
Two data frames are created to store the variables' name (feature.df) and activity 
labels (actlabel.df).

### fourth part: prepare the data which is needed in this project
In this part, the cols' name of the merged datasets are assigned for further demand:
merge.x - col.names which is subsetted from feature.df 
merge.y - "activity"
merged.subject - subjects

A new data frame called sub.df is subsetted from merge.x where the col names contains
"mean" or "std" - as instructed in the assignment -  through grep() function. 
The activity code are replaced by descriptive labels according to actlabel.df through
a for loop. By the end of this part a subsetted data frame is prepared for next step.

### fifth part: produce the required tidy data
The sub.df is splitted by subject id through split() function and passed to the 
casting() function to calculate the mean of each variable. The mean_output.txt is
created through write.table() function to produce the data which is uploaded to 
coursera.com.

## mergedata function
This function is designed to save memories and redundant coding since there are 
three datasets needed to be merged. The argguments include two file connection 
and the wanted class of the returned data frame which takes "factor" as default.

## casting function
This function is designed to melt and cast the splited data to calculate the means
of each variable by activity for each subject.