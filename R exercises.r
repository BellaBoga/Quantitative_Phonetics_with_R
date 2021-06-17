###Find Data####


DIR = getwd()

class('1')

class(c('a', "a"))

A = c(1, 'a')
A
B = c(1,2,3,4,'a')
B
class(A)
class(B)


setwd(DIR)

filenames = list.files()
head(filenames, 10)

tail(filenames)

filenames = list.files(pattern = 'Textgrid')

filenames



index = 1

fn = filenames[index]
fn = filenames[1]

print(fn)