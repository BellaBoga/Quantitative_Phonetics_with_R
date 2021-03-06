#TASK 19#
#-------#
#1) Please add a bigram column to "DFbig". In a sequence of ABC (I love R) take into a
#ccount bigrams with the pattern AB (I love) and
#bigrams with the pattern BC (love R) for the target word B, i.e. love.

#2) Please add bigram counts to "DFbig" for both patterns, AB and BC. 

# facultative 3): If you feel very bored during the vacations and have nothing to do, 
#you could calculate the durations for the bigrams and include them into the dataframe "DFbig". 


DIR = '/home/bella/Dropbox/Master/1st Semester/Quantitative Phonetics with R/Material Corpus etc/KEC/' 

setwd(DIR)
load('DF_textgrids_addedinformation.rda')

#1
DFbig$ABbigram = NA
DFbig$BCbigram = NA
for(iword in 1:length(DFbig$word)){
  if(iword == 1)
  {
    AB = paste("<NA>",DFbig$word[iword])
    BC = paste(DFbig$word[iword],DFbig$word[iword+1])
  }
  else if(iword == length(DFbig$word))
  {
    AB = paste(DFbig$word[iword-2],DFbig$word[iword-1])
    BC = paste(DFbig$word[iword-1],"<NA>") 
  }
  else
  {
    AB = paste(DFbig$word[iword-1],DFbig$word[iword])
    BC = paste(DFbig$word[iword],DFbig$word[iword+1])
  }
  DFbig$ABbigram[iword] = AB
  DFbig$BCbigram[iword] = BC
}

#2

DFbig$ABFreq = NA
DFbig$BCFreq = NA

ABFreq = sort(table(DFbig$ABbigram), decreasing = TRUE)
BCFreq =sort(table(DFbig$BCbigram), decreasing = TRUE)

head(ABFreq)

for(iword in 1:length(DFbig$word))
{
  AB = ABFreq[iword]
  BC = BCFreq[iword]
  whichAB = names(AB)
  whichBC = names(BC)
  whereAB = DFbig$ABbigram == whichAB
  whereBC = DFbig$BCbigram == whichBC
  DFbig$ABFreq[whereAB] = AB
  DFbig$BCFreq[whereBC] = BC
}
