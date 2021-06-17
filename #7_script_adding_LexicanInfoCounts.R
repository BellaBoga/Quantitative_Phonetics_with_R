## Load
DIR = '/home/bella/Dropbox/Master/1st Semester/Quantitative Phonetics with R/Material Corpus etc/KEC/' 

setwd(DIR)
load('DFbig.rda')
head(DFbig)



## table() and word counts
table(rep(letters[1:10],1:10))

W.counts = sort(table(DFbig$word), decreasing = TRUE)
head(W.counts)

## add word frequencies to dataframe: test

iword = 1 #index dummy
count = w.counts[iword]#acces
count#show

which.word = colnames(count)#take colname
which.word#show

#### well--> does not work!
iword = 1 #index dummy


### TASK: write a for-loop for the process!

for(iword in 1:length(W.counts)){#iterate

  count = W.counts[iword]#acces
  which.word = names(count)#take colname
  where = DFbig$word == which.word#find rows
  DFbig$Count[where] = count

}#end for loop






## add word frequencies to dataframes: loop


DFbig$W.counts = NA #create dummy column

for(iword in 1:length(W.counts)){#iterate
  count = W.counts[iword]#acces counts
  which.word = names(count)#take colname
  where = DFbig$word == which.word#find rows in DFbig
  DFbig$W.counts[where] = count
}#end for loop


## TASK: CHECK THE FOLLOWING CODE

### some fine tuning: please show me where you are every 1000 steps!
## how would you do it manually





#1 modulo
3 %% 2 #test 1
33 %% 2 #test 2
33 %% 1000 
1000 %% 1000
2000 %% 1000
1000 %% 1000 == 0

#2 if()
V1 = 1:5
V1 == 1
if(V1[1] == 1){print('Done')}
if(V1[2] == 1){print('Done')}



DFbig$W.counts = NA #create dummy column

for(iword in 1:length(W.counts)){#iterate

  if(iword %% 1000 == 0){cat('Processed', iword, 'of', length(W.counts), 'items\n')}#print status
  count = W.counts[iword]#acces counts
  which.word = names(count)#take colname
  where = DFbig$word == which.word#find rows in DFbig
  DFbig$W.counts[where] = count
}#end for loop

head(DFbig)



#### plot distribution
x11() #possibly necessary on macs and linux. opens plotting window
par(mfrow=c(2,2)) #c(number of rows, number of colums), mfrow = fill row wise (mfcol = fill column wise)

# plot distribution of values along the continuum
plot(density(DFbig$W.counts))
plot(density(DFbig$W.counts[!DFbig$word == '<P>']))

plot(density(DFbig$wordduration))
plot(density(DFbig$wordduration[DFbig$word != '<P>']))

DFbig2 = DFbig[DFbig$word != '<P>',]#exlcude pauses

plot(DFbig2$W.counts, DFbig2$wordduration, main = 'Raw values', xlab = 'Counts', ylab = 'Word durations')

####
par(mfrow=c(2,2)) 
plot(density(DFbig2$W.counts), main='raw counts')
plot(density(log(DFbig2$W.counts)), main = 'log counts')

plot(density(DFbig2$wordduration), main = 'raw durations')
plot(density(log(DFbig2$wordduration)), main = 'log counts')

## log values
DFbig2$L.counts = log(DFbig2$W.counts)
DFbig2$L.wordduration = log(DFbig2$wordduration)

# plot anew
par(mfrow=c(1,2))

plot(DFbig2$W.counts, DFbig2$wordduration, main = 'Raw values', xlab = 'Counts', ylab = 'Word durations')

plot(DFbig2$L.counts, DFbig2$L.wordduration, main = 'Log values', xlab = 'Counts', ylab = 'Word durations')

# finally, a VERY simple satistical model

mod = lm(L.wordduration ~ L.counts, data = DFbig2)
#Y ~ X, read: Y as a function of X. or f(X) = X. (remember analysis?)
summary(mod)
# Estimate = effect size.
# std. error: how large is the uncertainty for that value
# t value = Estimate/std. error. has to be larger than abs(2) in order to be significant
# pr(>|t|) = p-values. have to be smaller than 0.05 in order to be significant

plot(DFbig2$L.counts, DFbig2$L.wordduration, main = 'Log values', xlab = 'Counts', ylab = 'Word durations')
abline(mod, col = 'red')

#####################################
## TASK till january 11th
#####################################

#TASK 19#
#-------#
#1) Please add a bigram column to "DFbig". In a sequence of ABC (I love R) take into account bigrams with the pattern AB (I love) and bigrams with the pattern BC (love R) for the target word B, i.e. love.

#2) Please add bigram counts to "DFbig" for both patterns, AB and BC. 

# facultative 3): If you feel very bored during the vacations and have nothing to do, you could calculate the durations for the bigrams and include them into the dataframe "DFbig". 

### MERRY CHRISTMAS!
