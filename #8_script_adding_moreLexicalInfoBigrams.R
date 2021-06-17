DIR = '/home/fabian/Dropbox/Uni/Seminare/Seminar_2017_CorpusStudies/Data/'

setwd(DIR)
load('DF_textgrids_addedinformation.rda', verbose = TRUE)
head(DFbig2)
DFbig = DFbig2
##### add word counts

W.counts = sort(table(DFbig$word), decreasing = TRUE)

for(iword in 1:length(W.counts)){#iterate

  if(iword %% 10 == 0){cat('Processed', iword, 'of', length(W.counts), 'items\n')}#print status

  count = W.counts[iword]#acces
  which.word = names(count)#take colname
  where = DFbig$word == which.word#find rows
  DFbig$Count[where] = count

}#end for loop



##########################################################
## Create bigrams and add bigram counts
##########################################################

## create bigrams by filename!
FN = unique(DFbig$filename)
DFbig2 = data.frame() #dummy

ifn = FN[1]

for (ifn in FN){
  tmp = DFbig[DFbig$filename == ifn,]
   
  Target =  tmp$word

  A= c('#', Target[1:(nrow(tmp)-1)])
  C= c(Target[2:nrow(tmp)], '#')

  tmp$BG_AB = paste(A, Target)
  tmp$BG_BC = paste(Target, C)

  DFbig2 = rbind(DFbig2, tmp)
}

## add counts
head(DFbig2)
tail(DFbig2)


AB.count = sort(table(DFbig2$BG_AB), decreasing = TRUE)
BC.count = sort(table(DFbig2$BG_BC), decreasing = TRUE)
head(AB.count)
head(BC.count)


length(AB.count)
# [1] 33965
length(BC.count)
# [1] 33915


DFbig2$AB.count = NA #create dummy column
DFbig2$BC.count = NA #create dummy column

## add AB.count
for(iword in 1:length(AB.count)){#iterate

  if(iword %% 1000 == 0){cat('Processed', iword, 'of', length(AB.count), 'items\n')}#print status
  
  count = AB.count[iword]#acces counts
  which.word = names(count)#take colname
  where = DFbig2$BG_AB == which.word#find rows in DFbig2
  DFbig2$AB.count[where] = count
}#end for loop


## add BC.count
for(iword in 1:length(BC.count)){#iterate

  if(iword %% 1000 == 0){cat('Processed', iword, 'of', length(BC.count), 'items\n')}#print status
  
  count = BC.count[iword]#acces counts
  which.word = names(count)#take colname
  where = DFbig2$BG_BC == which.word#find rows in DFbig2
  DFbig2$BC.count[where] = count
}#end for loop

DFbig2$AB.counts = NULL
DFbig2$BC.counts = NULL

save(DFbig2, file = 'DF_textgrids_addedinformation2.rda')

load('DF_textgrids_addedinformation2.rda')


###########################################################
## TO DO Calculate and add conditional probability 
##########################################################
#How is conditional probability calculated?
# P(A|B) = C(AB)/C(B)
# P(B|A) = C(AB)/C(A)
# 
# P(C|B) = C(BC)/C(B)
# P(B|C) = C(BC)/C(C)

## ADD counts for preceding and following words

DFbig3 = data.frame()

  for (ifn in FN){
    tmp = DFbig2[DFbig2$filename == ifn,]
    
    Target =  tmp$Count

    A= c(NA, Target[1:(nrow(tmp)-1)])
    C= c(Target[2:nrow(tmp)], NA)

    tmp$Count_A = A
    tmp$Count_C = C

    DFbig3 = rbind(DFbig3, tmp)
  }
  
DFbig3$Count_B = DFbig3$Count
  
DFbig3$cndP.A_B = DFbig3$AB.count / DFbig3$Count_A
DFbig3$cndP.B_A = DFbig3$AB.count / DFbig3$Count_B

DFbig3$cndP.B_C = DFbig3$BC.count / DFbig3$Count_C
DFbig3$cndP.C_B = DFbig3$BC.count / DFbig3$Count_B



DFbig[13:20, c('word', 'Count','BG_AB', 'AB.count')]

#What information is lacking and where can it be included?
#counts of A
#counts of B

#How should the code look like?


#############################################################
## Add word length
#############################################################
DFbig2$Length = nchar(DFbig2$word)
Wordlength = sort(table(DFbig3$Length ), decreasing = TRUE)

head(DFbig3[DFbig3$Length == 25,])

DFbig2 = DFbig2[DFbig2$Length != 0,]

#############################################################
## Gauge phonotactic probabilities for orthography (as a ersatz for phonetic)
#############################################################

install.packages('ndl')
library('ndl')

DFbig2$LetterBG = orthoCoding(DFbig2$word, grams=2)

LetterBG = strsplit(DFbig2$LetterBG, split = '_' )
LetterBG = unlist(LetterBG)

LetterBG.count = sort(table(LetterBG), decreasing = TRUE)


## calculate orthographic probability for each word.

LetterCount =data.frame(word = unique(DFbig3$word), stringsAsFactors=FALSE)
LetterCount$LetterBG = orthoCoding(LetterCount$word, grams=2)

