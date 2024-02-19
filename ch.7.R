#read csv file
read.csv('districts.csv')

#>--column specification
#> cols(
#> schidkn = col_double(),
#> school_name = col_character(),
#> county = col_character()
#> )
#>
#> # A tibble: 89 x 3



#read excel file
library(readxl)
star <- read_excel("star.xlsx", col_types = c("numeric", 
                                              "numeric", "text", "numeric", "text", 
                                              "text", "text", "numeric"))
View(star)
head(star)
tail(star)
glimpse(star)
summary(star)

#load neccesary libraries
library(dplyr)
library(psych)

#descriptive statistics
describe(star)
