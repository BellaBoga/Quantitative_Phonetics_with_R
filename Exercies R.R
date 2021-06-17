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
grep('ein', T1)
grep('sie', T1)

############# 2 #####################

which(T1=='Gebersdorf')
which(T1=='die')
which(T1=='ein')
which(T1=='sie')


