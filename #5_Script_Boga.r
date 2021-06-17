#TASK 16#
#-------#

# Above, in "#7 apply changes", we need to get rid of the copy+pasting behavior during our writing scripts, 
#as this burns our time. Also, copy+pasting increases the probability of typos. 
# Write a script, in which the substitution using gsub() is performed iteratively in a for() loop.
DIR = '/home/bella/Dropbox/Master/1st Semester/Quantitative Phonetics with R/Material Corpus etc/KEC/' 

FILE = 'SpeakerInformation.csv'
setwd(DIR)
SpeakerInfo = read.csv(
  file = FILE, 
  stringsAsFactor=FALSE, 
  sep = " "
)
setwd(DIR)
load("DFbig.rda", verbose = TRUE)
head(DFbig,2) #check target dataframe

SpeakerInfo = read.csv(
  file = 'SpeakerInformation.csv', #filename
  header = TRUE, #there is a header
  sep = " ", #spaces separate columns
  stringsAsFactor=FALSE, #no factors
  as.is = TRUE, #do not perform transformations
  quote = "" #no quotes
)
iChange = c('"',"_CUT_","20MIN","10min","_1.TextGrid","_2.TextGrid","_3.TextGrid","_4.TextGrid","_5.TextGrid","_6.TextGrid")
for (i in 1:length(iChange)) 
{
  DFbig$filename = gsub(iChange[i],"", DFbig$filename)
}
head(DFbig)
unique(DFbig$filename)

#TASK 17#
#-------#
# Inspect the rest of the information added to DFbig. 
#Can you work with all of them correctly? If not, what steps would you do in order to change that?

DFbig$Sex = gsub("","",DFbig$Sex)
unique(DFbig$Sex)

#inspected the dataframe, came to the following conclusions
#we need to get rid of the Umlaute 



DFbig$Sex2=ifelse(DFbig$Sex2=='weiblich','female','male')
head(DFbig,2)
DFbig$Sex2 = gsub('weiblich',"female", DFbig$Sex2)
DFbig$Sex2=ifelse(DFbig$Sex2=='männlich','female','male')
head(DFbig,2)
DFbig$Sex2 = gsub('männlich',"male", DFbig$Sex2)
head(DFbig)
grep(as.character(as.numeric('"')),DFbig$Sex)
head(DFbig$Sex)
gsub('"',"",DFbig$Sex)
head(DFbig$Sex)
unique(DFbig$Sex)
