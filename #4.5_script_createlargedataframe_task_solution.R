#TASK 15#
#-------#
# Take your solution from task 3.5 and adapt it in such a way that it can be executed in the for() loop from above. In the end you want to 
# store all TextGrids in one dataframe "DFbig". Proceed in the following way: 
# In each iteration, first clean the loaded data, extract all necessary information (word start, word end, word), and then append it to DFbig. STORE IT!


## PROBLEMS
#1 : tier names are not consistent
#2 : the location of tier names is not consistent



## STEP 1: Check TIERNAMES

DIR = '/home/fabian/Dropbox/Uni/Texte/Paper/Baayen_Gruppe/WIP/R_programming/data/KEC/' 

setwd(DIR)#set working directory
filenames = list.files(pattern='TextGrid')#get filenames

for (ifile in 1:length(filenames)){
  #get one filename. this is the point where the 
  #result of the iteration is applied
  FN = filenames[ifile]
  #store dataframe temporarily
  tmp = read.table(FN, fill = NA, stringsAsFactors=FALSE)
  
  index = which(tmp$V1 == 'name')#get column number
  cat(ifile, tmp$V3[index], '\n')
}




## STEP 2 Read in TG
DIR = '/home/fabian/Dropbox/Uni/Texte/Paper/Baayen_Gruppe/WIP/R_programming/data/KEC/' 

setwd(DIR)#set working directory
filenames = list.files(pattern='TextGrid')#get filenames

DFbig = data.frame() #create new dataframe 
nrow(DFbig)
ifile = 1

for (ifile in 1:length(filenames)){
  
  #get one filename. this is the point where the 
  #result of the iteration is applied
  FN = filenames[ifile]
  #store dataframe temporarily
  tmp = read.table(FN, fill = NA, stringsAsFactors=FALSE)
  
  
  #delete uncorrected words
  index = which(tmp$V1 == 'name')#get column number
  Tiernames = tmp$V3[index]
  
  index = c(index, nrow(tmp))
  names(index) = c(Tiernames, 'End')
  whereCorr = which(Tiernames == 'words-corr')
  take = seq(from = index[whereCorr], to = index[whereCorr+1], by = 1)
  
  tmp2 = tmp[take,]
  
  #find intervals
  whereIntervals = tmp2$V1 == 'intervals'
  whereIntervals.numeric = which(whereIntervals)
  
  
  #index the data
  where.start = whereIntervals.numeric+1
  where.end = whereIntervals.numeric+2
  where.word = whereIntervals.numeric+3
  
  #access data
  w.start = as.numeric(as.character(tmp2$V3[where.start]))
  w.end = as.numeric(as.character(tmp2$V3[where.end]))
  word = tmp2$V3[where.word]

  #create textgrid
  DF.textgrid = data.frame(
  word = word,
  w.start = w.start,
  w.end = w.end, 
  wordduration = w.end - w.start, 
  stringsAsFactors = FALSE)

  #bind to DFbig
  DFbig = rbind(DFbig, DF.textgrid)
  cat(ifile, '. iteration:', nrow(DFbig), 'rows\n')

  }


dim(DFbig)
#DO. NOT. FORGET. TO. SAVE!!!!
save(DFbig, file = '../RDA/DF_textgrids.rda')
