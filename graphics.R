dfmtcars = read.csv("C:/Users/Elève/Desktop/mtcars.csv")
a = as.numeric( dfmtcars[,2], drop=FALSE)
barplot(a)


b=mtcars$cyl
barplot(b)


class(a)
class(b)
