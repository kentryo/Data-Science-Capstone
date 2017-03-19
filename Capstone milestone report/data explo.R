con <- file("./final/en_US/en_US.twitter.txt")
twitter <- readLines(con, encoding = "UTF-8", skipNul = TRUE)
close(con)
#check length
length(twitter)
length_twitter <- nchar(twitter)
max(length_twitter)

#check love/hate
twitter_love <- grep("love", twitter)
twitter_hate <- grep("hate", twitter)
length(twitter_love)/length(twitter_hate)

#check biostats
twitter_biostats <- grep("biostats", twitter)
twitter[twitter_biostats]

#sentence
twitter_sentence <- grep("A computer once beat me at chess, but it was no match for me at kickboxing", twitter)
length(twitter_sentence)