library(testthat)
library(RosatoWorldPopulation)
library(stringr)
library(tidyverse)

test_that('Country name exist in cleaned data', {

  expect_error(CountryPopulation('Wakanda'))

  expect_error(CountryPopulation('Fantasy Land'))

  expect_silent(CountryPopulation('Belize'))
})
