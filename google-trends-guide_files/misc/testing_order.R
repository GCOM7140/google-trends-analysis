library(tidyverse)
library(gtrendsR)
search_terms <- c("juice laundry", '"the juice laundry"', "z")
gtrends(search_terms, geo = "US", time = "2016-10-09 2018-12-31")
