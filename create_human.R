# Henrik Wejberg
# Open data science
# 5.12.2022

human <- read.csv("data/human1.txt")

library(dplyr)

# This is a data about countries and their measured indicators for human development. You can find more about the variables from here:https://hdr.undp.org/system/files/documents//technical-notes-calculating-human-development-indices.pdf
str(human)
summary(human)

# There is 195 obs and 19 variables. We will first turn GNI as numeric, since R reads it as a character
human$GNI <- gsub(",", "", human$GNI) |> as.numeric()

# We select only relevant variables for our future analysis
human <- select(human, "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# filter out all rows with NA values
human <- filter(human, complete.cases(human) == TRUE)

# lets take the last 7 observations away so there is no more regions in the data, only countries.
last <- nrow(human) - 7

# choose everything until the last 7 observations
human <- human[1:last, ]

# I name every row with the country it is associated and remove country row
rownames(human) <- human$Country

# remove the Country variable
human <- dplyr::select(human, -Country)

# Lets check that we have only 8 variables and 155 rows
dim(human)

# I write this data to human.csv so it is in the right folder right away
write.csv(human, file = "data/human.csv", row.names = TRUE)

