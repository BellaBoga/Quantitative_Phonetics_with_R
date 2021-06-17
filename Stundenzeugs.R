load('/home/bella/Dropbox/Master/1st Semester/Quantitative Phonetics with R/Material Corpus etc/KEC/RDA/textgrid.rda', verbose=TRUE)
tail(data,25)
head(data)
head(data,25)
#find intervals

whereIntervals = data$V1 == 'intervals'
head(whereIntervals)
head(whereIntervals,25)
data[whereIntervals,]
whereIntervals
which(whereIntervals)
whereIntervals.numeric = which(whereIntervals)
head(whereIntervals.numeric)
head(data,25)

where.start = whereIntervals.numeric+1
where.end = whereIntervals.numeric+2
where.word = whereIntervals.numeric+3

where.start
where.end
where.word


w.start = data$V3[where.start]
w.end = data$V3[where.end]
word= data$V3[where.word]
w.start
w.end
word


data$V3
w.start = as.numeric(data$V3[where.start])
class(w.start)
as.character(1)
as.numeric(as.character((1)))
as.numeric('a')
Vector = c('1', '2', 'a')

DF.textgrid = data.frame(
  word=word,
  w.start=w.start,
  w.end = w.end,
  stringsAsFactors = FALSE)
head(DF.textgrid)

w.start = as.numeric(as.character(data$V3[where.start]))
w.end = as.numeric(as.character(data$V3[where.end]))

w.start
w.end
head(DF.textgrid)

DF.textgrid$wordduration = DF.textgrid$w.end - DF.textgrid$w.start
DF.textgrid
str(DF.textgrid)
head(DF.textgrid)

index = which(data$V1 =='name')
Tiernames = data$V3[index]
Tiernames
head(data,25)
index.start = which(DF.textgrid$w.start == 0)

index.start
Tiernames
index.start
index.start[-1]
index.start[2]-1
