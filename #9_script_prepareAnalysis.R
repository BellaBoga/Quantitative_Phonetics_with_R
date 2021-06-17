


###########################################################
## EXCURSION:  Storing figures
###########################################################

# create plotting device on hard drive
pdf('/home/fabian/Dropbox/Uni/Seminare/Seminar_2017_CorpusStudies/Fig/TestFig.pdf', width = 5, height = 5) #height/width in inches

png('/home/fabian/Dropbox/Uni/Seminare/Seminar_2017_CorpusStudies/Fig/TestFig.png', units = 'in', res =500, width = 5, height = 5) #height/width in inches

par(mfrow=c(1,2)) # number of plots in file
plot(1:10, 1:10, main = 'testfigure 1', ylab='y values', xlab = 'x values')
plot(1:10, 1:10, main = 'testfigure 2', ylab='y values', xlab = 'x values')
dev.off()#turn off connection to plotting device




###########################################################
## Prepare variables for analysis
###########################################################
#1 Distributions of values

# As predictors and dependent variable, we aspire to have normally distributed values. these should look in the following way:

#create dummy values
DF = data.frame(Normdist = rnorm(1000, mean = 10, sd = 1))
DF$NotNormdist1= exp(DF$Normdist)
DF$NotNormdist2= -1000/DF$Normdist
 
 
with(DF, {
    par(mfrow=c(2,3))
    plot(density(Normdist), main = 'normal distribution')
    plot(density(NotNormdist1), main = 'squewed distribution')
    plot(density(NotNormdist2), main = 'strongly squewed distribution')

    # solution: Tranformation!
    frame()#empty figure
    plot(density(log(NotNormdist1)), main = 'log transformed data')
    plot(density( -1000/NotNormdist2), main = 'inverse transformed data')
})






###########################################################
## EXCURSION: Writing functions
###########################################################

# environment:
# 
FunctionName = function(INPUT){



OUTPUT <- Do something to (INPUT)
return(OUTPUT)



}



MyAddFunction <- function(a,b){
c = a+b
return(c)
}


















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







QQ(DF, 'NotNormdist1')


# Why should the data be normally distributed??? ---> Read Baayen (2008): "Analyzing linguistic data"
# --> Explanation on board



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
takerows = sample(nrow(TG8))[1:5000]
TGsub = TG8[takerows,]


################################################################################################
## CHECK NORMAL DISTRIBUTION OF ALL NUMERIC DATA
take = c('Duration.B', 'SizeInCm', 'WeightInKg', 'Age', 'Count.AB','Count.BC','Count.B', 'Count.ABC', 'cndP.A_B', 'cndP.B_A', 'cndP.B_C', 'cndP.C_B', 'SpeakingRate', 'LetterCount.sum', 'LetterCount.mean', 'LetterCount.sd', 'Wordlength' )


#check correct spelling of colnames
take[!take %in% colnames(TGsub)]

#check whether everything is numeric!
str(TGsub[,take])

pdf('/home/fabian/Dropbox/Uni/Seminare/Seminar_2017_CorpusStudies/Fig/Distributions.pdf', width = 9, height = 3) #height/width in inches

for (itake in take){
  QQ(TGsub, itake)
}
dev.off()#turn off connection to plotting device


## transform values
TGsub$L.Duration.B = log(TGsub$Duration.B)
TGsub$L.Weight = log(TGsub$WeightInKg)

TGsub$L.Count.B = log(TGsub$Count.B)

TGsub$L.Count.AB = log(TGsub$Count.AB)
TGsub$L.Count.BC = log(TGsub$Count.BC)
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


x = 1:10
y = x

plot(x,y)
cor(x,y)

plot(x,-y)
cor(x,-y)




#what is a correlation?
x = 1:10 
y1 = x
y2 = x^3
par(mfrow = c(1,2))
plot(x,y1)
plot(x,y2)

cor(x,y1)
cor(x,y2)


par(mfrow=c(1,3))
plot(DF$NotNormdist1, DF$Normdist)
plot(DF$NotNormdist1, DF$NotNormdist2, col = 'red', pch = 4)#
plot(DF$Normdist, DF$NotNormdist2, col = 'blue', pch = 7)#


cor(DF$NotNormdist1, DF$Normdist)
cor(DF$NotNormdist2, DF$Normdist)
cor(DF$NotNormdist2, DF$NotNormdist1)
cor(DF)

### correlation plots
par(mfrow=c(1,3))
plot(DF$NotNormdist1, DF$Normdist, main = cor(DF$NotNormdist1, DF$Normdist))
abline(lm(Normdist~NotNormdist1, data = DF))

plot(DF$NotNormdist1, DF$NotNormdist2, col = 'red', pch = 4, main = cor(DF$NotNormdist1, DF$NotNormdist2))#
abline(lm(NotNormdist2~NotNormdist1, data = DF))


plot(DF$Normdist, DF$NotNormdist2, col = 'blue', pch = 7, main = cor(DF$Normdist, DF$NotNormdist2))#
abline(lm(NotNormdist2~Normdist, data = DF))


# correlations range between -1 = perfect negative correlation, and +1 = perfect positive correlation. The higher the correlation between x and y, the better x predicts y. IMPORTANT: correlations do not imply causality!
#--> google: Spurious Correlations


