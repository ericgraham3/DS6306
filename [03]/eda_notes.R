library(ggplot2)

# categorical

totals = count(mpg, class)
mpg %>% 
  ggplot(aes(x = class, fill = class)) +
  geom_bar() +
  geom_text(aes(class, totals$n +2, label = totals$n, fill = NULL), data = totals)

# continuous

mpg %>% 
  ggplot(aes(y = cty, color = class)) +
  geom_boxplot()

# use diamonds data, includes good data dictionary

# center and spread as focuses of EDA

by_city = mpg %>% 
  group_by(class) %>% 
  summarize(mean = mean(cty), sd = sd(cty), median = median(cty), range = max(cty)-min(cty), IQR = IQR(cty), count = n())

df = data.frame(x = c(1,2,3,4), y =c(3,4,5,6), z = c(1,2,3,14))
df
sapply(df,function(x) mean(x))

# IMPORTANT: sapply in action
toy = read.csv("[03]/MissingDataToy.csv", header = TRUE)
sum_nulls = sapply(toy, function(x) sum(is.na(x)))
sum_nulls

# IMPORTANT: gg_miss_var

library(naniar)
gg_miss_var(toy)

fifa = read.csv("[03]/FIFA Players.csv")
gg_miss_var(fifa[,1:40]) + ylim(0, 75)

library(nycflights13)
gg_miss_var(flights)
sapply(flights, function(x) sum(is.na(x)))

library(dplyr)

gg_miss_var(diamonds)
new_diamonds = diamonds %>%
  mutate(z = ifelse(z == 0 | z > 20, NA, z))
gg_miss_var(new_diamonds)
sapply(new_diamonds, function(x) sum(is.na(x)))

diamonds %>% ggplot(aes(x = z)) +
  geom_boxplot()

diamond_count = diamonds %>% 
  filter(z > 4) %>% 
  summarize(count = n())
diamond_count

