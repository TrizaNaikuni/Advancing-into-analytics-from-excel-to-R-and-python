install.packages('DAAG')
library(tidyverse)
library(tidymodels)

#load data set
library(readxl)
ais_2_ <- read_excel("ais (2).xlsx")

#view data
View(ais_2_)
head(ais_2_)

#1.Visualize the distribution of red blood cell count (rcc) by sex (sex).
# Load necessary library
library(ggplot2)

# Create a boxplot to visualize the distribution of rcc by sex
ggplot(data = ais_2_, aes(x = sex, y = rcc)) +
  geom_boxplot(fill = "skyblue", color = "black") +
  labs(x = "Sex", y = "Red Blood Cell Count (rcc)", title = "Distribution of RCC by Sex")


# 2.Perform a t-test to compare red blood cell count (rcc) between the two groups of sex
t_test_result <- t.test(rcc ~ sex, data = ais_2_)

# Print the t-test result
print(t_test_result)

#3. a correlation matrix of the relevant variables
ais_2_ %>% 
  select(-c(sex, sport)) %>% 
  cor()

ais_2_  %>% 
  select(-c(sex, sport)) %>% 
  pairs()

#4.Visualize the relationship of height (ht) and weight (wt).

# Load necessary library
library(ggplot2)

# Create a scatter plot to visualize the relationship between height and weight
ggplot(data = ais_2_, aes(x = ht, y = wt)) +
  geom_point(color = "blue") +
  labs(x = "Height (ht)", y = "Weight (wt)", title = "Relationship between Height and Weight")

#5.

# Fit a linear regression model of height on weight
lm_model <- lm(ht ~ wt, data = ais_2_)

# Get the summary of the regression model
summary(lm_model)

# Print the equation of the fitted regression line
coefficients <- coef(lm_model)
intercept <- coefficients[1]
slope <- coefficients[2]
cat("Equation of the fitted regression line: ht = ", intercept, " + ", slope, " * wt\n")

# Yes there is a significant influence. 
# height = 139.16 + .55 * weight
# About 61% of the variability in height is explained by weight.

#visualize the regression
ggplot(data = ais_2_, aes(x = wt, y = ht))+
  geom_point()+
  geom_smooth(method = lm)


#quesion 6

# Split the data into training and testing subsets (e.g., 80% training, 20% testing)
set.seed(123) # for reproducibility
n <- nrow(ais_2_)
train_index <- sample(1:n, 0.8 * n)
train_data <- ais_2_[train_index, ]
test_data <- ais_2_[-train_index, ]

# Fit a linear regression model on the training data
lm_model_train <- lm(ht ~ wt, data = train_data)

# Make predictions on the testing data
predictions <- predict(lm_model_train, newdata = test_data)

# Calculate R-squared on the testing data
r_squared <- cor(predictions, test_data$ht)^2

# Print R-squared
cat("R-squared on the test model:", r_squared, "\n")

# Calculate Root Mean Squared Error (RMSE)
rmse <- sqrt(mean((predictions - test_data$ht)^2))

# Print RMSE
cat("Root Mean Squared Error (RMSE) on the test model:", rmse, "\n")

