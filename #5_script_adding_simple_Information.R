
###########################################################
## READING SPEAKER INFORMATION
###########################################################

DIR = '/home/bella/Dropbox/Master/1st Semester/Quantitative Phonetics with R/Material Corpus etc/KEC'

### First check the file and its formatting using a text editor!
FILE = 'SpeakerInformation.csv'
setwd(DIR)
SpeakerInfo = read.csv(
  file = FILE, 
  stringsAsFactor=FALSE, 
  sep = " "
  )

head(SpeakerInfo)
str(SpeakerInfo)






# str(SpeakerInfo)
# 'data.frame':	72 obs. of  6 variables:
#  $ SubjID               The speaker's identity number. Note that this number coincides with the last number in the file name (cf. row names).
#  $ Sex                  The speaker's sex. This column contains characters.
#  $ Birthyear            His or her birthyear.This colum contains strings (characters).
#  $ RecordingDateDDMMYYYY: The recording date for the file. This column contains integers. 
#  $ SizeInCm           The body size of the speaker in cm. This column contains integers. 
#  $ WeightInKg 	The speaker's weight in kg. This column contains integers.


### Checking the content in "SpeakerInformation"
#Problem: Not All dates have the same number of characters. cf. file

SpeakerInfo[4:8,c('SubjID', 'RecordingDateDDMMYYYY')]

#check whether number of characters is the same across all rows.
HowManyPositions = nchar(SpeakerInfo$RecordingDateDDMMYYYY)
AllEight = HowManyPositions == 8
sum(AllEight)
nrow(SpeakerInfo)
sum(AllEight) == nrow(SpeakerInfo)

## Apply some changes to read.csv parameters


SpeakerInfo = read.csv(
  file = 'SpeakerInformation.csv', #filename
  header = TRUE, #there is a header
  sep = " ", #spaces separate columns
  stringsAsFactor=FALSE, #no factors
  as.is = TRUE, #do not perform transformations
  quote = "" #no quotes
)

SpeakerInfo[4:8,c('SubjID', 'RecordingDateDDMMYYYY')]

###########################################################
## MERGING INFORMATION
###########################################################
setwd(DIR)
load("DF_textgrids.rda", verbose = TRUE)
head(DFbig,2) #check target dataframe



################################################################## 
## QUESTION: How would you append the speaker information manually (pen+paper)?
##################################################################

# two possibilities: Use DFbig as basis or SpeakerInfo as basis


# A)
# \item Take row 1 from dataframe "DFbig". 
# \item Take filename.
# \item Find appropriate speaker in dataframe "SpeakerInfo". 
# \item Copy information from "SpeakerInfo" and append to row 1 in dataframe "DFbig"
# \item Go to row 2 and repead the above steps.
# 
# 
# B)
# \item Take row 1 from dataframe "SpeakerInfo". 
# \item Take filename.
# \item Find the rows in dataframe "DFbig" which match the filename.
# \item Copy information from "SpeakerInfo" and append to all respective rows in dataframe "DFbig"
# \item Go to row 2 in "SpeakerInfo" and repead the above steps.




###########################################################
## Step by step approach to writing code
###########################################################


#1 write frame for-loop
for (irow in 1:nrow(SpeakerInfo)){
}

#2 access SpeakerInfo iteratively
for (irow in 1:nrow(SpeakerInfo)){
info = SpeakerInfo[irow,]#access rows in SpeakerInfo

#3 checking by dummy coding 
irow = 1
info = SpeakerInfo[irow,]
info 

}
#4 Matching process using filename
info$filename
DFbig$filename[1]

#5 Substitution and deletion in strings
one = gsub('"', "", SpeakerInfo$filename[1])
one
two = gsub("_CUT_20MIN_1.TextGrid", "", DFbig$filename[1])
two
one == two #check whether they match




