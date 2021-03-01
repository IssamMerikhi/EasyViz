#df = read.csv("C:/Users/Elève/Desktop/PL.csv")
library(tidyr)
library(ggplot2)

head(diamonds)

multi.hist(diamonds[,sapply(diamonds, is.numeric)])
