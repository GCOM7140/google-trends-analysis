library(tidyverse)

gtrends_url <- function(start_date, end_date, geo, search_terms) {
  "%20" <- 
    
    
    
    
    
    
    
    
    
    
    
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  search_terms[find(" ")]
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

gtrends_url("August 9, 2016", "2018-12-31", "US", c("The Juice Laundry", 
                                            "%22juice laundry%22"))
