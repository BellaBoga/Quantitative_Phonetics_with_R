########################################
### TASK ###############################
########################################

#TASK 1#
#-------#
#Look at the following outputs of T1, T2, T3, etc. 
#What are the intermediate programming steps? Test different mathematical operations.
T1 = c(19,20,21,22,23,25,23)

# >T1
# > 19 20 21 22 23 25 23

#Given T1, what should you do to get T2?
T2 = T1+1
# >T2 
# > 20 21 22 23 24 26 24

# How should the mathematical basis look like in order to get T3 given T1 or T2 as the basis?

T3 = T2+c(1,2,3,4,5,6,7)
# >T3
# >21 23 25 27 29 32 31

# What is the mathematical basis in order to get T4? Which TNs can be used as a basis?
T4 = T2*T3
# > T4
# > 420 483 550 621 696 832 744

#TASK 2#
#-------#
# Please perform a vector multiplication of T2 and T3.
T5 = T2%*%T3
# >T5
#      [,1]


########################################
### TASK ###############################
########################################


#TASK 3#
#-------#

T1 = data.frame(V1 = rep(c('A','B', 'C'), times=2), V2 = rep(c('a','b', 'c'), each=2))

# > class(T1)
# [1] "data.frame"

# > T1
#   V1 V2
# 1  A  a
# 2  B  a
# 3  C  b
# 4  A  b
# 5  B  c
# 6  C  c

T1$V3 = 1:6

# > T1
#   V1 V2 V3
# 1  A  a  1
# 2  B  a  2
# 3  C  b  3
# 4  A  b  4
# 5  B  c  5
# 6  C  c  6


#TASK 4#
#-------#


T2 = rep(c(1,'B','γ'), times = 4)
# T2
#  [1] "1" "B" "γ" "1" "B" "γ" "1" "B" "γ" "1" "B" "γ"

T3 = rep(c(1,'B','γ'), each = 4)
# > T3
#  [1] "1" "1" "1" "1" "B" "B" "B" "B" "γ" "γ" "γ" "γ"


T4 = rep(seq(from=10,to=12,length = 4), times = 3)
# > T4
#  [1] 10.00000 10.66667 11.33333 12.00000 10.00000 10.66667 11.33333 12.00000
#  [9] 10.00000 10.66667 11.33333 12.00000

T5 = rep(seq(from=10,to=12,by = 0.25), times = 3)
T5 = rep(seq(from=10,to=12, length = 9), times = 3)

# > T5
#  [1] 10.00 10.25 10.50 10.75 11.00 11.25 11.50 11.75 12.00 10.00 10.25 10.50
# [13] 10.75 11.00 11.25 11.50 11.75 12.00 10.00 10.25 10.50 10.75 11.00 11.25
# [25] 11.50 11.75 12.00


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

which(T1 %in% 'Gebersdorf')
which(T1 %in% 'die')
which(T1 %in% 'ein')
which(T1 %in% 'sie')

grep('Gebersdorf', T1)
etc.

#TASK 7#
#-------#
#find all words starting with the following letters, independently of whether it is upper case or lower case. Present two possible constructions to solve this task.

't'
'f'
'd'
'a'

grep('^t|^f|^d|^a|^T|^F|^D|^A', T1, value = TRUE)

where = grep('^t|^f|^d|^a|^T|^F|^D|^A', T1)
T1[where]

where = grepl('^t|^f|^d|^a|^T|^F|^D|^A', T1)
T1[where]

#TASK 8#
#-------#
#find all words ending with the following letters. Present two possible constructions to solve this task.

'e'
'm'
't'

grep('e$|m$|t$', T1, value = TRUE)

#TASK 9#
#-------#
#find all words, which are followed by a word, which starts with the following letters.

't'
'f'
'd'
'a'

where = grep('^t|^f|^d|^a|^T|^F|^D|^A', T1)
T1[where-1]


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

