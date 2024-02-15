1+2
3+5-4
?sqrt
require(stats) # for spline
require(graphics)
xx <- -9:9
plot(xx, sqrt(abs(xx)),  col = "red")
lines(spline(xx, sqrt(abs(xx)), n=101), col = "pink")
# This comment is preferred
2 * 1
3>4
4>3
# Assigning an object in R
my_first_object = abs(-100)
# Printing an object in R
my_first_object
my_second_object <- sqrt(abs(-5 ^ 2))
my_char <-'Hello world'
my_other_char <-"we are able to code in R"
my_number<-"3"
my_other_number<-"2"
my_inte<-12L
my_logical<-FALSE
str(my_char)
#> chr "Hello, world"
str(my_number)
#> num 3
str(my_inte)
#> int 12
str(my_logical)
#> logi FALSE


# Is my_number equal to 5.5?
my_number == 5.5
#> [1] FALSE
# Number of characters in my_char
nchar(my_char)
#> [1] 12


install.packages()
install.packages('tidyverse')
?arrange



# Call the tidyverse into our session
library(tidyverse)
#> -- Attaching packages -------------------------- tidyverse 1.3.0 --
#> v ggplot2 3.3.2 v purrr 0.3.4
#> v tibble 3.0.3 v dplyr 1.0.2
#> v tidyr 1.1.2 v stringr 1.4.0
#> v readr 1.3.1 v forcats 0.5.0
#> -- Conflicts ------------------------------ tidyverse_conflicts() --
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag() masks stats::lag()
?arrange
??arrange
