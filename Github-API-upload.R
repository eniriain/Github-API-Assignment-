#install.packages("jsonlite")
library(jsonlite)
#install.packages("httpuv")
library(httpuv)
#install.packages("httr")
library(httr)

# Can be github, linkedin etc depending on application
oauth_endpoints("github")

# Change based on what you 
myapp <- oauth_app(appname = "ENIRIAIN",
                   key = "c7975910b48c64d5f772",
                   secret = "74639c3cefa0ee46c2582b4ce2c7b888d6c9ed41")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp) #run this line and connect them!!! 
1

# Use API
gtoken <- config(token = github_token)
#req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Take action on http error
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 

#The above code was sourced from Michael Galarnyk's blog post
#https://towardsdatascience.com/accessing-data-from-github-api-using-r-3633fb62cb08

#Step1: Interrogating the GitHub API.  


#Accessing user mbostocks following to get list of users 
mbostockData <- fromJSON("https://api.github.com/users/mbostock")
mbostockData$following #Number of users Mike Bostock is following 
mbostockData$followers #Number of users following Mike Bostocks page 
mbostockData$public_repos #Number of public repositories Mike Bostock has 


#To get specific details about mBostocks following  
FollowersData <- fromJSON("https://api.github.com/users/mbostock/followers")
FollowersData$login
length <- length(FollowersData$login) #the amount of people who follow me
length

#I can also use this method to look at my own followings usernames 
eniriain  <- fromJSON("https://api.github.com/users/eniriain/following")
eniriain$login

#
