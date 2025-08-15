# Description of run_analysis.R

Author: Krish Kohir

The run_analysis file reads the data for [Human Activity Recognition in Smartphones](https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones) and creates a text file containing a data table of the average values of the variables in the data. 

## STEP 1: Download
The script checks if the data has already been downloaded. If not, the script downloads the data and checks if it has been unzipped. If not, the script unzips the file. 

## STEP 2: Data acquisition
The script parses through the various text files and stores the data in data frames. 

## STEP 3: Data merging
The script merges the data in x_test, x_train, y_test, y_train, subject_test, subject_train into one data file using rbind() and cbind()

## STEP 4: Data extraction
The script stores the subjects, codes, and mean/standard deviation values into a separate data frame using select()

## STEP 5: Data titles renaming
The script renames the codes to their respective activity using the activity data frame. Then, the script replaces abbreviated/unclear terminology in the data frame titles with more descriptive terms

## STEP 6: Text file creation
The script groups each subject together into their respective activities, and gets the average data values for each of these variables. The new data frame is then written into a text file 
