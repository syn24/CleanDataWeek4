## CodeBook
#Describing variables and summaries in the run_analysis code

# Step 1
- Read in all necessary files into variables:
  - labels (contains the activity labels)
  - features (contains all features)
  - two sets of subject tables for training and testing (subject1, subject2)
  - two sets of X values for training and testing (x1, x2)
  - two sets of Y values for training and testing (y1, y2)
  
- Combining test and training data to subject, x and y using rbing

#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

- Filtering dataframe features for columns containing either "mean" or "std" and saving it to a variable onlyMeanAndStdFeatures
- Read out the indices in column "V1" from onlyMeanAndStdFeatures and store it in a vector indices
- Read out the feature names in column "V2" from onlyMeanAndStdFeatures and store it in a vector colNames
- Filter x for columns with column indices from vector "indices" and store it in a dataframe xOnlyMeanAndStdCols

#Step 3: Uses descriptive activity names to name the activities in the data set

- Assign column names "labelid" and "activity" to dataframe labels
- Assign column names "featureid" and "feature" to dataframe features

#Step 4: Appropriately labels the data set with descriptive variable names.

- Assign column name "subjectId" to dataframe subject
- Assign vector colNames from step 2 as column names to the filtered dataframe xOnlyMeanAndStdCols
- Assign column name "labelId" to y

#Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

- Combine dataframes subject, y, XOnlyMeanAndStdCols to a new dataframe mergedDS via cbin
- Group mergedDS by subjectId and labelId and for all columns, calculate the mean value for the grouping, the result is assigned to a new dataframe averageDS
- At the end, this dataframe averageDS is persisted to disk in a file names "tidyDataSet.txt" and printed to console
