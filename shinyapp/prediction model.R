#Load the dataset analysis result
final_bi <- readRDS("final_bi.RDS")
final_tri <- readRDS("final_tri.RDS")
final_quad <- readRDS("final_quad.RDS")

library(tm)
library(stringr)
library(stylo)

prediction <- function(inword){
  word_split <- txt.to.words.ext(inword, language="English")
  word_length <- length(word_split)
  
  if(word_length >= 3){
    inword1 <- word_split[word_length - 2]
    inword2 <- word_split[word_length - 1]
    inword3 <- word_split[word_length]
    prediction_list <- final_quad[final_quad$word1==inword1 & final_quad$word2==inword2 & final_quad$word3==inword3, ]
    prediction_list <- prediction_list[order(-prediction_list$Frequency), ]
    if(nrow(prediction_list) >= 1){
      return(as.character(prediction_list$word4[1:3]))
    }
  }
  if(word_length >= 2){
    inword1 <- word_split[word_length - 1]
    inword2 <- word_split[word_length]
    prediction_list <- final_tri[final_tri$word1==inword1 & final_tri$word2==inword2, ]
    prediction_list <- prediction_list[order(-prediction_list$Frequency), ]
    if(nrow(prediction_list) >= 1){
      return(as.character(prediction_list$word3[1:3]))
    }
  }
  if(word_length >= 1){
    inword1 <- word_split[word_length]
    prediction_list <- final_bi[final_bi$word1==inword1, ]
    prediction_list <- prediction_list[order(-prediction_list$Frequency), ]
    if(nrow(prediction_list) >= 1){
      return(as.character(prediction_list$word2[1:3]))
    }
    else{
      return(as.character("No prediction could be made."))
    }
  }
}

