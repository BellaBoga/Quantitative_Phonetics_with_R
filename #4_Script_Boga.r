#TASK 14#
#-------#
# Find another function to repeat a certain piece of code. 
#How does this differ from for() and what do you have to take into account using it?

repeat{
  statements...
  if(condition){
    break
  }
}

#--> This gets executed at least once no matter what the condition is whereas a for loop  gets executed a known number f of times

while (test_expression)
{
  statement
}

#A while loop is used when the number of iterations is unknown so you execute some piece of code WHILE it is true

#TASK 15#
#-------#

# Given two existing dataframes DF1 and DF2, come up with a
#solution to the problem of binding dataframes with different column names.

DF1 = data.frame(yourmum= 1:3, yourdad=11:13)
DF2 = data.frame(whatevs=1:3, dgaf=11:13)


#change column names
colnames(DF1) <- colnames(DF2)

colnames(DF1)

colnames(DF2)

DF3 = data.frame() #empty DF
DF3 = rbind(DF1, DF2)
DF3

#TASK 16#
#-------#
# Take your solution from task 3.5 and adapt it in such a way that it can be executed in the for() loop from above. In the end you want to 
# store all TextGrids in one dataframe "DFbig". Proceed in the following way: 
# In each iteration, first clean the loaded data, extract all necessary information (word start, word end, word), and then append it to DFbig. STORE IT!

DIR = '/home/bella/Dropbox/Master/1st Semester/Quantitative Phonetics with R/Material Corpus etc/KEC/' 

setwd(DIR)#set working directory
getwd()
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
  #bind to DFbig
  DFbig = rbind(DFbig, tmp)
  cat(ifile, '. iteration:', nrow(DFbig), 'rows\n')
}
dim(DFbig)
#DO. NOT. FORGET. TO. SAVE!!!!
save(DFbig, file = '../RDA/DF_textgrids.rda')




