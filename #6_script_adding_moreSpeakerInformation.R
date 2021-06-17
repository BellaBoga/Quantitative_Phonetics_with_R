

setwd(DIR)
load('DF_textgrids_addedinformation.rda')
head(DFbig)

## Problem 1: Deleting unnecessary characters 
unique(DFbig$Sex)
DFbig$Sex = gsub('"', "", DFbig$Sex)
unique(DFbig$Sex)




## Problem 2: Replacing information
unique(DFbig$Sex)
DFbig$Sex2 = ifelse(DFbig$Sex == 'weiblich', 'female', 'male')
head(DFbig, 2)


## Problem 3: Extracting information out of strings
class(DFbig$RecordingDateDDMMYYYY)
head(DFbig$RecordingDateDDMMYYYY)


## Solution 1: Splitting (the more tedious solution, btw). 
Ex1 = 'ThisXisXanXexample'
Res  = strsplit(Ex1, split ='X')
Res


Ex2 = c('ThisXisXexampleXone', 'ThisXisXexampleXtwo')
Res  = strsplit(Ex2, split ='X')
Res
class(Res)




########################################
### EXCURSION: LISTS ###################
########################################

L1 = list(1, 2, 3)
L1
length(L1)
names(L1)

L2 = list(a=c(1,2), b='b1', c=3)
L2
length(L2)
names(L2)

#accessing lists: double brackets!
L1[[1]]

## Continue Solution 1: Splitting (the more tedious solution, btw). 

RecInfo = strsplit(DFbig$RecordingDateDDMMYYYY, split = "")
head(RecInfo,2)
length(RecInfo)
nrow(DFbig)

## Test process
iline = 1 #dummy coding
RecInfo[[iline]]
length(RecInfo[[iline]])#gauge number of entries
RecDate = RecInfo[[iline]]
 RecDate[2:3] #DD
 RecDate[4:5] #MM
 RecDate[6:9] #YYYY
 
 # Problem 1: After splitting single entries
 # solution: collapsing

 RecDate = RecInfo[[iline]]
 paste(RecDate[2:3], collapse="") #DD
 paste(RecDate[4:5], collapse="") #MM
 paste(RecDate[6:9], collapse="") #YYYY
 
 
 # Problem 2: characters!
    ## Test process
    iline = 1 #dummy coding
    RecDate = RecInfo[[iline]]
    #do it for days
    DD= paste(RecDate[2:3], collapse="") #DD
    class(DD)
    DD = as.numeric(DD)#rewrite DD
    class(DD)

    #do it for the rest
    MM = as.numeric(paste(RecDate[4:5], collapse="")) #MM
    YY = as.numeric(paste(RecDate[6:9], collapse="")) #YYYY
    MM
    YY

  ## do it for the entire data frame
  
  
  #Prepare DFbig
DFbig$RecDD = NA
DFbig$RecMM = NA
DFbig$RecYY = NA

for(iline in 1:nrow(DFbig)){

    # a) get splitted date and create numbers
    RecDate = RecInfo[[iline]]
    DD= as.numeric(paste(RecDate[2:3], collapse=""))
    MM = as.numeric(paste(RecDate[4:5], collapse=""))
    YY = as.numeric(paste(RecDate[6:9], collapse=""))


    # b) attach values to DFbig
    DFbig$RecDD[iline] = DD
    DFbig$RecMM[iline] = MM
    DFbig$RecYY[iline] = YY

}#frame

## Final test
head(DFbig,2)




## Solution 1: Extracting and clipping (involves a package!)

########################################
### EXCURSION: Installing packages #####
########################################

install.packages('stringr')
#if the upper does not word, try it with the following:
install.packages('stringr', repos="http://mirrors.softliste.de/cran/")


# load packages
library('stringr')
library(stringr)#exactly the same thing!



#Test str_sub()
String = 'abcde'
str_sub(String, start = 2)#start 2 positions from left
str_sub(String, start = -2)#start 2 positions from right
str_sub(String, end = 2)#end 2 positions from left
str_sub(String, end = -2)#end 2 positions from righ


# test process using corpus data
library(stringr)
Test = DFbig$RecordingDateDDMMYYYY[1]
Test#there are still those stupid quotes
#Delete quotes
DFbig$RecordingDateDDMMYYYY = gsub('"', '', DFbig$RecordingDateDDMMYYYY)#
Test = DFbig$RecordingDateDDMMYYYY[1]
Test#Nice

str_sub(Test, start = 1, end = 2)#Great.
str_sub(Test, start = 3, end = 4)#Yeah!!
str_sub(Test, start = 5)#Strike!!!


# apply to entire vector
Days = str_sub(DFbig$RecordingDateDDMMYYYY , start = 1, end = 2)
Months = str_sub(DFbig$RecordingDateDDMMYYYY , start = 3, end = 4)
Years = str_sub(DFbig$RecordingDateDDMMYYYY , start = 5)
class(Days)

#change to numeric
Days = as.numeric(str_sub(DFbig$RecordingDateDDMMYYYY , start = 1, end = 2))
Months = as.numeric(str_sub(DFbig$RecordingDateDDMMYYYY , start = 3, end = 4))
Years = as.numeric(str_sub(DFbig$RecordingDateDDMMYYYY , start = 5))
class(Days)

# apply and store in dataframe
DFbig$RecDD = as.numeric(str_sub(DFbig$RecordingDateDDMMYYYY , start = 1, end = 2))
DFbig$RecMM = as.numeric(str_sub(DFbig$RecordingDateDDMMYYYY , start = 3, end = 4))
DFbig$RecYY = as.numeric(str_sub(DFbig$RecordingDateDDMMYYYY , start = 5))
head(DFbig,2)

## age of speakers

DFbig$Age = DFbig$RecYY - DFbig$Birthyear
unique(DFbig$Age)

#DO #NOT #FORGET #TO #SAVE
setwd(DIR)
save(DFbig, file = 'DF_textgrids_addedinformation.rda')



########################################
### TASK ###############################
########################################

#TASK 18#
#-------#



