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
strs <- DFbig$Filename
#strings to be replaced
replace.vect <- c("_CUT_","20MIN","10min", "_1.TextGrid", "_2.TextGrid", "_3.TextGrid", "_4.TextGrid", "_5.TextGrid", "_6.TextGrid")
#replace by what
new.char.vect <- c ("","","","","","","","","")
tmp <- strs
#for each file up to the end replace the vector with the new empty string
for(i in 1:length(replace.vect)) {
  tmp <- gsub(replace.vect[i], new.char.vect[i], tmp)
}
unique(DFbig$filename)