take2 = c('L.Duration.B', 'SizeInCm', 'L.Weight', 'Age', 'L.Count.AB','L.Count.BC','L.Count.B', 'L.cndP.A_B', 'L.cndP.B_A', 'L.cndP.B_C', 'L.cndP.C_B', 'L.SpeakingRate', 'LetterCount.sum', 'LetterCount.mean', 'LetterCount.sd', 'L.Wordlength' )

cor(TGsub[,take2]) #Problem: NaN in L.SpeakingRate

summary(TGsub[,take2]) 
# L.SpeakingRate --> -Inf
#problem: 
log(0) #= -Inf

#Question: Why are there 0 syllables / second in that dataframe?

TGsub$L.SpeakingRate = log(TGsub$SpeakingRate+0.1)

summary(TGsub[,take2]) #OK


cor(TGsub[,take2])

# too large to investigate


RR0 = round(cor(TGsub[,take2], method = 'sp'),2) #spearman correlation
RR0



##################################################################################################
## CHECK VARIABLE IMPORTANCE FOR PREDICTION OF WORD DURATION
#install.packages('party')
library(party)#for cforest
library(lattice, verbose = FALSE)#for dotplot


take3 = c('SizeInCm', 'L.Weight', 'Age', 'L.Count.AB','L.Count.BC','L.Count.B', 'L.cndP.A_B', 'L.cndP.B_A', 'L.cndP.B_C', 'L.cndP.C_B', 'L.SpeakingRate', 'LetterCount.sum', 'LetterCount.mean', 'LetterCount.sd', 'L.Wordlength' )

## create formula 
Formula = as.formula(paste('L.Duration.B ~', paste(take3, collapse = '+')))
Formula


##plot a decision tree
tree_raw = ctree(Formula, data = TGsub)
pdf('/home/fabian/Dropbox/Uni/Seminare/Seminar_2017_CorpusStudies/Fig/ctree.pdf', width = 80, height =15)
plot(tree_raw)
dev.off()


## run random forest analysis
# preferences for random forest analysis
data.controls <- cforest_unbiased( ntree = 500, mtry = ceiling(sqrt(length(take3)))	)

#run random forest analysis
forest_raw <- cforest(Formula, TGsub,controls = data.controls)
raw_varimp <- varimp(forest_raw, conditional = FALSE)	

#plot variable importance
VARIMP <- sort(raw_varimp, decreasing = TRUE)
names(VARIMP) = paste0(1:length(VARIMP), ': ', names(VARIMP))
#VARIMP = sort(log(VARIMP))

VARIMP = sort(VARIMP)
dotplot(VARIMP, xlab = 'Importance', ylab = 'Predictor')


#We expect a very strong effect for L.Wordlength, a very weak effect for L.Weight

#Next, we need to chose the best predictor from those wich correlate in RR
# We code all correlations > 0.6 as TRUE, otherwise as FALSE
RR <-RR1 <- round(cor(TGsub[,take3], method = 'sp'),2)
RR[abs(RR)<0.6] = 0
RR[abs(RR)>=0.6] = 1

# inspect whether there are high correlations btw. predictors. numbers >1 indicate collinearity
sort(rowSums(RR))
#which variables do correlate?

collinPreds =c('L.Count.AB','L.Count.BC','L.Count.B','LetterCount.mean','LetterCount.sd','LetterCount.sum')
      
 
RR[collinPreds,collinPreds]






#--> take predictor with the highest variable importance (and highest correlation with L.Duration.B; exclude the other ones

sort(raw_varimp[collinPreds[1:3]], decreasing = TRUE)

sort(RR0['L.Duration.B', collinPreds[1:3]], decreasing = TRUE)


sort(raw_varimp[collinPreds[4:6]], decreasing = TRUE)

sort(RR0['L.Duration.B', collinPreds[4:6]], decreasing = TRUE)

## Final predictors: 


FinalPredictors = c('SizeInCm', 'L.Weight', 'Age', 'L.Count.B', 'L.cndP.A_B', 'L.cndP.B_A', 'L.cndP.B_C', 'L.cndP.C_B', 'L.SpeakingRate', 'LetterCount.mean','L.Wordlength' )



#####################
## linear mixed model


#lmer(dependentVariable~IndependentVariable/Predictors)

library(lme4)
mod = lmer(L.Duration.B~
SizeInCm
+L.Weight
+Age
+L.Count.B
+L.cndP.A_B
+L.cndP.B_A
+L.cndP.B_C
+L.cndP.C_B
+L.SpeakingRate
+LetterCount.mean
+L.Wordlength
+(1|filename)#random effect for speakers
+(1|Word) # random effect for items
,data = TGsub)

summary(mod)


############################################################
## TASK 
############################################################
#TASK 21#
#-------#
# Prepare an analysis for a sample size of 10 000 samples for  Duration.BC and Duration.ABC as dependent variables. Inspect the distribution of the predictors and transform if necessary. Check the variable importance for predicting Duration.BC and Duration.ABC. Plot variable importance for both analyses. Check for collinearity Chose the final set of predictors! Run a linear mixed effects model. 





