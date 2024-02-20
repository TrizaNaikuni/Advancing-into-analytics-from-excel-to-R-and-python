#loading neccesary libraries

library('tidyverse')
library('psych')
install.packages('tidymodels')
library('tidymodels')

#read in the data and select the needed columns

mpg<-read.csv('mpg.csv') %>% 
  select(mpg,weight,horsepower,origin,cylinders)
head(mpg)
tail(mpg)

#descriptive statistics
describe(mpg)

#one way frequency table for origin
mpg %>% 
  count(origin)

mpg %>%
  count(origin, cylinders) %>%
  pivot_wider(values_from = n, names_from = cylinders)

#descriptive statistics for each level of origin

mpg %>%
  select(mpg, origin) %>%
  describeBy(group = 'origin')

#potential relationship between origin and mpg using histogram

library(ggplot2)

ggplot(data = mpg, aes(x = mpg)) +
  geom_histogram(fill = "yellow", color = "black",binwidth = 2) +
  labs(title = "Distribution of MPG", x = "MPG", y = "Frequency")

#boxplot 
ggplot(data = mpg, aes(x = origin, y = mpg)) +
  geom_boxplot()

library(ggplot2)

ggplot(data = mpg, aes(x = origin, y = mpg, fill = origin)) +
  geom_boxplot() +
  labs(title = "MPG by Origin", x = "Origin", y = "MPG") +
  scale_fill_manual(values = c("Asia" = "blue", "Europe" = "green", "USA" = "red")) # Customize fill colors as needed

# Histogram of mpg, facted by origin
ggplot(data = mpg, aes(x = mpg)) +
  geom_histogram() +
  facet_grid(~ origin)

library(ggplot2)

ggplot(data = mpg, aes(x = mpg, fill = origin)) +
  geom_histogram(color = "black", bins = 20) + # Adjust the number of bins as needed
  facet_grid(~ origin) +
  labs(title = "Histogram of MPG, Faceted by Origin", x = "MPG", y = "Frequency") +
  scale_fill_manual(values = c("blue", "green", "red")) # Set fill colors manually

#new data frame
mpg_filtered <- filter(mpg, origin=='USA' | origin=='Europe')

# Dependent variable ~ ("by") independent variable
t.test(mpg ~ origin, data = mpg_filtered)

#relationship between continous variables
select(mpg, mpg:horsepower) %>%
  cor()

#the relationship between weight and mileage
ggplot(data = mpg, aes(x = weight,y = mpg)) +
  geom_point() + xlab('weight (pounds)') +
  ylab('mileage (mpg)') + ggtitle('Relationship between weight and mileage')

#to add colour 
library(ggplot2)

ggplot(data = mpg, aes(x = weight, y = mpg, color = factor(cylinders))) +
  geom_point() +
  xlab('weight (pounds)') +
  ylab('mileage (mpg)') +
  ggtitle('Relationship between weight and mileage') +
  scale_color_manual(values = c("blue", "green", "red", "orange", "purple")) # Set color palette manually

#pairplot
select(mpg, mpg:horsepower) %>%
  pairs()
#colour addition
install.packages('GGally')
library(GGally)

# Create a vector of colors corresponding to each variable
colors <- c("blue", "green", "red", "orange", "purple", "yellow", "cyan", "magenta")

# Create the pairs plot and specify the color vector
select(mpg, mpg:horsepower) %>%
  pairs(col = colors)


#linear regression
mpg_regression <- lm(mpg ~ weight, data = mpg)
summary(mpg_regression)

# Scatterplot with regression line of weight by mpg

ggplot(data = mpg, aes(x = weight, y = mpg)) +
  geom_point() + xlab('weight (pounds)') +
  ylab('mileage (mpg)') + ggtitle('Relationship between weight and mileage') +
  geom_smooth(method = lm)

set.seed(1234)
mpg_split <- initial_split(mpg)
mpg_train <- training(mpg_split)
mpg_test <- testing(mpg_split)
dim(mpg_train)
dim(mpg_test)


# Specify what kind of model this is
lm_spec <- linear_reg()
# Fit the model to the data
lm_fit <- lm_spec %>%
  fit(mpg ~ weight, data = mpg_train)
#> Warning message:
#> Engine set to `lm`.
tidy(lm_fit)

glance(lm_fit)

mpg_results <- predict(lm_fit, new_data = mpg_test) %>%
  bind_cols(mpg_test)
mpg_results
rsq(data = mpg_results, truth = mpg, estimate = .pred)
rmse(data = mpg_results, truth = mpg, estimate = .pred)
