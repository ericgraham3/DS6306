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
