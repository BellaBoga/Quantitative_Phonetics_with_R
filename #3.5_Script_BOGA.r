#Create a data frame from the second file in the corpus
#folder: rec_001_AS_id_002_CUT_20MIN_2.TextGrid.
#with these columns : word, starts, ends, and word duration.
#get rid of all the pauses then calculate the mean of all
#words' duration then get words with the least and the most
#duration.



 
#get the mean of worddurationDIR = '/home/bella/Dropbox/Master/1st Semester/Quantitative Phonetics with R/Material Corpus etc/KEC/'
setwd(DIR)
filenames = list.files(pattern = 'Textgrid')
head(filenames)
data = read.table('rec_001_AS_id_002_CUT_20MIN_2.TextGrid', fill = NA)

whereInterval = data$V1=='intervals'

whereIntervals.numeric=which(whereInterval)

where.start=whereIntervals.numeric+1
where.end = whereIntervals.numeric+2
where.word = whereIntervals.numeric+3
w.start=as.numeric(as.character(data$V3[where.start]))
w.end=as.numeric(as.character(data$V3[where.end]))
w.word=as.character(data$V3[where.word])

DF.textgrid=data.frame(word=w.word,begins=w.start,ends=w.end,wordduration=w.end-w.start,stringsAsFactors = FALSE)

#get rid of all the Pauses
DF.words=DF.textgrid[!DF.textgrid$word=='<P>',] 
#get rid of all the empty strings
DF.words1=DF.words[!DF.words$wordduration==" ",] 
meanOfWords=mean(DF.words$wordduration) 
meanOfWords
sort(DF.words$wordduration)


#get word with longest duration              
max=DF.words[which(DF.words$wordduration==max(DF.words$wordduration)),1]
max
maxLengthOfWord = max(DF.words1$wordduration)
maxLengthOfWord
DF.words1[max,]

#get word with shortest duration
min=min(DF.words1$wordduration)
min
minLengthOf=min(DF.words1$wordduration)
minLengthOf

