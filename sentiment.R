require(jsonlite)

setwd("ownCloud/Uni/TechReview/Online/Data/Comments/")

#comments <- as.character(read.table("bodies.txt", sep = "*")[,2])

comments <- fromJSON("comments.json", flatten = TRUE)
#export actual comments
comments <- comments$threads$postings.content.body

#set to lower case, remove links and formatting and everything besides whitespace, numbers and letters
#comments <- tolower(comments)
comments <- gsub("\\[quote\\].*\\[\\/quote\\]", "", comments)
comments <- gsub(" ?(f|ht)tp(s?)://(.*)[.][a-z]+", "", comments)
comments <- gsub("\\[.*?\\]", "", comments)
comments <- gsub("[^[:alnum:] ]", "", comments)

#import sentiment tables and set to lower case
negativ <- read.csv("new_negativ.csv", row.names = 1)
positiv <- read.csv("new_positiv.csv", row.names = 1)

#negativ[,1] <- tolower(as.character(negativ[,1]))
#positiv[,1] <- tolower(as.character(positiv[,1]))

#strip comments into single words
for (i in 1:length(comments)) {
  comments[i] <- strsplit(as.character(comments[i]), " ")
  i <- i + 1
}

liste <- NULL

for (i in 1:length(comments)) {
  score <- NULL
  #check if word in comment is in list. if yes, generate vector with scores
  for (word in unlist(comments[i])) {
    if (is.element(word, negativ[,1])) {
    score <- c(score, negativ[negativ[,1] == word,2])
    }
    if (is.element(word, positiv[,1])) {
      score <- c(score, positiv[positiv[,1] == word,2])
    }
  }
  var <- cbind(i, mean(score))
  if (!is.null(score))
    liste <- rbind(liste, var)
  else
    liste <- rbind(liste, cbind(i, 0))
  print(score)
  }