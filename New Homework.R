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



#TASK 9#
#-------#
#find all words, which are followed by a word starting with the following letters.
#'t'
#'f'
#'d'
#'a'