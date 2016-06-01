# load titanic data
titanic <- read.xls("~/Downloads/titanic_original.csv", header = T)
install.packages("gdata")
library(gdata)
library(dplyr)
library(tidyr)

# missing "embark" values
titanic$embarked[titanic$embarked == ""] <- "S"

# add missing age values as mean
titanic$age[is.na(titanic$age)] <- mean(titanic$age, na.rm = TRUE)

# add missing values to lifeboat number
factor(titanic$boat, exclude = NULL)
titanic$boat[titanic$boat == "" ] <- NA

# add cabin number dummy variable
titanic <- mutate(titanic, has_cabin_number = 
                    ifelse(grepl(" ", cabin), 0, 1))
