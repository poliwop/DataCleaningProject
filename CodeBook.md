*run_analysis.R

Columns from initial data (see below for data source) were selected that corresponded to mean and std variables of measurements. The following 66 columns were chosen:
1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543.

Names for these columns were chosen which were very similar to their names in the initial data, but without certain problematic syntax, and fixing small typos (e.g. tBodyAcc-mean()-X became BodyAccX_mean and fBodyBodyAccJerkMag-mean() became fBodyAccJerkMag_mean). Note that variables prefixed by lowercase f are frequency domain signals, whereas the absence of such a prefix indicates time domain signals. More explanatory renaming was skipped due to the author's uncertainty as to what precisely the variables represented. The author will therefore defer to the explanation of the variables provided with the initial data, outlined in ./data/README.txt.

The desired columns were then read in from the training and testing data,
and the two datasets were combined and labeled with the aforementioned names.
Subject indentifiers were then read in, and added as a subject column to the data frame. Activity data was next read in, and the activity identifiers were replaced by descriptive text, and appended as an activity column to the data frame.

The original 66 variables were averaged for each combination of subject and activity, to produce a data frame with 180 observations (30 subjects times 6 activities) of averages of the 66 variables. Note that in the last step, two columns denoting subject and activity were moved to the front of the data frame.

This summary data was then written to averageData.txt in the working directory.



*Data Source:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - UniversitÃ  degli Studi di Genova, Genoa I-16145, Italy.
activityrecognition '@' smartlab.ws
www.smartlab.ws 

The initial data was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip on September 11, 2014.

A more in-depth description of the initial data can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

