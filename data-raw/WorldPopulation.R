library(tidyverse)
library(readxl)

WorldPopulation <- read_excel('data-raw/World_Population.xlsx',
                                                sheet="ESTIMATES", skip=16) %>%
                   select(-`Index`, -`Variant`, -`Notes`,
                                      -`Country code`, -`Parent code`) %>%
  filter(Type == "Country/Area") %>% select(-`Type`) %>%
  mutate(`Country Name` =`Region, subregion, country or area *`) %>%
  select(-`Region, subregion, country or area *`) %>%
  select(`Country Name`, everything()) %>%
  mutate_at(vars(-`Country Name`), as.numeric)

# Save the data frame to the data/ directory as .rda
usethis::use_data(WorldPopulation, overwrite = TRUE)
