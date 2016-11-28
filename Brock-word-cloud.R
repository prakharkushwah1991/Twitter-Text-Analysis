#TWITTER ANAYSIS WITH R

#GOLDBERG VS BROCK LESNAR SURVIVOR SERIES 2016.

install.packages("devtools")
install.packages("httr")
install.packages("twitteR")
install.packages("plyr")
install.packages("rjson")
install.packages("bit64")
install.packages("SnowballC")

library(devtools)
library(httr)
library(twitteR)
library(plyr)
library(rjson)
library(bit64)
library(SnowballC)

#SESSION INFO()
api_key<- "cQmuQJirl1A2pgBeSIwUx2K2R"
api_secret<-"KouK1rifQEryHGP5ei2oWuHbF4J1EaVanKviqE3iBpTF08JlYl"  
access_token<- "3987613513-POLVjA3xmRpp7pcTVP0jG7VZn8a4E7wc2DI1wqg"
access_token_secret<- "J19joSGpvZCOkNAsMxYH0mJjlYRbWO4I4Gq2DAUJgisZf"

setup_twitter_oauth(api_key,api_secret,access_token,access_token_secret)

tweets<-searchTwitter('#GoldbergVsLesnar',n=1000,since = "2016-11-15",lang = "en")

head(tweets)
class(tweets)

tweets_df<-twListToDF(tweets)

tweets.text<-lapply(tweets, function(t)t$getText())

class((tweets.text))

head(tweets.text)

install.packages("tm")

library(tm)

mycorpus<-Corpus(VectorSource(tweets.text))
x<-as.character(mycorpus)
str(mycorpus)

#DATA CLEANING,REMOVING WHITESPACES,STOPWORDS,PUNCTUATION,NUMBERS,PLAIN TEXT DOCUMENT ALSO LOWER CASE

mycorpus1<-tm_map(mycorpus,stripWhitespace)
mycorpus2<-tm_map(mycorpus1,tolower)
mycorpus3<-tm_map(mycorpus2,removeWords,stopwords("english"))
mycorpus4<-tm_map(mycorpus3,removePunctuation)
mycorpus5<-tm_map(mycorpus4,removeNumbers)
mycorpus6<-tm_map(mycorpus5,PlainTextDocument)

#CONVERTING THE CORPUS TO MATRICES
data_dtml<-DocumentTermMatrix(mycorpus6)

inspect(data_dtml)

frequest<-findFreqTerms(data_dtml,lowfreq = 100,highfreq = Inf)

frequest

install.packages("wordcloud",dependencies = TRUE)
install.packages("stringr",dependencies = TRUE)
install.packages("RColorBrewer")

library(wordcloud)
library(stringr)
library(RColorBrewer)

wordcloud(mycorpus6,max.words = 100,random.order = FALSE,colors = rainbow(50))


