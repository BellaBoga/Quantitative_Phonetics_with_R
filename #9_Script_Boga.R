
x = 1:1000
y2 = exp(x)

par(mfrow=c(1,2))
plot(x,y2)
plot(x,log(y2))


QQ = function (DF, T){
  par(mfcol=c(1,3))

  Y = DF[,T]
  plot(density(Y,na.rm=TRUE), xlab = T, main = 'raw')

  X = log(Y)
  plot(density(X,na.rm=TRUE), xlab = T, main = 'log')

  X<- -1000/Y; 
  plot(density(X,na.rm=TRUE), xlab = T, main = '-1000/Y')
}



##################################################################################################
## Prepare data for analysis
DIR = '/home/bella/Dropbox/Master/1st Semester/Quantitative Phonetics with R/Material Corpus etc/KEC'
setwd(DIR)
load('KEC_all.rda', verbose = TRUE)

## calculate age
TG7$Age = TG7$RecYY - TG7$Birthyear
TG7$Wordlength = nchar(TG7$Word)

## exclude pauses

isNoNan = complete.cases(TG7)

TG8 = TG7[!TG7$Word == '<P>' & isNoNan,]

## take randomply 5000 samples out of data
takerows = sample(nrow(TG8))[1:10000]
TGsub = TG8[takerows,]


take = c('Duration.BC', 'Duration.ABC', 'SizeInCm', 'WeightInKg', 'Age', 'Count.B', 'Count.AB','Count.BC','Count.A','Count.B', 'Count.C','Count.ABC', 'cndP.A_B', 'cndP.B_A', 'cndP.B_C', 'cndP.C_B', 'SpeakingRate', 'LetterCount.sum', 'LetterCount.mean', 'LetterCount.sd', 'Wordlength' )



take[!take %in% colnames(TGsub)]

str(TGsub[,take])

pdf('/home/bella/Dropbox/Master/1st Semester/Quantitative Phonetics with R/Material Corpus etc/KEC/Distributions2.pdf', width = 9, height = 3) #height/width in inches

for (itake in take){
  QQ(TGsub, itake)
}
dev.off()

TGsub$L.Duration.BC = log(TGsub$Duration.BC)
TGsub$L.Duration.ABC = log(TGsub$Duration.ABC)


TGsub$L.Weight = -1000/TGsub$WeightInKg

TGsub$L.Count.A = log(TGsub$Count.A)
TGsub$L.Count.B = log(TGsub$Count.B)
TGsub$L.Count.C = log(TGsub$Count.C)

TGsub$L.Count.AB = log(TGsub$Count.AB)
TGsub$L.Count.BC = log(TGsub$Count.BC)
TGsub$L.Count.ABC = log(TGsub$Count.ABC)


TGsub$L.cndP.A_B = log(TGsub$cndP.A_B)
TGsub$L.cndP.B_A = log(TGsub$cndP.B_A)
TGsub$L.cndP.B_C = log(TGsub$cndP.B_C)
TGsub$L.cndP.C_B = log(TGsub$cndP.C_B)
TGsub$L.SpeakingRate = log(TGsub$SpeakingRate)
TGsub$L.Wordlength = log(TGsub$Wordlength)



take2 = c('L.Duration.BC','L.Duration.ABC', 'L.Count.ABC', 'SizeInCm', 'L.Weight', 'Age','L.Count.A', 'L.Count.B', 'L.Count.C', 'L.Count.AB','L.Count.BC','L.Count.B', 'L.cndP.A_B', 'L.cndP.B_A', 'L.cndP.B_C', 'L.cndP.C_B', 'L.SpeakingRate', 'LetterCount.sum', 'LetterCount.mean', 'LetterCount.sd', 'L.Wordlength' )


take2[!take2 %in% colnames(TGsub)]

cor(TGsub[,take2]) 
summary(TGsub[,take2]) 

log(0) 

TGsub$L.SpeakingRate = log(TGsub$SpeakingRate+0.1)

summary(TGsub[,take2]) 


RR0 = round(cor(TGsub[,take2], method = 'sp'),2)
RR0

library(party)
library(lattice, verbose = FALSE)


take3 = c('L.Count.ABC', 'SizeInCm', 'L.Weight', 'Age','L.Count.A', 'L.Count.B', 'L.Count.C', 'L.Count.AB','L.Count.BC','L.Count.B', 'L.cndP.A_B', 'L.cndP.B_A', 'L.cndP.B_C', 'L.cndP.C_B', 'L.SpeakingRate', 'LetterCount.sum', 'LetterCount.mean', 'LetterCount.sd', 'L.Wordlength' )

Formula.BC = as.formula(paste('L.Duration.BC ~', paste(take3, collapse = '+')))
Formula.ABC = as.formula(paste('L.Duration.ABC ~', paste(take3, collapse = '+')))


