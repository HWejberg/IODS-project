# Henrik Wejberg
# Open data science 

hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

str(hd)
str(gii)

summary(hd)
summary(gii)

# Didn't have time to do rename 
rename(hd, "Country name" = "Country", "GNI" = "Gross National Income (GNI) per capita") 

gii <- gii %>% mutate("edu2F/edu2M" =`Population with Secondary Education (Female)`/`Population with Secondary Education (Male)`, 
                      "labF / labM" = `Labour Force Participation Rate (Female)` / `Labour Force Participation Rate (Male)`)

human <- inner_join(hd, gii, by = c("Country"))
