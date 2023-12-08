library(tidyverse)
library(readxl)
library(rvest)

url = 'https://en.wikipedia.org/wiki/FIFA_World_Cup'

page <- read_html(url)

attendanceTable <- page %>% html_nodes('table') %>% .[[4]] %>%
  html_table(header=FALSE, fill=TRUE) %>% slice(-1 * 1:2)

World_Cup <- attendanceTable %>%  select(X1, X2, X4, X5, X6) %>%
  mutate(Matches = X5, Totalattendance = X4) %>%
  select(X1, X2, Matches, Totalattendance, X6) %>%
  magrittr::set_colnames(c('Year', 'Hosts',
                           'Matches','Totalattendance', 'Averageattendance')) %>%
  mutate(Totalattendance = str_replace_all(Totalattendance, ",", ""),
         Averageattendance = str_replace_all(Averageattendance, ",", "")) %>%
  mutate(Totalattendance = as.numeric(Totalattendance)) %>%
  mutate(Averageattendance = as.numeric(Averageattendance)) %>%
  slice(1:(n() - 4))

World_Cup <- World_Cup %>%  mutate(WorldCup = paste0(Hosts, Year)) %>%
  mutate(WorldCup = str_replace_all(WorldCup, " ", "")) %>%
  select(-Hosts, -Year) %>%  select(WorldCup, everything())

# Save the data frame to the data/ directory as .rda
usethis::use_data(World_Cup, overwrite = TRUE)