data.controls <- cforest_unbiased( ntree = 200, mtry = 3)

forest_raw <- cforest(Formula.BC, TGsub,controls = data.controls)
raw_varimp.BC <- varimp(forest_raw, conditional = FALSE)	

forest_raw <- cforest(Formula.ABC, TGsub,controls = data.controls)
raw_varimp.ABC <- varimp(forest_raw, conditional = FALSE)	



pdf('/home/bella/Dropbox/Master/1st Semester/Quantitive Phonetics with R/Varimp.pdf', width = 6, height = 6) 
par(mfrow=c(1,2))
dotplot( sort(log(raw_varimp.BC)), xlab = 'Importance', ylab = 'Predictor', main = 'Duration.BC')
dotplot( sort(log(raw_varimp.ABC)), xlab = 'Importance', ylab = 'Predictor', main = 'Duration.BC')
dev.off()

RR <-RR1 <- round(cor(TGsub[,take3], method = 'sp'),2)
RR[abs(RR1)<0.6] = 0
RR[abs(RR1)>=0.6] = 1


Collin = sort(rowSums(RR))

names(Collin)[Collin>1]

collinPreds = c( "L.Count.A" ,"L.Count.C","L.cndP.C_B","LetterCount.mean","LetterCount.sd","L.Count.ABC", "LetterCount.sum" , "L.Count.B"  , "L.Count.BC"  , "L.Count.B.1"  ,  "L.Count.AB" )      
RR[collinPreds,collinPreds]

sort(raw_varimp.BC[c('L.Count.C','L.cndP.C_B')], decreasing = TRUE) 
sort(raw_varimp.ABC[c('L.Count.C','L.cndP.C_B')], decreasing = TRUE) 

collinPreds = c( "L.Count.A" ,"LetterCount.mean","LetterCount.sd","L.Count.ABC",   "LetterCount.sum" , "L.Count.B"  , "L.Count.BC"  , "L.Count.B.1"  ,  "L.Count.AB" )      
RR[collinPreds,collinPreds]

sort(raw_varimp.BC[c('LetterCount.mean','LetterCount.sd', 'LetterCount.sum')], decreasing = TRUE) 
sort(raw_varimp.ABC[c('LetterCount.mean','LetterCount.sd', 'LetterCount.sum')], decreasing = TRUE)

collinPreds = c( "L.Count.A" ,"L.Count.ABC",   "L.Count.B"  , "L.Count.BC"  , "L.Count.B.1"  ,  "L.Count.AB" )      
RR[collinPreds,collinPreds]

sort(raw_varimp.BC[collinPreds], decreasing = TRUE) 
sort(raw_varimp.ABC[collinPreds], decreasing = TRUE)





sort(raw_varimp[collinPreds[1:3]], decreasing = TRUE)

sort(RR0['L.Duration.B', collinPreds[1:3]], decreasing = TRUE)


sort(raw_varimp[collinPreds[4:6]], decreasing = TRUE)

sort(RR0['L.Duration.B', collinPreds[4:6]], decreasing = TRUE)

FinalPredictorsBC = c( 'SizeInCm', 'L.Weight', 'Age','L.Count.A',  'L.Count.C', 'L.Count.BC','L.cndP.A_B', 'L.cndP.B_A', 'L.cndP.B_C',  'L.SpeakingRate',  'LetterCount.mean', 'LetterCount.sd', 'L.Wordlength' )

FinalPredictorsABC = c( 'SizeInCm', 'L.Weight', 'Age','L.Count.A',  'L.Count.C', 'L.Count.AB','L.Count.BC', 'L.cndP.A_B', 'L.cndP.B_A', 'L.cndP.B_C',  'L.SpeakingRate', 'LetterCount.mean', 'LetterCount.sd', 'L.Wordlength' )

FinalPredictorsBC%in%FinalPredictorsABC
FinalPredictorsABC[!FinalPredictorsABC%in%FinalPredictorsBC]



library(lme4)
mod.BC = lmer(L.Duration.BC~
SizeInCm
+L.Weight
+Age
+L.Count.A
+L.Count.C
+L.Count.BC
+L.cndP.A_B
+L.cndP.B_A
+L.cndP.B_C
+L.SpeakingRate
+LetterCount.mean
+LetterCount.sd
+L.Wordlength
+(1|filename)
+(1|Word) 
,data = TGsub)

summary(mod.BC)


mod.ABC = lmer(L.Duration.ABC~
SizeInCm

+Age
+L.Count.A
+L.Count.C
+L.Count.BC
+L.Count.AB
+L.cndP.A_B
+L.cndP.B_A
+L.cndP.B_C
+L.SpeakingRate
+LetterCount.mean
+LetterCount.sd
+L.Wordlength
+(1|filename)
+(1|Word) 
,data = TGsub)


summary(mod.ABC)



