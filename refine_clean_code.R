# Neat version
library(dplyr)
library(tidyr)

#load data
toy_data <- read.csv("~/Documents/springboarddatawrangle/refine_original.csv", row.names = NULL, header = T)

#Create corpus of mistakes - pretty much achieved through inspection (however not necessary for cleaning data)
corpus <- toy_data2$company
philips_corpus <- corpus[1:6]
akzo_corpus <- corpus[7:13]
vanhouten_corpus <- corpus[17]
unilever_corpus <- corpus[22:23]

# lower-case
toy_data2 <- mutate(toy_data, company = tolower(company))

# Change spelling 
toy_data2[grep("phillips|phillips|phllips|phillps|phillips|fillips|phlips", toy_data2$company), "company"] <- "philips"
toy_data2[grep("akz0|ak zo", toy_data$company), "company"] <- "akzo"
toy_data2[grep("unilver", toy_data$company), "company"] <- "unilever"

# Seperate 
toy_data3 <- toy_data2 %>%
  separate(Product.code...number, c("product.code","number"), sep = "-")


# Create a new column containing the product catagory
toy_data4 <- mutate(toy_data3, product.type = 
  ifelse (grepl("p", product.code),"Smartphone",
  ifelse (grepl("v", product.code), "TV",
  ifelse (grepl("x", product.code), "Laptop",
  ifelse (grepl("q", product.code), "Tablet", "NA"
)))))

# Concatonate address details
toy_data5 <- mutate(toy_data4, full_address =
                      paste(address, city, country, sep = ", "))

# Create dummy variables for each company.
toy_data6 <- mutate(toy_data5, company_philips =
                      ifelse(grepl("philips", company), 1, 0))
toy_data7 <- mutate(toy_data6, company_akzo =
                      ifelse(grepl("akzo", company), 1, 0))
toy_data8 <- mutate(toy_data7, company_van_houten =
                      ifelse(grepl("van houten", company), 1, 0))
toy_data9 <- mutate(toy_data8, company_unilever =
                      ifelse(grepl("unilever", company), 1, 0))
                    
# Save to csv
write.csv(toy_data9, "refine_clean.csv")

                    
                    
                    
                    