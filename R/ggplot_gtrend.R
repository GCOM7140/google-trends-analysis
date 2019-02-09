# The objective is to replicate the two main visuals 
# that Google Trends supplies: the line and bar graph
# with multiple TJL search term variations provided

# Required Packages

library(tidyverse)
library(gtrendsR)

# Specify search terms and date (timeline of tjl 'Square' data) 
# Notice that quoting terms makes a difference
# Ex. The Juice Laundry vs. "The Juice Laundry"
# But capitalization would not make a difference
# Ex. the juice laundry vs. The Juice Laundry

search_terms <- c('The Juice Laundry', '"The Juice Laundry"', 'Juice Laundry', 
                  'juice laundry', '"Juice Laundry"')
time_span <- "2016-10-11 2018-12-31"

# run gtrends to obtain list of data frames -- takes a while

gtrends_list <- gtrends(keyword = search_terms, geo = "US", time = time_span,
                        gprop = "web")

# Create tidy table

gtrend <- gtrends_list[["interest_over_time"]] %>% 
  as_tibble() %>% 
  rename('relative_interest' = 'hits', 'week_of' = 'date', 
         'search_term' = 'keyword') %>% 
  select(c('week_of', 'search_term', 'relative_interest'))

# Replicate a neat google trend line graph
# Ignore abnormal date_label -- for some unknown reason, you need the
# first month twice
# I added a smooth line to summarize trends

ggplot(gtrend, aes(x = week_of, y = relative_interest, 
                   color = search_term)) + 
  geom_line() + 
  labs(title = 'Interest Over Time', x = 'Month', y = 'Relative Interest', 
       color = 'Search Term:') + 
  scale_x_datetime(date_breaks = '3 months', date_labels = c('Dec 2016', 'Dec 2016', 'Mar 2017', 'Jun 2017', 'Sep 2017', 'Dec 2017', 'Mar 2018', 'June 2018', 'Sep 2018', 'Dec 2018')) +
  geom_smooth(se = FALSE) +
  theme(legend.position = 'bottom', legend.direction = 'vertical') +
  guides(color = guide_legend(nrow = 2))

## Notice that the juice laundry line does not show
## because it is the same line as Juice Laundry

# Summarize the average interest and round to avoid a bunch of decimals

avg_trend <- gtrend %>% 
  group_by(search_term) %>% 
  summarise(round(mean(relative_interest))) %>% 
  rename('avg_interest' = 'round(mean(relative_interest))')

# Plot bar graph with stat = 'identity' to avoid a count (allowing y variable)
# Use geom_text to label interest over bars
# Notice that titles should state a conclusion

ggplot(avg_trend, aes(x = search_term, y = avg_interest)) + 
  geom_bar(stat = 'identity', 
           fill = c('red', 'blue', 'green', 'purple', 'yellow')) +
  geom_text(aes(label = avg_interest, vjust = -1)) +
  labs(title = 'The search term, juice laundry (Juice Laundry), recieved the
       greatest average interest from Oct. 2016 through 2018', 
       x = 'Search Term', 
       y = 'Average Interest') +
  ylim(0, 100)

## Again, notice juice laundry and Juice Laundry averages are equal

## Now you have the two main visuals that Google Trends gives you

# NOTE - gtrends was run at 3 pm on 02-09-2019





       
