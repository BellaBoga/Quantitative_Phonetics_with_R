############################################################
## Presentation: Seminar_QP_Praxis_#01_introduction
############################################################

##########  EXCURSION: R Environment ##################
############################################

#### R as an calculator ##################
# simple code 
3+3 #addition
3-3 #subraction
3*3 #multiplication
3/3 #division
2^2 #power
4^(1/2) #root
sqrt(4)


# complex code
3+3+3*2
3+3+(3*2)
3+(3+3)*2



##### Variables ###############
first = 3+3+3*2
second = 3+3+(3*2)
third = 3+(3+3)*2
fourth<- 4*4
alpha <- beta <- gamma <- delta <- 11


##### Display variables ##########
first
second
third

print(first)
print(second)
print(third)

#### Concatenation #################
fourth = c(1,2,3,4,5,6,7,8,9,10)
fourth
# c = function to concatenate multiple entries to a vector

#### Vector math ###################
fourth+2
fourth-2
fourth*2
fourth/2 

fourth*first
fourth*first
fourth*third

class(1/2)


String = 'STRING'
String1 = c('string1', 'string2')
String1 = c(1, 'string1', 'string2')




#### save and load ####################
DIR = '/home/fabian/'
#set the working directory
setwd(DIR)
#saving one variable
save(fourth, file = 'fourth.rda')
#saving multiple variables
save(list=c('first', 'fourth'), file = 'fourth.rda')




setwd(DIR)
#saving one item
load('fourth.rda')
#make the function show the loaded variables
load('fourth.rda', verbose=TRUE)

########################################
### TASK ###############################
########################################
#TASK 1#
#-------#
#Look at the following outputs of T1, T2, T3, etc. 
#What are the intermediate programming steps?  Or put differently: How do you need Test different mathematical operations. Always use TN-1 as a basis for TN.


# >T1
# > 19 20 21 22 23 25 23

#Please modify T1 in order to get T2?
# >T2 
# > 20 21 22 23 24 26 24


# How should the mathematical basis look like in order to get T3 given T1 or T2 as the basis?
# >T3
# >21 23 25 27 29 32 31

# What is the mathematical basis in order to get T4? Which TNs can be used as a basis?
# > T4
# > 420 483 550 621 696 832 744

#TASK 2#
#-------#
# Please perform a vector multiplication of T2 and T3.

# >T5
#      [,1]
# [1,] 4346




