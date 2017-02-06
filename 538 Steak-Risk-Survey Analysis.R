setwd("\\\\net.ucf.edu\\ikm\\Home\\ja041718\\Documents\\")
survey = read.csv(file = "steak-risk-survey.csv", header=T, sep=",")

#rename columns
colnames(survey) = c("ID", "lottery", "smoke", "drink", "gamble", "skydiving", "speedlimit", "cheat.so", 
                     "eat.steak", "steak.prep", "gender", "age", "income", "education", "region") 

#first 2 responders have no data, so let's remove it
survey = survey[-c(1:2),]

# Unanswered questions are written as spaces. It will look better for visualization to write "no response".
# Let's change all the spaces to "no response".
change.to = "No Response"

for(y in 2:ncol(survey)){
  
    # need to defactor the columns to add a new factor
    survey[,y] = as.character(survey[,y])
    
    #subset rows where there is a space for the value
    remove = survey[,y] == ""
    
    # change the spaces to new label
    survey[remove,y] = change.to
    
    #re-factor the column
    survey[,y] = as.factor(survey[,y])
  
}


library(ggplot2)

# Does gender or income play a factor on cheating?
ggplot(survey, aes(x=cheat.so, fill=gender)) + geom_bar(position="dodge") +
  facet_wrap(~income) 
