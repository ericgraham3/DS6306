test_var <- 12
test_var
library(tidyverse)
install.packages("nycflights13")
library(nycflights13)
flights

# filter
jan1 = filter(flights, month == 1, day == 1)
jan1

df = tibble(x = c(1, NA, 3))
filter(df, is.na(x) | x > 1)

late = filter(flights, arr_delay > 2)
late

iah_or_hou = filter(flights, dest == "IAH" | dest == "HOU")
iah_or_hou

?between
redeye = filter(flights, between(dep_time, 0, 600))
redeye

# arrange

sorted = arrange(flights, year, month, day)
sorted

sorted2 = arrange(flights, desc(month), desc(day))
sorted2

sorted3 = arrange(flights, desc(month), day)
sorted3

# select

selected = select(flights, year:day)
selected
selected2 = select(flights, carrier, month)
selected2

# mutate
flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time
)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60
)

# refer to var you just created in same statement

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)

# transmute to only keep new vars

transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

# summarize() and group_by()

by_dest = group_by(flights, dest)
delay = summarize(by_dest,
                  count = n(),
                  dist = mean(distance, na.rm = TRUE),
                  delay = mean(arr_delay, na.rm = TRUE)
)

delay = filter(delay, count > 20, dest != "HNL")
delay

# lectures

library(ggplot2)
library(dplyr)
mpg %>% filter(class == "compact")
mpg %>% arrange(manufacturer, cty) %>% print(n = 30)

library(GGally)
mpg %>% select(class, cty, hwy) %>% ggpairs(aes(color = class))

fifa = read.csv("[03]/FIFA Players.csv")
fifa %>% filter(Preferred.Foot == "Right" | Preferred.Foot == "Left") %>% 
  select(Finishing, BallControl, ShotPower, Preferred.Foot) %>%
  ggpairs(aes(color = Preferred.Foot))

mpg_diff = mpg %>% mutate(diff_hc = hwy - cty)
print(mpg_diff)

mpg %>% mutate(diff_hc = hwy - cty) %>% 
  ggplot(aes(x=displ, y = diff_hc, shape = manufacturer)) +
  geom_point()

mpg %>% group_by(class, year) %>% summarize(meanCTY = mean(cty), count = n())

fifa %>% group_by(Position) %>% 
  filter(!is.na(BallControl)) %>% 
  summarize(mean_bc = mean(BallControl), count = n()) %>% 
  ggplot(aes(x = Position, y = mean_bc)) + 
  geom_col()

library(tidyverse)

df = data.frame(Name = c("Jack","Julie","Cali","Sunny","James"), Age = c(3,4,2,1,5), Height = c(23,25,30,29,24), Gender = c("Male","Female","Female","Female","Male"))
df %>% group_by(Gender) %>% summarize(MeanHeight = mean(Height))

# factors

#Dataframe for the Example
age = c(22,21,NA,24,19,20,23)
yrs_math_ed = c(4,5,NA,2,5,3,5)
names = c("Mary","Martha","Rosy","Kim","Kristen","Amy","Sam")
subject = c("English","Math",NA,"Sociology","Math","Music","Dance")
df = data.frame(Age = age, Years = yrs_math_ed,Name = names, Major = subject)
df
str(df)
# Names and Subjects are already factors.

mpg %>% ggplot(aes(x = hwy, y = cty, color = as.factor(cyl))) +
  geom_point()

cyl_fact = factor(mpg$cyl)
cyl_fact
levels(cyl_fact) = c("Four", "Five", "Six", "Eight")
cyl_fact

displ_factor = cut(mpg$displ, breaks = c(1,4,6,8), labels = c("Low", "Medium", "High"))
displ_factor
