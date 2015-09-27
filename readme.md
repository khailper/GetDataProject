##unzip data set
We start by retrieving the data from the zip file.

##get test data/get training data
Next, we read the test and traingin data in from their respective folders.  Subject IDs are stored in the subject file, y has the activity codes, and X the readings.  The three files are combined to form complete test and training data sets.

##merge the two
The test and data sets are merged to form one data set for the rest of the analysis.  We then reorder the combined data set to correct for the fact that the rbind left our subject out of order.  This isn't technically necessary, but it makes the data read better.

##name the variables
Currently, our variables are named V1, V2, etc.  In order to give them more meaningful names, we grab the names used by the data source.  However, this doesn't provide names for Subject and Activity, so those have to be added manually before we feed the list of variables names to our data frame.

##use descriptive names for Activity values
Activity status is currently denoted with a number rather than descriptive text.  We use the explanitory table in the source to correct this.

##extract just means and standard deviation
We use grep to find grep create indicies the variables with "mean()" or "std()" in their names.  These indicies are  with 1:2 (Subject and Activty) and sorted into numeric order (Sorting is again optional.  It preserves the original order rather than "Subject, Activity, all the means, all the stadard deviations  The analysis isn't order dependent; I just prefer it this way). The index is used to subset our merged data to just hte variables we want.

##average variables for each subject and each actvity
Using the reshape2 package, we melt and recast to get the mean of each variable for each Subject/Activty combination.