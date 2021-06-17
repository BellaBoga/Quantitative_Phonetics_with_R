############################################################
## TASK 
############################################################

DIR = '/home/bella/Dropbox/Master/1st Semester/Quantitative Phonetics with R/Material Corpus etc/KEC/' 

setwd(DIR)
load('DF_textgrids_addedinformation.rda', verbose = TRUE)
head(DFbig2)
DFbig = DFbig2

DFbig$BG_AB=NULL
DFbig$BG_BC=NULL
DFbig$AB.counts=NULL
DFbig$AB.count=NULL
DFbig$BC.counts=NULL
DFbig$BC.count=NULL
head(DFbig)

#TASK 20#
#-------#
#Calculate the durations for the bigrams and include them into the dataframe "DFbig3". 

DFtmp = data.frame()

for (ifn in FN){
  tmp = DFbig2[DFbig2$filename == ifn,]
  
  Target =  tmp$wordduration
  
  A= c(0, Target[1:(nrow(tmp)-1)])
  C= c(Target[2:nrow(tmp)], 0)
  
  tmp$BiDurAB = paste(A+tmp$wordduration)
  tmp$BiDurBC = paste(tmp$wordduration+C)
  
  DFtmp = rbind(DFbig3, tmp)
}
DFbig2 = DFtmp
save(DFbig2, file = 'tmp.rda')

#TASK 21#
#-------#
#Create a column with trigrams ABC. 
#Calculate the conditional probability of B given AC. 
#Calculate the durations of the trigrams ABC.

FN = unique(DFbig$filename)
DFtmp = data.frame() 
DFtmp$TG_ABC = NULL


for (ifn in FN){
  tmp = DFbig[DFbig$filename == ifn,]
  
  Target =  tmp$word
  
  A= c('#', Target[1:(nrow(tmp)-1)])
  C= c(Target[2:nrow(tmp)], '#')
  
  tmp$Trigram = paste(A, Target,C)
  
  
  DFtmp = rbind(DFbig2, tmp)
}

DFbig2 = DFtmp
save(DFbig2, file = 'tmp.rda')

#####Get BG_AC

DFtmp = data.frame()

for(ifn in FN)
{
  tmp = DFbig2[DFbig2$filename == ifn,]
  Target = tmp$word
  A = c('#', Target[1:(nrow(tmp)-1)])
  C = c(Target[2:nrow(tmp)],'#')
  tmp$BG_AC = paste(A,C)
  DFtmp = rbind(DFtmp,tmp)
}
save(DFbig2, file='tmp.rda')

##Get count of AC

DFtmp$AC.count = NA
AC.count = sort(table(DFtmp$BG_AC),decreasing = TRUE)

for(i in 1:length(AC.count))
{
  count = AC:count[i]
  which.word = names(count)
  where = DF.tmp$BG_AC == which.word
  DFtmp$AC.count[where] = count
}

DFtmp$ABC.count = NA
ABC.count = sort(table(DFtmp$TG_ABC),decreasing=TRUE)

for(i in 1:length(ABC.count))
{
  count = ABC.count[i]
  which.word = names(count)
  where = DFtmp$TG_ABC == which.word
  DFtmp$ABC.count[where] = count
}

DFbig2 = DFtmp
save(DFbig2, file = 'tmp.rda')

##Get prob of B given AC

DFtmp$cndP.B_AC = DFtmp$ABC.count/DFtmp$AC.count

DFbig2 = DFtmp

save(DFbig2, file = 'tmp.rda')

##Get ABC durations

DFtmp = data.frame()

for(ifn in FN)
{
  tmp = DFbig2[DFbig2$filename ==ifn,]
  A = c(0,tmp$wordduration[1:(nrow(tmp)-1)])
  C = c(tmp$wordduration[2:nrow(tmp)],0)
  ABC = (A+tmp$wordduration + C)
  tmp$TriDurABC = paste(ABC)
  DFtmp = rbind(DFtmp, tmp)
}

DFbig2 = DFtmp

save(DFbig2, file = 'DFbig2.rda')