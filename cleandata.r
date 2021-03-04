library("dplyr")

cleanData <- function(yourData){
  
  df = yourData
  df = select_if(yourData, is.numeric)
  df[complete.cases(df), ]
  return(df)
}






