library(ggplot2)
library(reshape2)
library(zoo)
library(igraph)
library(networkD3)
source("cleandata.r")




bargraph <- function(yourData){
  
  df = yourData
  df = cleanData(df)
  df = zoo(df)
  barplot(df, main = "Densities", beside = TRUE)
  
}

heatgraph <- function(yourData){
  
  cormat <- round(cor(yourData),2)
  melted_cormat <- melt(cormat)
  ggplot(data = melted_cormat, aes(x=Var1, y=Var2, fill=value), title("Heatmap")) + 
    geom_tile() + ggtitle("Heatmap") +
    xlab("Features") + ylab("Features")
  
}

densgraph <- function(yourData){
  df = yourData
  df = cleanData(df)
  df = zoo(df)
  plot(df, main = "Densities")
  
}

