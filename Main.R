# clear environment
# it's always a good idea to start fresh with no variables loaded in the R environment
rm(list = ls())


# define the default directory
# it saves you the trouble of having to specify the full path every time you need to load or save a file
# (change the path below to where you have downloaded the covid dataset)

setwd("/Users/cedric/Desktop/Spring2021/INFO371/Group_Project")

#required libraries - makes life easier than vanilla R
library(readr)
library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)

# load Bitcoin tweets data set
df_tweets <- read_csv("Bitcoin_tweets.csv")

# load Dogecoin info data set
df_doge <- read_csv("DOGE-USD.csv")

#convert from UNIX timestamp format to yyyy-mm-dd to match df_doge dataset
df_tweets$date <- as.Date(df_tweets$date)

#confirm
df_tweets$date

# rename date from uppercase to lower in df_doge
df_doge <- df_doge %>% rename(date = Date)

# merge dataframes

doge_and_tweets <- merge(df_tweets,df_doge,by="date")

# part 2: start to perform EDA


# new DF containing summarized date and frequency of crypto tweets
doge_and_tweets_result <- doge_and_tweets %>% group_by(date) %>% summarise(frequency = n())


ggplot(data = doge_and_tweets_result, aes(x=date, y=frequency)) + geom_line(na.rm = TRUE)