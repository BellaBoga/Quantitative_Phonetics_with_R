#TASK 14#
#-------#
# Find another function to repeat a certain piece of code. 
#How does this differ from for() and what do you have to take into account using it?

while (condition) {
  instruction
}

# while loops executes while a certain condition is true, it is useful when the number 
# of iterations is not known in advance



#TASK 15#
#-------#
# Given two existing dataframes DF1 and DF2, come up with a
#solution to the problem of binding dataframes with different column names.

DF1 = data.frame(this = 1:5, that = letters[1:5])
DF2 = data.frame(those = 6:10, these = letters[6:10])

colnames(DF1) <- colnames(DF2)

DF3 = data.frame(rbind(DF1, DF2)) 
DF3


#TASK 16#
#-------#
# Take your solution from task 3.5 and adapt it in such a way that it can be executed in the for() loop from above. In the end you want to 
# store all TextGrids in one dataframe "DFbig". Proceed in the following way: 
# In each iteration, first clean the loaded data, extract all necessary information (word start, word end, word), and then append it to DFbig. STORE IT!
DIR = "/home/luana/Documents/School/WS16-17/Quantitative Phonetics/KEC"

setwd(DIR)#set working directory
filenames = list.files(pattern='TextGrid')#get filenames

DFbig = data.frame() #create new dataframe 
nrow(DFbig)
for (i in 1:length(filenames)) {
  #get one filename. this is the point where the 
  #result of the iteration is applied
  FN = filenames[i]
  #store dataframe temporarily
  data = read.table(FN, fill = NA, stringsAsFactors=FALSE)
  
  cat(i, '. iteration:', nrow(DFbig), 'rows\n')
  whereIntervals = data$V1 == 'intervals'
  #create a vector of indexes where the intervals are
  whereIntervals.numeric = which(whereIntervals)
  
  #start index of the interval
  where.start = whereIntervals.numeric+1
  #end index of the interval
  where.end = whereIntervals.numeric+2
  #index of the word
  where.word = whereIntervals.numeric+3
  
  #store the actual words in a variable
  w.word = as.character(data$V3[where.word])
  #store start time of the word
  w.start = as.numeric(as.character(data$V3[where.start]))
  #store end time of the word
  w.end = as.numeric(as.character(data$V3[where.end]))
  
  #make a data frame with 3 columns: word, start time, end time
  DF.textgrid = data.frame(word = w.word,
                           starts = w.start,
                           ends = w.end,
                           duration = w.end - w.start, stringsAsFactors = FALSE)
  
  
  #bind to DFbig
  DFbig = rbind(DFbig, DF.textgrid)
}
dim(DFbig)
save(DFbig, file = '../RDA/DF_textgrids.rda')	
