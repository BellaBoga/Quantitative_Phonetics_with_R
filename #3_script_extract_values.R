############################################################
## Presentation: Seminar_QP_Praxis_#03_designing_specific_task
############################################################


## Preparation of the programming tast

head(data, 25) # check dataframe structure


############################################################
## EXCURSION: Searching
############################################################

#------------------------#
#The == operator
#------------------------#

DF = c('m', 'm', 'f', 'f', 'f')
DF$gender == 'm'
DF


#usage in a dataframe
DF = data.frame(gender = rep(c('m','f'),10), size = sample(20)) #create a new dataframe with random number between 1 and 20.
head(DF) #check how the dataframe looks like
DF$gender == 'm' #find all men
DF$gender == 'f' #find all women

DF[DF$gender == 'f',] #use the logical vector to take a subset of the dataframe (in the y-dimension)

where = DF$gender == 'm'
DF[where,]

#does not work, as the vector is applied to the wrong dimension
DF[,where]

#you can also look for a specific number
DF[DF$size == 18,]

#or for numbers larger/smaller than another number
head(DF[DF$size > 18,]) #larger
head(DF[DF$size < 18,]) #larger




#------------------------#
#The %in% operator
#------------------------#

strings = c('aa','ab','bb','ac','aac')
DF = data.frame(factor = rep(strings,10), size = sample(length(strings)*10))
head(DF) #check how the dataframe looks like
DF$factor %in% c('aa', 'ab')
DF[DF$factor %in% c('aa', 'ab'),]

#------------------------#
#The which() function
#------------------------#

which(DF$factor %in% c('aa', 'ab'))


#------------------------#
#The grepl() function
#------------------------#
Strings = c('abc', 'abd', 'cdd', 'adz', 'xyz')
#find strings matching two inputs
where = grep('a|x', Strings)
Strings[ where ]

#find strings starting with a
where = grep('^a', Strings)
Strings[ where ]

#find strings ending with d
where = grep('d$', Strings)
Strings[ where ]

#show found values
grep('d$', Strings, value = TRUE)

#------------------------#
#Inversing searching results
#------------------------#

Vector = c(1,2,3,4,5,6,7,8,9)
#Boolean vectors
where = Vector == 2
Vector[where]
Vector[!where] #negate

#numeric vectors
where = grep(2, Vector)
Vector[where]
Vector[-where] #negate


########################################
### TASK ###############################
########################################

T1 = c('Gebersdorf', 'ist', 'ein', 'eher', 'langweiliger', 'Vorort', 'von', 'Nürnberg,', 'keine', 'Villen,', 'sondern', 'solide', 'Häuser,', 'enge', 'Straßen,', 'hohe', 'Hecken.', 'Am', '7.', 'Februar', '2015', 'wurde', 'dort', 'in', 'eines', 'der', 'Einfamilienhäuser', 'eingebrochen.', 'Einer', 'von', 'ungefähr', '650', 'Einbrüchen', 'im', 'Jahr,', 'allein', 'in', 'Nürnberg.', 'Das', 'Ganze', 'ging', 'schnell,', 'die', 'Täter', 'knackten', 'ein', 'Fenster,', 'durchsuchten', 'das', 'Haus,', 'stahlen', 'Bargeld.', 'Als', 'die', 'Polizei', 'kam,', 'waren', 'sie', 'längst', 'verschwunden.', 'Also', 'nahmen', 'die', 'Beamten', 'die', 'Tat', 'auf,', 'dann', 'fuhren', 'auch', 'sie', 'wieder', 'weg.', 'Traurige', 'Routine.')

#TASK 6#
#-------#
#find the indices for the following words. Show all two possible constructions to solve this task.
'Gebersdorf'
'die'
'ein'
'sie'



#TASK 7#
#-------#
#find all words starting with the following letters, independently of whether it is upper case or lower case. Present two possible constructions to solve this task.

't'
'f'
'd'
'a'



#TASK 8#
#-------#
#find all words ending with the following letters. Present two possible constructions to solve this task.

'e'
'm'
't'


#TASK 9#
#-------#
#find all words, which are followed by a word starting with the following letters.

't'
'f'
'd'
'a'



############################################################
## Extracting the appropriate values from the dataframe
############################################################
##load data
DIR = '/home/bella/Dropbox/Master/1st Semester/Quantitative Phonetics with R/Material Corpus etc/KEC' 
setwd(DIR)
load('../RDA/textgrid.rda', verbose = TRUE)

#refer back to task in #3 Praxis slides

str(data)

#find intervals
whereIntervals = data$V1 == 'intervals'
head(whereIntervals)

#or
whereIntervals.numeric = which(whereIntervals)
head(whereIntervals.numeric)

#index the data
where.start = whereIntervals.numeric+1
where.end = whereIntervals.numeric+2
where.word = whereIntervals.numeric+3

#access data
w.start = data$V3[where.start]
w.end = data$V3[where.end]
word = data$V3[where.word]
head(w.start)
head(w.end)
head(word)

class(w.start)
class(w.end)
class(word)

#as numeric
w.start = as.numeric(data$V3[where.start])
w.end = as.numeric(data$V3[where.end])


#create dataframe, solution 1
DF.textgrid = data.frame(
word = word,
w.start = w.start,
w.end = w.end)

#calculate word duration
DF.textgrid$wordduration = DF.textgrid$w.end - DF.textgrid$w.start

#create dataframe, solution 2
DF.textgrid = data.frame(
word = word,
w.start = w.start,
w.end = w.end, 
wordduration = w.end - w.start, 
stringsAsFactors = FALSE)


#get rid of 'words'
index = which(data$V1 == 'name')#get column number
Tiernames = data$V3[index]
Tiernames

#find start of each tier
index.start = which(DF.textgrid$w.start == 5)#get column number
index.start

#extract words-corr
index.firstpart = seq(index.start[1], index.start[2]-1, by = 1)
DF.firstpart = DF.textgrid[index.firstpart,]
tail(DF.firstpart) # check last few entries

DF.textgrid = DF.firstpart

## save data
setwd(DIR)
save(DF.textgrid, file= '../RDA/DF_textgrid.rda')

## check dimensions of dataframe
dim(data)
ncol(data)
nrow(data)


########################################
### TASK ###############################
########################################



#TASK 10#
#-------#
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
#-------#
# Create a set of new vectors and append them to DF.textgrid:
# a) - a new vector "NextWord", containing the following word 
# b) - a new vector "Next2Word", containing the second next word
DF.textgrid$NextWord = c(DF.textgrid$word [seq(from = 2, to = nrow(DF.textgrid))], '')
DF.textgrid$Next2Word = c(DF.textgrid$word [seq(from = 3, to = nrow(DF.textgrid))], '', '')

#TASK 13#
#-------#
# Do the same thing for "PrecedingWord" and "Preceding2Word"

DF.textgrid$PrevWord = c('', DF.textgrid$word [seq(from = 1, to = nrow(DF.textgrid)-1)])
DF.textgrid$Prev2Word = c('', '', DF.textgrid$word [seq(from = 1, to = nrow(DF.textgrid)-2)])

