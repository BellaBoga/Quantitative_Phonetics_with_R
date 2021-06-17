## NUMBERS NUMBERS NUMBERS ###########

## scientific notation

## integer vs. floating point


# one number is per default floating point "double precision vector"

class(1)
mode(1)
typeof(1)

# type and mode provide different types of information
class(as.integer(1))
typeof(as.integer(1))
mode(as.integer(1))


# only when "integers" are provided, numbers become integers
class(1:2)
mode(1:2)
typeof(1:2)


# transform from one class into another
as.double(0.3)
as.integer(0.3)

# rounding of floating point numbers
Number = seq(0, 1, by=.1)[4]
print(Number, digits=20)
class(Number)


## test object size

test = as.integer(1:1000000)
print(object.size(test), units = 'Mb')

test = as.double(1:1000000)
print(object.size(test), units = 'Mb')


########################################################
## presentation of numbers in the prompt ###

#Exponential presentation
a = 1000000000000000000000000000
a

test <- c(a, 1.810032e+09, 4) 
test

#change presentation before comma
options(scipen=-100)

test

options(scipen=100)

test

options(scipen=10)

test

# change presentation after comma
options(digits=4)

test <- c(4/3223, 4/2.455)
test


options(digits=10)
test


# BEWARE OF VERY LARGE NUMBERS (which you probably will never encounter in statistics)
# R can handle a precision with lengths up to  +/-2*10^9 when you are using a 32bit system.

#TASK: test different power exponents up to, e.g. 50.


############################################################
## Presentation: Seminar_QP_Praxis_#02_global_design
############################################################


##########  Reading in tables ##################
################################################

#### Setting working directory ##################
DIR = '/home/fabian/Dropbox/Uni/Texte/Paper/Baayen_Gruppe/WIP/R_programming/data/KEC/' 
#DIR = 'REPLACE.THIS.STRING.WITH.YOUR.DIRECTORY.AND.COMMENT.THE.OTHER.ABOVE.OUT'

getwd() # show directory
setwd(DIR)
getwd() # show directory

################################################
#### EXCURSION: VARIABLE CLASSES ###############
################################################
## getting variable class

first.string = 'This is a string and it contains a 4 (four) and a $ (Dollar sign)'
class(first.string)


class(c('a', "a", "a's", 'a\'s'))

second.string = c('first string', 'second string', 'third string')
second.string

numbers = c(1,2,3,4,5)
numbers
class(numbers)

## changing variable class
strings = as.character(numbers)
strings
class(strings)

numbers.again = as.numeric(strings)
numbers.again
class(numbers.again)

#TEST: What happens if you change letters into numbers?

## one string to rule them all
A = c(1,'a')
A
B = c(1,2,3,4,'a')
B
class(A)
class(B)


##### File names #########
## get filenames and show them
setwd(DIR)
filenames = list.files()
head(filenames)
head(filenames, 10)

tail(filenames, 10)


filenames = list.files(pattern = 'TextGrid')

class(filenames)
filenames
head(filenames)
tail(filenames)

################################################
#### EXCURSION: ACCESSING VECTORS ###############
################################################
#Using a variable as an index to acces entries
index = 1
fn = filenames[index]
fn = filenames[1]

print(fn)



# Using a number as an index
filenames[1] #accessing one entry directly
filenames[c(1,3,5)] #accessing several entries

# Changing entries
changeVector = c(1,2,3,4,5)
changeVector[3] = 99
changeVector

# delete an entry

changeVector = changeVector[-3]



### Read a table located on your hard disc####
setwd(DIR)
filenames[1]

data = read.table('rec_001_AS_id_002_CUT_20MIN_1.TextGrid')

### dealing with problems: reading error messages.
?read.table

data = read.table('rec_001_AS_id_002_CUT_20MIN_1.TextGrid', fill = NA)
data = read.table(filenames[1], fill = NA)

## variable information ##
class(data)
str(data)

## problem: "factors"
data = read.table(filenames[1], fill = NA, stringsAsFactors=FALSE)
class(data)
str(data)


## save data
setwd(DIR)
save(data, file= './RDA/textgrid.rda')



################################################
#### EXCURSION: DATAFRAMES ###############
################################################
DF1 = data.frame(Numbers = seq(1,10))
DF1

DF1$NewNumbers = seq(11,20) #assigning new numbers and attaching columns
DF1$NewLetters = letters[1:10] #creating a column 
DF1$MoreLetters = LETTERS[1:10] #creating a column 
DF1
str(DF1) #showing structure
DF1$NewLetters #accessing one column
DF1$NewLetters = NULL #delet a column
DF1
str(DF1)

#renaming columns and rows

colnames(DF1) = c('A', 'B', 'C')
rownames(DF1) = letters[1:10]


# Accessing dataframes
#by columns
DF1[,'NewNumbers'] 
DF1[,'A'] 
DF1[,1]

#by rows 
DF1['a',]
DF1[1,]

#by both
DF1['a', 'B']


# Rewriting

DF1['a', 'B'] = 9999999
DF1


#########################################################
#### EXCURSION: SEQUENCES AND REPETITIONS ###############
################################################
five = seq(from=1, to=10, by=1)
five
six = seq(from=1,to=10,by=2)
six
seven = seq(from=1,to=10,by=0.5)
seven

seven1 = seq(from=1,to=10,length=2)
seven1
seven2 = seq(from=1,to=10,length=15)
seven2

eight = rep (1, times=5)
eight


rep(1:3, times=5)
rep(1:3, each=5)
rep(c(1,2,3), each=5)

rep(1:3, times=2,each=5)

rep(4:6, each = 2, times = 2)
rep(rep(4:6,times=2),each=2)
rep(rep(4:6,each=2),times=2)


a = rep(seq(from=1,to=4), times=4)
a



########################################
### TASK ###############################
########################################
#TASK 3#
#-------#

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



# T2
#  [1] "1" "B" "γ" "1" "B" "γ" "1" "B" "γ" "1" "B" "γ"


# > T3
#  [1] "1" "1" "1" "1" "B" "B" "B" "B" "γ" "γ" "γ" "γ"



# > T4
#  [1] 10.00000 10.66667 11.33333 12.00000 10.00000 10.66667 11.33333 12.00000
#  [9] 10.00000 10.66667 11.33333 12.00000


# > T5
#  [1] 10.00 10.25 10.50 10.75 11.00 11.25 11.50 11.75 12.00 10.00 10.25 10.50
# [13] 10.75 11.00 11.25 11.50 11.75 12.00 10.00 10.25 10.50 10.75 11.00 11.25
# [25] 11.50 11.75 12.00

