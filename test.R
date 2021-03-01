df = read.csv("C:/Users/Elève/Desktop/PL.csv")
library(tidyr)
library(ggplot2)

head(mtcars)
ggplot(gather(mtcars), aes(value)) + 
  geom_bar() + 
  facet_wrap(~key, scales = 'free_x')
