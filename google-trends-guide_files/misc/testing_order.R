library(tidyverse)
library(gtrendsR)
search_terms <- c("juice laundry", '"the juice laundry"', "zefferus")
x <- gtrends(search_terms, geo = "US", time = "2016-10-09 2018-12-31")
x[["interest_over_time"]]

gtrends <- x[["interest_over_time"]] %>% 
  as_tibble() %>% 
  rename('relative_interest' = 'hits', 
         'week_of' = 'date', 
         'search_term' = 'keyword') %>% 
  select(c('week_of', 'search_term', 'relative_interest'))

gtrends$week_of <- as.Date(gtrends$week_of) # Rather than datetime default
gtrends$relative_interest <- as.double(gtrends$relative_interest) # Not Int
gtrends[gtrends$search_term == URLdecode(topic_url), "search_term"] <- "TJL Topic"

lg <- ggplot(
  gtrends, aes(x = week_of, y = relative_interest, color = search_term)
) + 
  geom_line() + 
  labs(x = 'Month', 
       y = 'Relative Interest', 
       color = 'Search Term', 
       title = "Interest over Time",
       caption = "https://goo.gl/XV8kHd")

lg
