#Read File
library(readxl)
text <- read_excel('Example Data.xlsx')

# Load the data as a corpus
TextDoc <- Corpus(VectorSource(Example_data$`Review Text`))

##Perform Data Cleaning

#Replacing "/", "@" and "|" with space
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
TextDoc <- tm_map(TextDoc, toSpace, "/")
TextDoc <- tm_map(TextDoc, toSpace, "@")
TextDoc <- tm_map(TextDoc, toSpace, "\\|")
TextDoc <- tm_map(TextDoc, toSpace, "!")

# Convert the text to lower case
TextDoc <- tm_map(TextDoc, content_transformer(tolower))
# Remove numbers
TextDoc <- tm_map(TextDoc, removeNumbers)
# Remove English Default Stop words
TextDoc <- tm_map(TextDoc, removeWords, stopwords("english"))
stopwords()
#Remove Punctuation
TextDoc <- tm_map(TextDoc, removePunctuation)
# Eliminate extra white spaces
TextDoc <- tm_map(TextDoc, stripWhitespace)
# Text stemming - which reduces words to their root form
TextDoc <- tm_map(TextDoc, stemDocument)

# Build a term-document matrix
TextDoc_dtm <- TermDocumentMatrix(TextDoc)
dtm_m <- as.matrix(TextDoc_dtm)
# Sort by descending value of frequency
dtm_v <- sort(rowSums(dtm_m),decreasing=TRUE)
dtm_d <- data.frame(word = names(dtm_v),freq=dtm_v)
# Display the top 10 most frequent words
head(dtm_d, 10)

#Plotting the top 10 most frequent words using a bar chart

barplot(dtm_d[1:10,]$freq, las = 2, names.arg = dtm_d[1:10,]$word,
        col ="lightgreen", main ="Top 10 most frequent words",
        ylab = "Word frequencies")

#Generate a Word Cloud
wordcloud2(dtm_d,
           size = 0.2,
           shape = 'star',
           rotateRatio = 0.5,
           minSize = 1)

# Find Word associations between the top 3 used words
findAssocs(TextDoc_dtm, terms = c("dress","love", "size"), corlimit = 0.15)

# Find associations for words that occur at least 7000 times
findAssocs(TextDoc_dtm, terms = findFreqTerms(TextDoc_dtm, lowfreq = 7000), corlimit = 0.25)

#Analysis: Only the word 'size' is associated with 'true' at 0.31

#Perform Sentiment Analysis
library(syuzhet)
input <- iconv(Example_data$`Review Text`)


sentiment <- get_nrc_sentiment(input)
head(sentiment, 20)

#Plotting the top 10 most sentiments using a bar chart
barplot(colSums(sentiment),
        las = 2,
        col = rainbow(10),
        ylab = 'Count',
        main = 'Sentiment Scores on Reviews')

#Convert the corpus into a data frame with the words inside
review_data <- data.frame(text = sapply(TextDoc,as.character),
                          stringsAsFactors = F)
#Creating bi-grams using the dataframe
review_bigram <- review_data %>% 
  unnest_tokens(bigram, text, token = 'ngrams',n = 2)

review_bigram

#Count the frequency of bigram
review_bigram %>% 
  count(bigram, sort = T)

#Separate the bigrams, so that it can print the relationships
bigram_sep <- review_bigram %>% 
  separate (bigram, c("word1","word2"), sep = " ")

bigram_sep

#Filter the bigrams and further remove the stopwords
bigram_fil <- bigram_sep %>% 
  filter(!word1 %in% stop_words$word)%>% 
  filter(!word2 %in% stop_words$word)
stop_words

bigram_fil <- bigram_sep %>% 
  filter(!(word1 %in% stop_words$word & word1 != "not")) %>% 
  filter(!(word2 %in% stop_words$word & word2 != "not"))

#Create new bigram count
bigram_count <- bigram_fil%>% 
  count(word1, word2, sort = T)
bigram_count

#Create a bigram graph
bigram_graph <- bigram_count %>% 
  filter(n > 20) %>% 
  graph_from_data_frame() ## it creates a dataframe for analyzing in bigram graph

bigram_graph

#Generate a Word Cloud
library(wordcloud2)
review_freq <- review_bigram %>% 
  count(bigram, sort = T) %>% filter(n > 50)

wordcloud2(review_freq,
           size = 0.2,
           shape = 'star',
           rotateRatio = 0.5,
           minSize = 1)
wordcloud2(data = review_freq, size = 0.5, color = "blue")

