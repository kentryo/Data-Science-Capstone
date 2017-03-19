#Data science capstone project model initial build

#Load data
setwd("C:/Users/runze/Documents/Coursera/Data Science JHU/data science capstone")
if (!file.exists("Coursera-SwiftKey.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip", "Coursera-SwiftKey.zip")
  unzip("Coursera-SwiftKey.zip")
}

blog <- readLines(file("final/en_US/en_US.blogs.txt",open = "rb"))
news <- readLines(file("final/en_US/en_US.news.txt",open = "rb"))
twitter <- readLines(file("final/en_US/en_US.twitter.txt",open = "rb"))

#Merge data and clean data
set.seed(512)
blog_sample <- sample(blog, length(blog)*0.002)
news_sample <- sample(news, length(news)*0.002)
twitter_sample <- sample(twitter, length(twitter)*0.002)
data_sample <- paste(blog_sample, news_sample, twitter_sample)
library(tm)
corpus_sample <- VCorpus(VectorSource(data_sample))
corpus_sample <- tm_map(corpus_sample, removeNumbers)
corpus_sample <- tm_map(corpus_sample, removePunctuation)
corpus_sample <- tm_map(corpus_sample, stripWhitespace)
corpus_sample <- tm_map(corpus_sample, removeWords, stopwords("english"))
corpus_sample <- tm_map(corpus_sample, content_transformer(tolower))
corpus_sample <- tm_map(corpus_sample, PlainTextDocument)

#N-gram analysis
library(RWeka)
library(ggplot2)

bigram <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
corpus_sample_bigram <- TermDocumentMatrix(corpus_sample, control = list(tokenize = bigram))
corpus_sample_bigram_rsparsed <- removeSparseTerms(corpus_sample_bigram, 0.999)
bigram_freq <- sort(rowSums(as.matrix(corpus_sample_bigram_rsparsed)), decreasing = TRUE)
bigram_freq_table <- data.frame(ngram_word = names(bigram_freq), Frequency = bigram_freq)
  
trigram <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
corpus_sample_trigram <- TermDocumentMatrix(corpus_sample, control = list(tokenize = trigram))
corpus_sample_trigram_rsparsed <- removeSparseTerms(corpus_sample_trigram, 0.999)
trigram_freq <- sort(rowSums(as.matrix(corpus_sample_trigram_rsparsed)), decreasing = TRUE)
trigram_freq_table <- data.frame(ngram_word = names(trigram_freq), Frequency = trigram_freq)
  
quadgram <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
corpus_sample_quadgram <- TermDocumentMatrix(corpus_sample, control = list(tokenize = quadgram))
corpus_sample_quadgram_rsparsed <- removeSparseTerms(corpus_sample_quadgram, 0.999)
quadgram_freq <- sort(rowSums(as.matrix(corpus_sample_quadgram_rsparsed)), decreasing = TRUE)
quadgram_freq_table <- data.frame(ngram_word = names(quadgram_freq), Frequency = quadgram_freq)


# test
data <- paste(blog, news, twitter)
length_data <- length(data)
final_bi <- data.frame()
final_tri <- data.frame()
final_quad <- data.frame()

for (i in 1:1000){
  data_sample <- data[floor(length_data*(i-1)*0.001+1): floor(length_data*i*0.001)]
  corpus_sample <- VCorpus(VectorSource(data_sample))
  corpus_sample <- tm_map(corpus_sample, removeNumbers)
  corpus_sample <- tm_map(corpus_sample, removePunctuation)
  corpus_sample <- tm_map(corpus_sample, stripWhitespace)
  corpus_sample <- tm_map(corpus_sample, removeWords, stopwords("english"))
  corpus_sample <- tm_map(corpus_sample, content_transformer(tolower))
  corpus_sample <- tm_map(corpus_sample, PlainTextDocument)
  bigram <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
  corpus_sample_bigram <- TermDocumentMatrix(corpus_sample, control = list(tokenize = bigram))
  corpus_sample_bigram_rsparsed <- removeSparseTerms(corpus_sample_bigram, 0.999)
  bigram_freq <- sort(rowSums(as.matrix(corpus_sample_bigram_rsparsed)), decreasing = TRUE)
  bigram_freq_table <- data.frame(ngram_word = names(bigram_freq), Frequency = bigram_freq)
  final_bi <- rbind(final_bi, bigram_freq_table)
  final_bi <- aggregate(.~ ngram_word, data = final_bi, FUN = sum)
  
  trigram <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
  corpus_sample_trigram <- TermDocumentMatrix(corpus_sample, control = list(tokenize = trigram))
  corpus_sample_trigram_rsparsed <- removeSparseTerms(corpus_sample_trigram, 0.999)
  trigram_freq <- sort(rowSums(as.matrix(corpus_sample_trigram_rsparsed)), decreasing = TRUE)
  trigram_freq_table <- data.frame(ngram_word = names(trigram_freq), Frequency = trigram_freq)
  final_tri <- rbind(final_tri, trigram_freq_table)
  final_tri <- aggregate(.~ ngram_word, data = final_tri, FUN = sum)
  
  quadgram <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
  corpus_sample_quadgram <- TermDocumentMatrix(corpus_sample, control = list(tokenize = quadgram))
  corpus_sample_quadgram_rsparsed <- removeSparseTerms(corpus_sample_quadgram, 0.999)
  quadgram_freq <- sort(rowSums(as.matrix(corpus_sample_quadgram_rsparsed)), decreasing = TRUE)
  quadgram_freq_table <- data.frame(ngram_word = names(quadgram_freq), Frequency = quadgram_freq)
  final_quad <- rbind(final_quad, quadgram_freq_table)
  final_quad <- aggregate(.~ ngram_word, data = final_quad, FUN = sum)
  
  print(i)
  if(i%%100 == 0){
    save(final_bi, file = "final_bi_001.RDS")
    save(final_tri, file = "final_tri_001.RDS")
    save(final_quad, file = "final_quad_001.RDS")
  }
}

for(i in 1:nrow(final_bi)) {
  word <- as.character(final_bi[i, 1])
  word1 <- strsplit(word, " ")[[1]][1]
  final_bi[i, 3] <- word1
  word2 <- strsplit(word, " ")[[1]][2]
  final_bi[i, 4] <- word2
}
colnames(final_bi)[3] <- "word1"
colnames(final_bi)[4] <- "word2"

for(i in 1:nrow(final_tri)) {
  word <- as.character(final_tri[i, 1])
  word1 <- strsplit(word, " ")[[1]][1]
  final_tri[i, 3] <- word1
  word2 <- strsplit(word, " ")[[1]][2]
  final_tri[i, 4] <- word2
  word3 <- strsplit(word, " ")[[1]][3]
  final_tri[i, 5] <- word3
}
colnames(final_tri)[3] <- "word1"
colnames(final_tri)[4] <- "word2"
colnames(final_tri)[5] <- "word3"

for(i in 1:nrow(final_quad)) {
  word <- as.character(final_quad[i, 1])
  word1 <- strsplit(word, " ")[[1]][1]
  final_quad[i, 3] <- word1
  word2 <- strsplit(word, " ")[[1]][2]
  final_quad[i, 4] <- word2
  word3 <- strsplit(word, " ")[[1]][3]
  final_quad[i, 5] <- word3
  word4 <- strsplit(word, " ")[[1]][4]
  final_quad[i, 6] <- word4
}
colnames(final_quad)[3] <- "word1"
colnames(final_quad)[4] <- "word2"
colnames(final_quad)[5] <- "word3"
colnames(final_quad)[6] <- "word4"
