# Henrik Wejberg
# 13.11.2022
# This is a script to download data required for completing open data science chapter 2
library(tidyverse)

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# The data is a data.frame.
class(lrn14)
# 60 variables and 183 rows. All other rows are integers except for gender variable.
str(lrn14)
# Dimension shows us the same thing that I wrote previously: 183 rows and 60 variables
dim(lrn14)

# Create the correct dataset. These scripts are from exercise 2. 

# First we do the scaling by dividing attitude by ten
lrn14$attitude <- lrn14$Attitude / 10
# Combine deep_quesions as one character vector
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
# Calculate a new row that is the mean of the values in deep_questions
lrn14$deep <- rowMeans(lrn14[, deep_questions])
# Similar scipts but different questions
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])

# We create a new data frame with the columns that we want
learning2014 <- lrn14[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]
# Rename couple columns
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"
# Filter those observations where the student scored atleast something in the exam 
learning2014 <- filter(learning2014, points > 0)

# Working directory is not data folder, which we want
getwd()
# This sets the correct working directory
setwd("C:/Users/henri/OneDrive/Documents/PHD-302 Introduction to Open Data Science 2022/IODS-project/data")

# This writes the correct data to correct folder. Remember to add row.names = FALSE, otherwise there will be an unnecessary column.
write.csv(learning2014, file = "learning2014.csv", row.names = FALSE)

# Data is readable and has the same structure and dimensions as before writing.
read.csv("learning2014.csv")
learning2014 <- read.csv("learning2014.csv")
str(learning2014)
dim(learning2014)


