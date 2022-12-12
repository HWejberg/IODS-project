# Open data science
# Henrik Wejberg
# 12.12.2022

#1. Load the data sets (BPRS and RATS) into R using as the source the GitHub repository of MABS, where they are given in the wide form:

# First I load the datasets in wide form 
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# In BPRS, there is 40 obs with 11 variables. In rats, 16 obs with 13 variables. 
# When the data is in wide form, it is easier to see how each subjects values have changed over time
# After analysing the data structure and summaries in wide form, I will change ID and treatment/group variable to factors.
str(BPRS)
str(RATS)

# In summaries, it is also easy to see how for example rat weights changed over the weeks. 
# Mean values get higher in the rats data set. This can be seen from the summary of wide data set.
summary(BPRS)
summary(RATS)

# Factorising important parts
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Change the data to long form in both datasets
BPRSL <-  pivot_longer(BPRS, cols=-c(treatment,subject),names_to = "weeks",values_to = "bprs") %>% arrange(weeks) %>% mutate(week = as.integer(substr(weeks,5,5)))
RATSL <- pivot_longer(RATS, cols=-c(ID,Group), names_to = "WD",values_to = "Weight")  %>%  mutate(Time = as.integer(substr(WD,3,4))) %>% arrange(Time)

# Lets analyse how the long form differs from wide
str(BPRSL)
str(RATSL)
# Now BPRSL has 360 observations with 5 variables. 
# Previously every week was it own variable that showed the bprs score for every subject
# Now week is one variable which shows the week that the measurement was taken. 
# bprs values were put to bprs variable. 
# Same with RATS data but put to different place

summary(BPRSL)
summary(RATSL)
# Now summary values are much less useful. 
# Only information that can be gathered compared to the previous form is the mean weight and bprs from the whole study time. 

# Lets write all the data to data folder
write.csv(BPRS, file = "data/BPRS", row.names = FALSE)
write.csv(BPRSL, file = "data/BPRSL", row.names = FALSE)
write.csv(RATS, file = "data/RATS", row.names = FALSE)
write.csv(RATSL, file = "data/RATSL", row.names = FALSE)

# Works correctly
read.csv("data/BPRS")
read.csv("data/BPRSL")
read.csv("data/RATS")
read.csv("data/RATSL")

