#for loops ( for command, rounded bracket, tell it which variable you want to change  

for(iloop in 1:3)
{
  result = iloop+1
  cat('In loop', iloop, 'we add one to', iloop, 'and the result is ', result, '\n')
}
#cat function takes input and concatenate its and show it in your prompt

stringvector = c('a', 'b', 'c', 'd')
for(iloop in stringvector)
{
  cat('The current value of iloop is: ' ,iloop, '\n')
}

stringvector1 = c('Live', 'long', 'and', 'prosper')
for(iloop in stringvector1)
{
  Vulcan.o = grepl('o', iloop)
  cat('The calue in iloop contains the letter "o": ', Vulcan.o, '\n')
}


DF = data.frame(1:10,11:20)
colnames(DF) <- c('Funny', 'Moments')
for(iloop in 1:10)
{
  tmp = DF[iloop,]
  tmp
}
tmp
print(tmp)



### FInd another function to repeat a certain piece of code. 
#How does this differ from for() and what do you have to take into account using it

DF1 = data.frame(A=1:3, B = 11:13, C= letters[1:3])
DF2 = data.frame(A = 1:3, B = 11:13)
DF3 = data.frame() #empty DF
DF3 = rbind(DF1, DF2)
DF3


DF1 = data.frame(A = 1:3, B = 11:13, C = letters[1:3])
DF2 = data.frame(A = 1:3, B = 11:13)
#try to bind ---- nope, not working
DF3 = data.frame() #empty DF
try({DF3 = rbind(DF1, DF2)})
DF3


DF1 = data.frame(A = 1:3, B = 11:13)
DF2 = data.frame(C = 1:3, D = 11:13)
#assess names
colnames(DF1)
colnames(DF2)
#bind
DF3 = data.frame() #empty DF
try({DF3 = rbind(DF1, DF2)}, silent =FALSE)
DF3





##Given the two existing dataframes 
#DF1 and DF2 come up with a solution  to the problem of binding dataframes with different cocolumnnames.




dim(DF)





##Take your solution from task 3.5 and adapt it in such a way that it can be executed inthe for lopp from aboce
#Proceed in the following way:In each iteration first clean the loaded data, extract all necessary in
#formation)word, start, word end, word, and then append it to DFbig. STORE IT


