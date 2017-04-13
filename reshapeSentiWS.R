#manually delete the |NN stuff, it doesn't work very well in R. Regex: \|\S{1,5}

#load sentiment files
negativ <- read.table("SentiWS_v1.8c_Negative.txt", fill = TRUE)
positiv <- read.table("SentiWS_v1.8c_Positive.txt", fill = TRUE)

#split into single words
einzelworte_negativ <- strsplit(as.character(negativ$V3), split =",")
einzelworteframe_negativ <- as.data.frame(unlist(einzelworte_negativ))

einzelworte_positiv <- strsplit(as.character(positiv$V3), split =",")
einzelworteframe_positiv <- as.data.frame(unlist(einzelworte_positiv))

#takes the number of words and creates a data frame only with the sentiment scores as many times as the word inflection occurs.
number_words <- summary(einzelworte_negativ)

sentiment_score <- NULL
for (i in 1:1818) {
j <- 0
while (j < as.numeric(number_words[i])) {
 sentiment_score <- rbind(sentiment_score, negativ[i,2])
 j <- j+1
}
}

#it's ugly. i know and i'm sorry...
number_words <- summary(einzelworte_positiv)

sentiment_score <- NULL
for (i in 1:1650) {
  j <- 0
  while (j < as.numeric(number_words[i])) {
    sentiment_score <- rbind(sentiment_score, positiv[i,2])
    j <- j+1
  }
}

#bind the sentiment score with the words
new_negativ <- cbind(as.character(einzelworteframe_negativ[,1]), sentiment_score)
new_negativ <- rbind(negativ[,1:2], new_negativ)

new_positiv <- cbind(as.character(einzelworteframe_positiv[,1]), sentiment_score)
new_positiv <- rbind(positiv[,1:2], new_positiv)
