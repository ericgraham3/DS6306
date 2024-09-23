library(stringr)
library(ggplot2)
library(maps)
library(mapproj)
library(dplyr)
library(tidyverse)

acu = read.csv("[05]/Acuspike Customer Data.csv")
lookup = data.frame(abb = state.abb, State = state.name)
colnames(acu)[2] = "abb"
acu2 = merge(acu, lookup, "abb")
acu_map_data = count(acu2, State)
colnames(acu_map_data)[2] = "acu_spikes"
acu_map_data$region = tolower(acu_map_data$State)
acu_map_data2 = acu_map_data[-1]
states = map_data("state")
map.df = merge(states, acu_map_data2, by="region", all.x=T)
map.df = map.df[order(map.df$order),]
ggplot(map.df, aes(x=long, y=lat,group=group)) +
  geom_polygon((aes(fill=acu_spikes)))+
  geom_path()+
  scale_fill_gradientn(colors = rev(heat.colors(10)),na.value="grey90")+
  ggtitle("Acuspike Systems by State") +
  coord_map()

string1 = c("combine", "three", "strings")
string1
str_c(string1, collapse = " ")
str_sub(string1, 1, 2)

MSDS = c("M", "S", "D", "S")
str_c(MSDS, collapse="")
# quiz marked this as wrong?

str_view(string1, "three")
str_view_all(string1, "three")


colors = c("orange","blue","yellow","green","purple","brown","red")

color_expression = str_c(colors, collapse = "|")

color_expression

has_color = str_subset(sentences,color_expression)

has_color
