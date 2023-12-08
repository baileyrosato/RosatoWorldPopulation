#' A function that takes in the name of a country in the form of a string and
#' returns the a graph that displays the population from the years 1950 - 2020.
#'
#'@param country_name A string of the country name.
#'
#'@return A graph that displays the country's population data from 1950 - 2020.
#'@export


CountryPopulation <- function(country_name) {

  if (!any(grepl(country_name, WorldPopulation$`Country Name`,
                                                        ignore.case = TRUE))) {
    stop("Error, country populations not recorded.")
  }

  LongWorldPopulation <- WorldPopulation %>%
    pivot_longer(cols = -`Country Name`, names_to = "Year",
                 values_to = "Population") %>%
    mutate(Year = as.numeric(Year))

  FilteredData <- LongWorldPopulation %>%
    filter(`Country Name` == country_name)

  CountryGraph <- ggplot(FilteredData, aes(x = Year, y = Population)) +
    geom_point() +
    labs(title = paste("Population from 1950 to 2020 - ",
                       country_name),
         x = "Year",
         y = "Population")

  return(CountryGraph)
}

"CountryPopulation"
