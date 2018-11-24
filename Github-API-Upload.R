#install.packages("jsonlite")
#install.packages("httpuv")
#install.packages("httr")

library(httr)
library(jsonlite)
library(httpuv)


# Can be github, linkedin etc depending on application
oauth_endpoints("github")

# Change based on what your application is 
myapp <- oauth_app(appname = "ENIRIAIN",
                   key = "c7975910b48c64d5f772",
                   secret = "74639c3cefa0ee46c2582b4ce2c7b888d6c9ed41")

# Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

# Take action on http error
stop_for_status(req)

# Extract content from a request
json1 = content(req)

# Convert to a data.frame
gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))

# Subset data.frame
gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"]

# The code above was sourced from Michael Galarnyk's blog, found at:
# https://towardsdatascience.com/accessing-data-from-github-api-using-r-3633fb62cb08

----------------------------------------------------------------------------------------
# STEP 1: Interrogating the GitHub API.  

myData <- fromJSON("https://api.github.com/users/eniriain")
myData$followers #How many followers I have 
myData$public_repos #number of public repositories I have 

#The next part is to get details about my followers

myFollowers <- fromJSON("https://api.github.com/users/eniriain/followers")
myFollowers$login #the usernames of all users who follow me
length <- length(myFollowers$login) #the number of people who follow me
length

#Information on repositories 

repositories <- fromJSON("https://api.github.com/users/eniriain/repos")
repositories$name #the names of my public repositories
repositories$created_at #when these repositories were created
CS3012 <- fromJSON("https://api.github.com/repos/eniriain/CS3012/commits")
CS3012$commit$message #the comment in each commit to my CS3012 repository


#Looking at other users information 

newmanci <- fromJSON("https://api.github.com/users/newmanci/following")
newmanci$login

#Instead of viewing this information in a dataframe, i can convert it back to a
#JSon and study it this way, as it is viewed in a browser.

myDataJSon <- toJSON(myData, pretty = TRUE)
myDataJSon

---------------------------------------------------------------------------------------------

#Step 2: Processing the data from Github
  
#I am going to gather information about the number of followers my followers have

followersNames <- fromJSON("https://api.github.com/users/eniriain/followers")
followersNames$login #shown previously, gets the user names of my followers

a <- "https://api.github.com/users/"
b <- followersNames$login[4]
b
c <- "/followers"

test <- sprintf("%s%s%s", a,b,c) #this method amalgamates a, b and c into one string 
test                              #called test 


#I now have access to toconno5's followers
#If I wanted access to juliaellen's followers, I woiuld change b to b <- followersNames$login[2] 
#as she is second in the list.

#Step 2:

numberOfFollowers <- c() #this creates an empty vector
namesOfFollowers <- c()
for (i in 1:length(followersNames$login)) {
  followers <- followersNames$login[i] #loops through each of my followers, indexed by i
  jsonLink <- sprintf("%s%s%s", a, followers, c) #creates link for my ith follower
  followData <- fromJSON(jsonLink) #stores the followers of my ith follower
  numberOfFollowers[i] = length(followData$login) #amount of followers the ith follower has
  namesOfFollowers[i] = followers #names of all users following the ith follower
  
}
numberOfFollowers
namesOfFollowers
finalData <- data.frame(numberOfFollowers, namesOfFollowers) #stores two vectors as one
#data frame
finalData$namesOfFollowers
finalData$numberOfFollowers


#Step3: Visualize the processed data from Github

install.packages("devtools")
install.packages("Rcpp")
library(devtools)
library(Rcpp)
install_github('ramnathv/rCharts', force= TRUE)
require(rCharts)

myPlot <- nPlot(numberOfFollowers ~ namesOfFollowers, data = finalData, type = "multiBarChart")
myPlot

myPlot$save("myplot.html") #this saves a html file of the plot to my documents. 

#the graph shows that kennyc11 and toconno5 have the most followers out of 
#my followers i.e. they are the most influential developers following me