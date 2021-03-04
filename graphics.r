library(ggplot2)
library(reshape2)
library(zoo)
source("cleandata.r")



bargraph <- function(yourData){
  
  bplot = yourData
  bplot = as.numeric(bplot)
  barplot(bplot)
  
} 

heatgraph <- function(yourData){
  
  cormat <- round(cor(yourData),2)
  melted_cormat <- melt(cormat)
  ggplot(data = melted_cormat, aes(x=Var1, y=Var2, fill=value)) + 
    geom_tile()
  
}

densgraph <- function(yourData){
  df = yourData
  df = cleanData(df)
  df = zoo(df)
  plot(df)
  
}

