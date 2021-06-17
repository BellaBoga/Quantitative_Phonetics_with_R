 ## >> WORK ON THIS CODE ON YOUR OWN 
## READ R-introduction manuscript: pages  55-68

############################################################
## A) EXCURSION: Repetition in programming
############################################################


## Simple for loop using numerics

for(something in 1:10){

}#end of for something loop



for (iloop in 1:3){
result = iloop+1
cat('In loop', iloop, 'we add one to', iloop,'and the result is', result, '\n')
}



## Simple for loop using strings
stringvector = c('a', 'b', 'c', 'd')
for (iloop in stringvector){
cat('The current value of iloop is: ', iloop, '\n')
}


## Perform operation within a for loop
stringvector = c('Live', 'long', 'and', 'prosper')
for (iloop in stringvector){
Vulcan.o = grepl('o', iloop)
cat('The value in iloop contains the letter "o":', Vulcan.o, '\n')
}


## Accessing dataframes/vectors within loops

DF = data.frame(1:10, 11:20)
colnames(DF) <- c('Funny', 'Moments')

for (iloop in 1:10){
tmp = DF[iloop,]
tmp
}


for (iloop in 1:10){
tmp = DF[iloop,]
print(tmp)
}



#TASK 14#
#-------#
# Find another function to repeat a certain piece of code. How does this differ from for() and what do you have to take into account using it?



############################################################
## B) EXCURSION: Binding operations
############################################################

##rbind
DF1 = data.frame(A = 1:3, B = 11:13)
DF2 = data.frame(A = 1:3, B = 11:13)
DF3 = data.frame() #empty DF
DF3 = rbind(DF1, DF2)
DF3

# premisses for r-binding:
# 1) number of columns must be the same

#create dataframes
DF1 = data.frame(A = 1:3, B = 11:13, C = letters[1:3])
DF2 = data.frame(A = 1:3, B = 11:13)
#try to bind ---- nope, not working
DF3 = data.frame() #empty DF
try({
DF3 = rbind(DF1, DF2)
print(1+1)
})#try environment

DF3



# 2) Names must be the same

DF1 = data.frame(A = 1:3, B = 11:13)
DF2 = data.frame(C = 1:3, D = 11:13)
#assess names
colnames(DF1)
colnames(DF2)
#bind
DF3 = data.frame() #empty DF
try({DF3 = rbind(DF1, DF2)}, silent =FALSE)
DF3




########################################
### TASK ###############################
########################################

#TASK 15#
#-------#

# Given two existing dataframes DF1 and DF2, come up with a solution to the problem of binding dataframes with different column names.


##########  Reading in multiple dataframes #####
################################################
DIR = '/home/fabian/Dropbox/Uni/Texte/Paper/Baayen_Gruppe/WIP/R_programming/data/KEC/' 

setwd(DIR)#set working directory
filenames = list.files(pattern='TextGrid')#get filenames

DFbig = data.frame() #create new dataframe 
nrow(DFbig)
ifile = 1

for (ifile in 1:length(filenames)){
  #get one filename. this is the getpoint where the 
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


########################################
### TASK ###############################
########################################

#TASK 16#
#-------#
# Take your solution from task 3.5 and adapt it in such a way that it can be executed in the for() loop from above. In the end you want to 
# store all TextGrids in one dataframe "DFbig". Proceed in the following way: 
# In each iteration, first clean the loaded data, extract all necessary information (word start, word end, word), and then append it to DFbig. STORE IT!








