## What does log do?





x = 1:1000
y2 = exp(x)

par(mfrow=c(1,2))
plot(x,y2)
plot(x,log(y2))


###########################


# Function for plotting distributions of raw and transformed values
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
DIR = '/home/fabian/Working_Data/'
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



################################################################################################
## CHECK NORMAL DISTRIBUTION OF ALL NUMERIC DATA
take = c('Duration.BC', 'Duration.ABC', 'SizeInCm', 'WeightInKg', 'Age', 'Count.B', 'Count.AB','Count.BC','Count.A','Count.B', 'Count.C','Count.ABC', 'cndP.A_B', 'cndP.B_A', 'cndP.B_C', 'cndP.C_B', 'SpeakingRate', 'LetterCount.sum', 'LetterCount.mean', 'LetterCount.sd', 'Wordlength' )


#check correct spelling of colnames
take[!take %in% colnames(TGsub)]

#check whether everything is numeric!
str(TGsub[,take])

pdf('/home/fabian/Dropbox/Uni/Seminare/Seminar_2017_CorpusStudies/Fig/Distributions2.pdf', width = 9, height = 3) #height/width in inches

for (itake in take){
  QQ(TGsub, itake)
}
dev.off()#turn off connection to plotting device


## transform values

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

#what do we do with Count.ABC


################################################################################################
## CHECK FOR COLLINEARITY BTW. POSSIBLE PREDICTORS
#Collinearity = correlations  between predictors

take2 = c('L.Duration.BC','L.Duration.ABC', 'L.Count.ABC', 'SizeInCm', 'L.Weight', 'Age','L.Count.A', 'L.Count.B', 'L.Count.C', 'L.Count.AB','L.Count.BC','L.Count.B', 'L.cndP.A_B', 'L.cndP.B_A', 'L.cndP.B_C', 'L.cndP.C_B', 'L.SpeakingRate', 'LetterCount.sum', 'LetterCount.mean', 'LetterCount.sd', 'L.Wordlength' )

#check whether the selected variables are in the DF
take2[!take2 %in% colnames(TGsub)]

cor(TGsub[,take2]) #Problem: NaN in L.SpeakingRate

summary(TGsub[,take2]) 
# L.SpeakingRate --> -Inf
#problem: 
log(0) #= -Inf

#Question: Why are there 0 syllables / second in that dataframe?

TGsub$L.SpeakingRate = log(TGsub$SpeakingRate+0.1)

summary(TGsub[,take2]) #OK


RR0 = round(cor(TGsub[,take2], method = 'sp'),2)#spearman correlation
RR0
##Spearman's Rank correlation coefficient is used to identify and test the strength of a
##relationship between two sets of data. It is often used as a statistical method to aid with
##either proving or disproving a hypothesis e.g. the depth of a river does not progressively 
##increase the further from the river bank.


##################################################################################################
## CHECK VARIABLE IMPORTANCE FOR PREDICTION OF WORD DURATION
#install.packages('party')
library(party)#for cforest
library(lattice, verbose = FALSE)#for dotplot


take3 = c('L.Count.ABC', 'SizeInCm', 'L.Weight', 'Age','L.Count.A', 'L.Count.B', 'L.Count.C', 'L.Count.AB','L.Count.BC','L.Count.B', 'L.cndP.A_B', 'L.cndP.B_A', 'L.cndP.B_C', 'L.cndP.C_B', 'L.SpeakingRate', 'LetterCount.sum', 'LetterCount.mean', 'LetterCount.sd', 'L.Wordlength' )

## create formula 
Formula.BC = as.formula(paste('L.Duration.BC ~', paste(take3, collapse = '+')))
Formula.ABC = as.formula(paste('L.Duration.ABC ~', paste(take3, collapse = '+')))

## run random forest analysis
# preferences for random forest analysis
data.controls <- cforest_unbiased( ntree = 200, mtry = 3)

#run random forest analysis
forest_raw <- cforest(Formula.BC, TGsub,controls = data.controls)
raw_varimp.BC <- varimp(forest_raw, conditional = FALSE)	

forest_raw <- cforest(Formula.ABC, TGsub,controls = data.controls)
raw_varimp.ABC <- varimp(forest_raw, conditional = FALSE)	



#plot variable importance


pdf('/home/fabian/Dropbox/Uni/Seminare/Seminar_2017_CorpusStudies/Fig/Varimp.pdf', width = 6, height = 6) 
par(mfrow=c(1,2))
dotplot( sort(log(raw_varimp.BC)), xlab = 'Importance', ylab = 'Predictor', main = 'Duration.BC')
dotplot( sort(log(raw_varimp.ABC)), xlab = 'Importance', ylab = 'Predictor', main = 'Duration.BC')
dev.off()

