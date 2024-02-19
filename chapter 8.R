library(tidyverse)
library(readxl)
star <- read_excel("star.xlsx")
View(star)
head(star)


#data manipulation
select(star, tmathssk, treadssk, schidkn)
#dropping columns
select(star, -tmathssk, -treadssk, -schidkn)
select(star, -c(tmathssk, treadssk, schidkn))

star <- select(star, tmathssk:totexpk)
head(star)
#add new column
star <- mutate(star, new_column = tmathssk + treadssk)
head(star)

#rename new column
star <- rename(star, ttl_score = new_column)
head(star)

arrange(star, classk, treadssk)
# Sort by classk descending, treadssk ascending
arrange(star, desc(classk), treadssk)

filter(star, classk == 'small.class')
filter(star, treadssk >= 500)


# Get records where classk is small.class and
# treadssk is at least 500
filter(star, classk == 'small.class' & treadssk >= 500)

star_grouped <- group_by(star, classk)
head(star_grouped)

summarize(star_grouped, avg_math = mean(tmathssk))


star library(readxl)
star <- read_excel("star.xlsx")
head(star)
districts <- read_csv('districts.csv')
head(districts)

# Left outer join star on districts
left_join(select(star, schidkn, tmathssk, treadssk), districts)

star_grouped <- group_by(star, classk)
star_avg_reading <- summarize(star_grouped, avg_reading = mean(treadssk))
#> `summarise()` ungrouping output (override with `.groups` argument)
#>
star_avg_reading_sorted <- arrange(star_avg_reading, desc(avg_reading))
star_avg_reading_sorted

#or
star %>%
  group_by(classk) %>%
  summarise(avg_reading = mean(treadssk)) %>%
  arrange(desc(avg_reading))

# Average math and reading score
# for each school district
star %>%
  group_by(schidkn) %>%
  summarise(avg_read = mean(treadssk), avg_math = mean(tmathssk)) %>%
  arrange(schidkn) %>%
  head()

star_pivot <- star %>%
  select(c(schidkn, treadssk, tmathssk)) %>%
  mutate(id = row_number())

star_long <- star_pivot %>%
  pivot_longer(cols = c(tmathssk, treadssk),
               values_to = 'score', names_to = 'test_type')
head(star_long)

star_long <- star_long %>%
  mutate(test_type = recode(test_type,
                            'tmathssk' = 'math', 'treadssk' = 'reading'))
distinct(star_long, test_type)


star_wide <- star_long %>%
  pivot_wider(values_from = 'score', names_from = 'test_type')
head(star_wide)


ggplot(data = star,
       aes(x = classk)) +
  geom_bar()

ggplot(data = star, aes(x = treadssk)) +
  geom_histogram()


ggplot(data = star, aes(x = treadssk)) +
  geom_histogram(bins = 25, fill = 'blue')

ggplot(data = star, aes(x = treadssk)) +
  geom_boxplot()

ggplot(data = star, aes(y = treadssk)) +
  geom_boxplot()

ggplot(data = star, aes(x = classk, y = treadssk)) +
  geom_boxplot()

ggplot(data = star, aes(x = tmathssk, y = treadssk)) +
  geom_point()


ggplot(data = star, aes(x = tmathssk, y = treadssk)) +
  geom_point() +
  xlab('Math score') + ylab('Reading score') +
  ggtitle('Math score versus reading score')
