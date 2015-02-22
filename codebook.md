### Gettting-And-Cleaning-Data Course Project Codebook

## Variables
    1. Subject :
	There were 30 subjects so you should see 30 IDS in first column for each 30 subjects.
   	These are retrieved from subject_*.txt
    2. Activity :
	There were 6 activities WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING". 
	You should see second column in tidy data for it correctly named. Activity lables are created by taking activity_lables.txt and 
	then applying mutate function to using factors to generate the lables
    3. Feature Variables  
	Each feature variable has applied transformations from features.txt to generates the lables by coercing into the text and then applying various regular expressions.
        

## Aggregations 

   1. Aggregation on the final data set was done by first arranging by subject and then grouping by subject and activity levels.
   2. A final summarize was applied using a mean function to get the average of mean and std dev columns




