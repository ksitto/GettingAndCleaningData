# GettingAndCleaningData
Course project for the Coursera Getting and Cleanining Data class

This is my submission for the final project of the Getting and Cleaning Data course. This submission consists of a single [r script](http://www.r-project.org/) which does the following:

1. Download the _Human Activity Recognition Using Smartphones Data Set<sup>1</sup>_ from [a mirror provided](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) by the course instructors and unpack the contents.
2. Merge the test and training data into one large dataset
3. Filter the data down to only the subset of columns which containg aggregate data like means and standard deviations
4. Enrich the dataset with descriptive column names 
5. Perform a final bit of addition aggregation to calculate the arithmetic means of all the columns from step 3, grouped by participant & activity.

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
