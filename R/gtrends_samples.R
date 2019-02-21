# Must download development version

remove.packages('gtrendsR')
devtools::install_github("PMassicotte/gtrendsR")
library(gtrendsR)
library(tidyverse)

# Decode q parameter in URL (before comma)

URLdecode("q=%2Fg%2F12m9gwg0k")

# insert decoded search term key as topic

search_terms <- c("/g/12m9gwg0k", "The Juice Laundry", '"The Juice Laundry"',
                  "Juice Laundry", '"Juice Laundry"')

cj_terms <- c("Corner Juice", '"Corner Juice"')

gtrends_list <- gtrends(keyword = search_terms, 
                        geo = "US", time = "2016-10-08 2018-12-31")

write_csv(gtrends_list[["interest_over_time"]], "2019-02-21-tjl-sample.csv")

x <- read_csv("2019-02-20-tjl-sample.csv") %>% 
  as_tibble()

# rename /g/12m9gwg0k value to TJL Topic

x[x$keyword == "/g/12m9gwg0k", "keyword"] <- "TJL Topic"

ggplot(x, aes(date, hits, color = keyword)) + geom_line()

gtrends_cj_list <- gtrends(keyword = cj_terms,
                           geo = "US", time = "2016-10-08 2018-12-31")

write_csv(gtrends_cj_list[["interest_over_time"]], 
          "2019-02-21-gtrendsR-cj-sample.csv")
  

