# Henrik Wejberg
# IODS data wrangling task 22.11.2022
# Reading logistic regression analysis


url <- "https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/"

# web address for math class data
url_math <- paste(url, "student-mat.csv", sep = "/")

# print out the address
url_math

# read the math class questionnaire data into memory
math <- read.table(url_math, sep = ";" , header = TRUE)

# web address for Portuguese class data
url_por <- paste(url, "student-por.csv", sep = "/")

# print out the address
url_por

# read the Portuguese class questionnaire data into memory
por <- read.table(url_por, sep = ";", header = TRUE)

# look at the column names of both data sets
colnames(math); colnames(por)

# access the dplyr package
library(dplyr)

# give the columns that vary in the two data sets
free_cols <- c("failures", "paid", "absences", "G1", "G2", "G3")

# the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(por), free_cols)

# join the two data sets by the selected identifiers
math_por <- inner_join(math, por, by = join_cols)

# look at the column names of the joined data set
colnames(math_por)

# glimpse at the joined data set
glimpse(math_por)

# print out the column names of 'math_por'
print(colnames(math_por))

# create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols))

# print out the columns not used for joining (those that varied in the two data sets)
print(free_cols)

# for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col[[1]]
  }
}

# glimpse at the new combined data
glimpse(alc)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

alc <- mutate(alc, high_use = alc_use > 2)

# I did this really quick. Please give points. 