########################################
### TASK ###############################
########################################

#TASK 3#
#-------#

T1 = data.frame(V1 = rep(letters[1:3], times = 2))
  
T1$V2 = rep(LETTERS[1:3], times = 2)
T1$V3 = seq(1,6)

T1


#TASK 4#
#-------#

T2 = c('1', 'B', 'γ')

rep(c('1', 'B', 'γ'), times = 4)

# > T3

T3 = c('1', 'B', 'γ')

rep(c('1', 'B', 'γ'), each = 4, times =1)

# > T4

T4 = rep(seq(from=10, to=12, by=2/3),times=1, length=12)
T4


#  [1] 10.00000 10.66667 11.33333 12.00000 10.00000 10.66667 11.33333 12.00000
#  [9] 10.00000 10.66667 11.33333 12.00000


# > T5

T5 = rep(seq(from=10,to=12,by = 0.25),times=3)
T5 


########################################
### TASK ###############################
########################################

T1 = c('Gebersdorf', 'ist', 'ein', 'eher', 'langweiliger', 'Vorort', 'von', 'Nürnberg,', 'keine', 'Villen,', 'sondern', 'solide', 'Häuser,', 'enge', 'Straßen,', 'hohe', 'Hecken.', 'Am', '7.', 'Februar', '2015', 'wurde', 'dort', 'in', 'eines', 'der', 'Einfamilienhäuser', 'eingebrochen.', 'Einer', 'von', 'ungefähr', '650', 'Einbrüchen', 'im', 'Jahr,', 'allein', 'in', 'Nürnberg.', 'Das', 'Ganze', 'ging', 'schnell,', 'die', 'Täter', 'knackten', 'ein', 'Fenster,', 'durchsuchten', 'das', 'Haus,', 'stahlen', 'Bargeld.', 'Als', 'die', 'Polizei', 'kam,', 'waren', 'sie', 'längst', 'verschwunden.', 'Also', 'nahmen', 'die', 'Beamten', 'die', 'Tat', 'auf,', 'dann', 'fuhren', 'auch', 'sie', 'wieder', 'weg.', 'Traurige', 'Routine.')

#TASK 6#
#-------#
#find the indices for the following words. Show all two possible constructions to solve this task.

############# 1 #####################

grep('Gebersdorf', T1)
grep('die', T1)
grep('^ein$', T1)
grep('sie', T1)

############# 2 #####################

which(T1=='Gebersdorf')
which(T1=='die')
which(T1=='ein')
which(T1=='sie')

#TASK 7#
#-------#
#find all words starting with the following letters, independently of whether it is upper case or lower case. 
#Present two possible constructions to solve this task.
#'t'
#'f'
#'d'
#'a'
############# 1 #####################

grep('^t', T1,ignore.case=TRUE, value = TRUE)
grep('^f', T1,ignore.case=TRUE, value = TRUE)
grep('^d', T1,ignore.case=TRUE, value = TRUE)
grep('^a', T1,ignore.case=TRUE, value = TRUE)

############# 2 #####################

grep('^t|^T', T1,value = TRUE)
grep('^f|^F', T1,value = TRUE)
grep('^d|^D', T1,value = TRUE)
grep('^a|^A', T1,value = TRUE)



############# 3 #####################
abc = grep ('^t|^T', T1)
def = grep('^f|^F', T1)
ghi = grep('^d|^D', T1)
jkl = grep('^a|^A', T1)


T1[abc]
T1[def]
T1[ghi]
T1[jkl]

#TASK 8#
#-------#
#find all words ending with the following letters. Present two possible constructions to solve this task.
#'e'
#'m'
#'t'
############# 1 #####################

grep('e$', T1,ignore.case=TRUE, value = TRUE)
grep('m$', T1,ignore.case=TRUE, value = TRUE)
grep('t$', T1,ignore.case=TRUE, value = TRUE)

############# 2 #####################

whatever = grep('e$|m$|t$', T1)

T1[whatever]

############# 3 #####################

grep('e$|m$|t$', T1) #this only give us the indices but we still know found the words we were supposed to find


#TASK 9#
#-------#
#find all words, which are followed by a word starting with the following letters.
#'t'
#'f'
#'d'
#'a'

var2 = grep('^t|^f|^d|^a',T1, ignore.case = TRUE)
T1[var2-1]