for(iword in 1:nrow(LetterCount)){

  WBG = LetterCount$LetterBG[iword]
  WBG = unlist(strsplit(WBG, split = '_'))
  
  PhonoCount = LetterBG.count[WBG]
  
  LetterCount$LetterCount.sum[iword] = sum(PhonoCount)
  LetterCount$LetterCount.mean[iword] = mean(PhonoCount)
  LetterCount$LetterCount.sd[iword] = sd(PhonoCount)
}

#delete column
LetterCount$LetterBG= NULL

# new function
#?merge


DFbig4=merge(DFbig3,LetterCount, by = 'word') #by-value must match between dataframes

head(DFbig3)#anything weird?
# 
# BIS HIER
# ###########################################################
# ## EXCURSION:  Storing figures
# ###########################################################
# 
# # create plotting device on hard drive
# pdf('/home/fabian/Dropbox/Uni/Seminare/Seminar_2017_CorpusStudies/Fig/TestFig.pdf', width = 5, height = 5) #height/width in inches
# par(mfrow=c(1,2)) # number of plots in file
# plot(1:10, 1:10, main = 'testfigure 1', ylab='y values', xlab = 'x values')
# plot(1:10, 1:10, main = 'testfigure 2', ylab='y values', xlab = 'x values')
# dev.off()#turn off connection to plotting device
# 
# 
# 
# 
# ###########################################################
# ## Prepare variables for analysis
# ###########################################################
# #1 Distributions of values
# 
# # As predictors and dependent variable, we aspire to have normally distributed values. these should look in the following way:
# 
# #create dummy values
# Normdist = rnorm(1000, mean = 0, sd = 1)
# NotNormdist1= exp(Normdist)
# NotNormdist2= -1000/Normdist
#  
#  
# par(mfrow=c(2,3))
# plot(density(Normdist), main = 'normal distribution')
# plot(density(NotNormdist1), main = 'squewed distribution')
# plot(density(NotNormdist2), main = 'strongly squewed distribution')
# 
# 
# # solution: Tranformation!
# frame()
# plot(density(log(NotNormdist1)), main = 'log transformed data')
# plot(density( -1000/NotNormdist2), main = 'inverse transformed data')
# 
# 
# ###########################################################
# ## EXCURSION: Writing functions
# ###########################################################
# 
# # environment:
# 
# FunctionName <- function(INPUT){
# OUTPUT <- Do something to (INPUT)
# return(OUTPUT)
# }
# 
# 
# 
# 
# # Function for plotting distributions of raw and transformed values
# QQ = function (DF, T){
#   par(mfcol=c(1,3))
# 
#   Y = DF[,T]
#   plot(density(Y,na.rm=TRUE), xlab = T, main = 'raw')
# 
#   X = log(Y)
#   plot(density(X,na.rm=TRUE), xlab = T, main = 'log')
# 
#   X<- -1000/Y; 
#   plot(density(X,na.rm=TRUE), xlab = T, main = '-1000/Y')
# }
# 
# 
# 
# 
# # Why should the data be normally distributed??? ---> Read Baayen (2008): "Analyzing linguistic data"
# 
# 
# 
# 
# pdf('/home/fabian/Dropbox/Uni/Seminare/Seminar_2017_CorpusStudies/Fig/Distributions.pdf', width = 9, height = 3) #height/width in inches
# 
# QQ(DFbig3, 'wordduration')
# QQ(DFbig3, 'Count')
# QQ(DFbig3, 'AB.count')
# QQ(DFbig3, 'BC.count')
# QQ(DFbig3, 'Length')
# QQ(DFbig3, 'LetterCount.sum')
# QQ(DFbig3, 'LetterCount.mean')
# QQ(DFbig3, 'LetterCount.sd')
# 
# # QQ(DFbig3, 'CondPred')
# dev.off()#turn off connection to plotting device
# 
# 
# 
# 
# 
# 
# 
# 
# #3 Correlations
# cor(DFbig3[,c('Count', 'AB.count', 'BC.count', 'Length', 'LetterCount.sum','LetterCount.mean','LetterCount.sd')])
# 
# 
# 
# #check correlations between "predictors"
# 
# #what is a correlation?
# x = 1:10 
# y1 = x
# y2 = x^3
# par(mfrow = c(1,2))
# plot(x,y1)
# plot(x,y2)
# 
# cor(x,y1)
# cor(x,y2)
# 
# 
# # correlation in our data
# 
# 
# 
# 
# sum(is.na(DFbig3$BC.count))
# DFbig4 = DFbig3[!is.na(DFbig3$BC.count),]
# 
# 
# 
# cor(DFbig4[,c('wordduration', 'Count', 'AB.count', 'BC.count', 'Length', 'LetterCount.sum','LetterCount.mean','LetterCount.sd')])
# 
# 
# 
# 
# 
# 


############################################################
## TASK 
############################################################
#TASK 20#
#-------#
#Calculate the durations for the bigrams and include them into the dataframe "DFbig3". 


#TASK 21#
#-------#
#Create a column with trigrams ABC. Calculate the conditional probability of B given AC. Calculate the durations of the trigrams ABC.