# check substitution and deletion in strings
# Substitution and deletion in strings
one = gsub('"', "", SpeakerInfo$filename[1])
one
two = gsub("_CUT_20MIN_1.TextGrid", "", DFbig$filename[1])
two
one == two #check whether they match

#6 check extents of needed changes
unique(DFbig$filename)



#7 apply changes
SpeakerInfo$filename = gsub('"', "", SpeakerInfo$filename)#replace by empty
DFbig$filename = gsub("_CUT_", "", DFbig$filename)
DFbig$filename = gsub("20MIN", "", DFbig$filename)
DFbig$filename = gsub("10min", "", DFbig$filename)
DFbig$filename = gsub("_1.TextGrid", "", DFbig$filename)
DFbig$filename = gsub("_2.TextGrid", "", DFbig$filename)
DFbig$filename = gsub("_3.TextGrid", "", DFbig$filename)
DFbig$filename = gsub("_4.TextGrid", "", DFbig$filename)
DFbig$filename = gsub("_5.TextGrid", "", DFbig$filename)
DFbig$filename = gsub("_6.TextGrid", "", DFbig$filename)

unique(DFbig$filename) 
#well, that worked nicely!
# Make sure to check 

#8 perform searching of appropriate rows 
irow = 1 #dummy coding
info = SpeakerInfo[irow,] #extract information
whichrows = DFbig$filename == info$filename #find rows
head(DFbig[whichrows,])




#9 Set up empty columns (for safety and debugging reasons)
DFbig$Sex = NA
DFbig$Birthyear = NA
DFbig$SizeInCm = NA
DFbig$WeightInKg = NA
DFbig$RecordingDateDDMMYYYY = NA


#10 set up a for-loop
for (irow in 1:nrow(SpeakerInfo)){
  info = SpeakerInfo[irow,]#access rows in SpeakerInfo
  whichrows = DFbig$filename == info$filename #find rows

  #attach information
  DFbig$Sex[whichrows] = info$Sex 
  DFbig$Birthyear[whichrows] = info$Birthyear 
  DFbig$SizeInCm[whichrows] = info$SizeInCm
  DFbig$WeightInKg[whichrows] = info$WeightInKg
  DFbig$RecordingDateDDMMYYYY[whichrows] = info$RecordingDateDDMMYYYY
}

#11 First, superficial check of result of for-loop
head(DFbig)

#save 
setwd(DIR)
save(DFbig, file = 'DF_textgrids_addedinformation.rda')

#12 Second, deeper check of deletion of NAs
nrow(DFbig)
sum(!complete.cases(DFbig))

#complete.cases
complete.cases(NA)
complete.cases(NaN)
complete.cases(1)
complete.cases('a')



###########################################################
## Debugging
###########################################################
# Debugging / writing code ration: at the beginning 70/30. later: 30/70.

#13 Find the appropriate column with missing data
summary(DFbig)

#14 Find the rows
whereNA = is.na(DFbig$Birthyear)
sum(whereNA)


## Possibility 1 for NA: We did not perform a good job in matching filenames
NoInfoHere = unique(DFbig$filename[whereNA])
NoInfoHere

#no, everything alright

## Possibility 2 for NA: Filename is missing in SpeakerInfo
IsItThere = SpeakerInfo$filename == NoInfoHere
head(IsItThere)
sum(IsItThere)
#well, yes, its there

## Possibility 3 for NA: Information about "Birthyear" not included in SpeakerInfo 

str(SpeakerInfo[IsItThere,])


########################################
### TASK ###############################
########################################

#TASK 15#
#-------#

# Above, in "#7 apply changes", we need to get rid of the copy+pasting behavior during our writing scripts, as this burns our time. Also, copy+pasting increases the probability of typos. 
# Write a script, in which the substitution using gsub() is performed iteratively in a for() loop.


#TASK 16#
#-------#
# Inspect the rest of the information added to DFbig. Can you work with all of them correctly? If not, what steps would you do in order to change that?




