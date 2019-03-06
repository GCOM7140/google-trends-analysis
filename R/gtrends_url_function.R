library(tidyverse)

gtrends_url <- function(start_date, end_date, geo, search_terms) {
  str_c(
    "https://trends.google.com/trends/explore?date=",
    start_date,
    "%20",
    end_date,
    "&geo=",
    geo,
    "&q=",
    search_terms[1],
    ",",
    search_terms[2])
  }

gtrends_url("2016-10-09", "2018-12-31", "US", c("The%20Juice%20Laundry", 
                                            "%22juice%20laundry%22"))
