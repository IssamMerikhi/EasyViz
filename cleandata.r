library("dplyr")
dataaa = read.csv("C:/Users/Elève/Desktop/PL.csv")


cleanData <- function(yourData){

  df = yourData
  df = attach(df)
  df = select_if(yourData, is.numeric)
  df[complete.cases(df), ]
  return(df)
}

df <- cleanData(yourData)
