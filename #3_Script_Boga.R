#set working directory
setwd('/home/bella/Dropbox/Master/1st Semester/Quantitative Phonetics with R/Material Corpus etc/KEC') 
install.packages('gtools')
library(gtools)

#TASK 3#
# Given the two existing dataframes DF1 and DF2, come up with a solution to the problem 
#of binding dataframes with different column names.

DF1 = data.frame(A = 1:3, B = 11:13, C = letters[1:3])
DF2 = data.frame(A = 1:3, B = 11:13)
DF3 = data.frame() #empty DF
DF3 = smartbind(DF1,DF2)
DF3

#TASK 10#

# Using DF.textgrid, create a dataframe without pauses <P>. Store the new dataframe in DF.words. 
DF.words= DF.textgrid[!DF.textgrid$word == '<P>',]
DF.pauses = DF.textgrid[DF.textgrid$word == '<P>',]

#TASK 10#
#-------#
# Let's do some corpus statistics

# a) How many Pauses does the original dataframe contain? How many words?

nrow(DF.pauses)
nrow(DF.words)

# b) Calculate the percentage of pauses in the entire dataframe.
(nrow(DF.pauses)/nrow(DF.textgrid))*100

# c) How many "ich" words does the DF.textgrid contain?
nrow(DF.textgrid[DF.textgrid$word == 'ich',])

# d) How many "du" words does the DF.textgrid contain?
nrow(DF.textgrid[DF.textgrid$word == 'du',])

# e) How often is the word "du" followed by the word "meinst"?
NewDF = DF.textgrid[which(DF.textgrid$word == 'du')+1,]
nrow(NewDF[NewDF$word == 'meinst',])

# f) How many Words are shorter than 100ms?
nrow(DF.words[DF.words$wordduration < 0.1,])


# g) How many Words are longer than 100ms?
nrow(DF.words[DF.words$wordduration > 0.1,])

# f) How many Pauses are shorter than 100ms?
nrow(DF.pauses[DF.pauses$wordduration < 0.1,])

# g) How many Pauses are longer than 100ms?
nrow(DF.pauses[DF.pauses$wordduration > 0.1,])



#TASK 12#
# Create a set of new vectors and append them to DF.textgrid:
# a) - a new vector "NextWord", containing the following word 
# b) - a new vector "Next2Word", containing the second next word
DF.textgrid$NextWord = c(DF.textgrid$word [seq(from = 2, to = nrow(DF.textgrid))], '')
DF.textgrid$Next2Word = c(DF.textgrid$word [seq(from = 3, to = nrow(DF.textgrid))], '', '')


#TASK 13#
# Do the same thing for "PrecedingWord" and "Preceding2Word"

DF.textgrid$PrevWord = c('', DF.textgrid$word [seq(from = 1, to = nrow(DF.textgrid)-1)])
DF.textgrid$Prev2Word = c('', '', DF.textgrid$word [seq(from = 1, to = nrow(DF.textgrid)-2)])