#We expect a very strong effect for L.Wordlength, a very weak effect for L.Weight

#Next, we need to chose the best predictor from those wich correlate in RR
# We code all correlations > 0.6 as TRUE, otherwise as FALSE
RR <-RR1 <- round(cor(TGsub[,take3], method = 'sp'),2)
RR[abs(RR1)<0.6] = 0
RR[abs(RR1)>=0.6] = 1

# inspect whether there are high correlations btw. predictors. numbers >1 indicate collinearity
Collin = sort(rowSums(RR))



#which variables do correlate?
## CHECK 1
names(Collin)[Collin>1]

collinPreds = c( "L.Count.A" ,"L.Count.C","L.cndP.C_B","LetterCount.mean","LetterCount.sd","L.Count.ABC",      "LetterCount.sum" , "L.Count.B"  , "L.Count.BC"  , "L.Count.B.1"  ,  "L.Count.AB" )      
RR[collinPreds,collinPreds]

#check which of the correlating predictors has the highest variable importance
sort(raw_varimp.BC[c('L.Count.C','L.cndP.C_B')], decreasing = TRUE) #L.cndP.C_B = loser
sort(raw_varimp.ABC[c('L.Count.C','L.cndP.C_B')], decreasing = TRUE) #L.cndP.C_B = loser

## CHECK 2
collinPreds = c( "L.Count.A" ,"LetterCount.mean","LetterCount.sd","L.Count.ABC",   "LetterCount.sum" , "L.Count.B"  , "L.Count.BC"  , "L.Count.B.1"  ,  "L.Count.AB" )      
RR[collinPreds,collinPreds]

#check which of the correlating predictors has the highest variable importance
sort(raw_varimp.BC[c('LetterCount.mean','LetterCount.sd', 'LetterCount.sum')], decreasing = TRUE) #LetterCount.sum = loser
sort(raw_varimp.ABC[c('LetterCount.mean','LetterCount.sd', 'LetterCount.sum')], decreasing = TRUE) #LetterCount.sum = loser


## CHECK 3
collinPreds = c( "L.Count.A" ,"L.Count.ABC",   "L.Count.B"  , "L.Count.BC"  , "L.Count.B.1"  ,  "L.Count.AB" )      
RR[collinPreds,collinPreds]

sort(raw_varimp.BC[collinPreds], decreasing = TRUE) #L.Count.B,L.Count.ABC  L.Count.AB  = loser
sort(raw_varimp.ABC[collinPreds], decreasing = TRUE) #L.Count.ABC, L.Count.AB, L.Count.B = loser




#--> take predictor with the highest variable importance (and highest correlation with L.Duration.B; exclude the other ones

sort(raw_varimp[collinPreds[1:3]], decreasing = TRUE)

sort(RR0['L.Duration.B', collinPreds[1:3]], decreasing = TRUE)

sort(raw_varimp[collinPreds[4:6]], decreasing = TRUE)

sort(RR0['L.Duration.B', collinPreds[4:6]], decreasing = TRUE)

## Final predictors: 


#L.Count.B,L.Count.ABC  L.Count.AB  = loser
FinalPredictorsBC = c( 'SizeInCm', 'L.Weight', 'Age','L.Count.A',  'L.Count.C', 'L.Count.BC','L.cndP.A_B', 'L.cndP.B_A', 'L.cndP.B_C',  'L.SpeakingRate',  'LetterCount.mean', 'LetterCount.sd', 'L.Wordlength' )

FinalPredictorsABC = c( 'SizeInCm', 'L.Weight', 'Age','L.Count.A',  'L.Count.C', 'L.Count.AB','L.Count.BC', 'L.cndP.A_B', 'L.cndP.B_A', 'L.cndP.B_C',  'L.SpeakingRate', 'LetterCount.mean', 'LetterCount.sd', 'L.Wordlength' )

FinalPredictorsBC%in%FinalPredictorsABC
FinalPredictorsABC[!FinalPredictorsABC%in%FinalPredictorsBC]


#####################
# linear mixed model


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
+(1|filename)#random effect for speakers
+(1|Word) # random effect for items
,data = TGsub)

summary(mod.BC)


mod.ABC = lmer(L.Duration.ABC~
SizeInCm
#+L.Weight
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
+(1|filename)#random effect for speakers
+(1|Word) # random effect for items
,data = TGsub)


summary(mod.ABC)


############################################################
## TASK 
############################################################
#TASK 21#
#-------#
# Prepare an analysis for a sample size of 10 000 samples for  Duration.BC and Duration.ABC as dependent variables. Inspect the distribution of the predictors and transform if necessary. Check the variable importance for predicting Duration.BC and Duration.ABC. Plot variable importance for both analyses. Check for collinearity Chose the final set of predictors! Run a linear mixed effects model. 





