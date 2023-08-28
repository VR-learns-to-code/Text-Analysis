# Text-Analysis

I have used Term Document Matrix, Word Cloud, Word associations, Sentiment Analysis & Bigram Language Model to perform Text Analysis on an online retail feedback data.

Steps to perform Text Analysis:
1. Read the Excel file
2. Load the data as Corpus
3. Cleaning the data by making transformations to remove special characters, punctuations and white space.
4. Replace special characters (like "/", "@" and "|") with space.
5. Convert the text to lower case
6. Remove numbers
7. Remove English Default Stop words and also customize stopwords.
8. Remove Punctuation
9. Eliminate extra white spaces
10. Perform Text Stemming. It is the process of reducing the word to its root form. The stemming process simplifies the word to its common origin. For example, the stemming process reduces the words"fishing", "fished" and "fisher" to its stem "fish".
11. Now since the data is cleaned up, we can start using the various models and graphs.
12. Build the Term Document Matrix by using TermDocumentMatrix function
13. Sort by descending value of frequency
14. Display the top 10 most frequent words
15. Plotting the top 10 most frequent words using a bar chart
16. Generate a Word Cloud
17. Find Word associations between the top 3 used words and derive conclusions.
18. Find associations for words that occur at least 7000 times (The no of times may vary as per your data) and derive conclusions.
19. Perform Sentiment Analysis by using get_nrc_sentiment function.
20. Plotting the top 10 most sentiments using a bar chart.
21. The next steps are for Bigram Language Model
22. Convert the corpus into a data frame with the words inside
23. Creating bi-grams using the dataframe
24. Count the frequency of bigram
25. Separate the bigrams, so that it can print the relationships
26. Filter the bigrams and further remove the stopwords
27. Create new bigram count
28. Create a bigram graph
29. Generate a Word Cloud for the bigrams
    

