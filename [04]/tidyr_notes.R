library(tidyr)
library(dplyr)
library(jsonlite)
library(ggplot2)
who

who1 = who %>% 
  gather(
    new_sp_m014:newrel_f65, key = "key",
    value = "cases",
    na.rm = TRUE
  )
who1

who2 = who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2

who3 = who2 %>% 
  separate(key, c("new", "type", "sexage", sep = "_"))
who3

who4 = who3 %>% 
  select(-new, -iso2, -iso3)

who5 = who4 %>% 
  separate(sexage, c("sex", "age"), sep = 1)
who5
# where did that underscore come from?

# json
test = jsonlite::fromJSON("[04]/64KB.json")
head(test)

test2 = jsonlite::fromJSON("[04]/1MB.json")
head(test2)
str(test2)
test2 %>% ggplot(aes(x = language)) +
  geom_histogram(stat = "count")
