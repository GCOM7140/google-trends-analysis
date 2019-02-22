The Google Trends R Guide
================
A manual for *intelligent*, *reproducible*, and *programmatic* analysis of *Google Trends* search interest over time with the `gtrendsR` package

-   [Overview](#overview)
-   [Understanding *Google Trends*](#understanding-google-trends)
-   [Navigating the User Interface (UI)](#navigating-the-user-interface-ui)
-   [Testing the `gtrendsR` package](#testing-the-gtrendsr-package)
-   [Replicating the *Google Trends* visuals](#replicating-the-google-trends-visuals)
-   [`thejuicelaundry` dataset](#thejuicelaundry-dataset)
-   [Corner Juice Search Terms Comparision](#corner-juice-search-terms-comparision)
-   [Corner Juice vs. TJL](#corner-juice-vs.-tjl)

------------------------------------------------------------------------

### Overview

First and foremost, you must understand what *Google Trends* is, how it retrieves data, what that data means, and what you can gain from it.

Then you can start to use it, first through the User Interface (UI) found <a href="https://trends.google.com/trends/?geo=US" target="blank">here</a> and later through the `gtrendsR` package.

The benefits of using an R package are numerous and will become more and more apparent throughout this guide. To summarize, an R package allows your analysis to be more *intelligent*, *reproducible*, and *programmatic*.

We will walk you through using Google Trends, pointing out some nuances along the way, and then we will show you how to generate the same exact data (and even the same visuals) with the `gtrendsR` package. We will apply everything to *The Juice Laundry* (TJL), demonstrating methods to extract data that is most useful and most accurate, and comparing that data to local competition, namely *Corner Juice*.

------------------------------------------------------------------------

### Understanding *Google Trends*

According to the *Google Trends Help* page...

*Google Trends* data is an unbiased sample of Google search data:

-   Only a percentage of searches are used to compile Trends data.

-   Samples are refreshed every day and so data from one day with differ slightly from data (with the same parameters) from another.

Search results are proportionate to the time and location of a search (commonly referred to as a query) by the following process:

-   Each data point is divided by the total searches of the geography and time range it represents to compare relative popularity. Otherwise, places with the most search volume would always be ranked highest.

-   The resulting numbers (what I will refer to as `relative_interest`) are then scaled on a range of 0 to 100 based on a topic’s proportion to all searches on all topics.

-   Different regions that show the same search interest for a term don't always have the same total search volumes.

Some data is excluded:

-   Searches made by very few people: Trends only shows data for popular terms, so search terms with low volume appear as "0."

-   Duplicate searches: Trends eliminates repeated searches from the same person over a short period of time.

-   Special characters: Trends filters out queries with apostrophes and other special characters.

The uses for *Google Trends* are plentiful. As <a href="https://www.bruceclay.com/newsletter/volume120/why-use-google-trends.htm" target="blank">bruceclay.com</a> highlights...

-   Google Trends offers a multidimensional view of queries and how they have evolved as a result of factors like seasonality, geographic location, and media coverage.

-   Data provided as relative popularity over time – not total search volume – can provide an apples to apples idea of query popularity.

-   Graphed media coverage incidents help marketers see direct correlations between media coverage and spikes in interest.

Along the lines of what this guide will show you, *Google Trends* is most practical for *benchmarking against competitors* and *understanding emerging trends* for a business or an industry.

------------------------------------------------------------------------

### Navigating the User Interface (UI)

If you do not already have it open, go to <a href="https://trends.google.com/trends/?geo=US" target="blank">Google Trends</a>. Enter 'the juice laundry' as your search term. Then change 'Past 12 Months' to a custom time range from October 9, 2016 (10-9-2016) to the end of 2018 (12-31-2018). These dates coincide with the time period of the `thejuicelaundry` package's *Square* transaction data. Notice that you can also change the location, category, and search type (web, image, etc.) parameters, but leave them alone. Enter 'The Juice Laundry' (capitalized this time) as a second search term. Both terms should say 'search term' under them.

You will notice that only the red line shows. This is because the **search terms are case insensitive** and the trendlines are identical. Now, replace the second search term with "the juice laundry" (in quotes this time).

You will notice that the trendlines are different and that is because sourrounding the term in quotes creates a totally different query based on *Google's* algorithm. Navigate <a href="https://support.google.com/trends/answer/4359582?hl=en" target="blank">here</a> to see the results of queries that are different but that share similar terms. The takeaway is that **the algorithm is stricter on quoted terms** (because it only counts searches with that exact phrase) and the trendlines should reflect this ("the juice laundry" being generally lower then its non-quoted counterpart).

Add 'juice laundry' and the quoted "juice laundry", in that order, as two more search terms.

The resulting trendlines will be unique, displaying generally greater search interest than search terms with "the" (an additional restriction) in them -- which makes sense. Take note of how the interest over time for existing trendlines (the blue and red in this case) shrink as you added the new search terms. Remember that this is because **search interest for one term is relative to the search interest for another**.

Finally, add *The Juice Laundry* as another search term, but this time choose the option that states "Juice Shop in Charlottesville, VA" underneath it.

You have added what is known as a *topic*. According to Google, **a topic is a group of terms that share a concept**. For example, if you search the topic "London," your search includes results for topics such as "Capital of the UK" and "Londres" which is "London" in Spanish. For all we know, Google's algorithm may be grouping search terms like those we have (more or less) to form the topic of *The Juice Laundry*, but we cannot know for sure what it is doing.

Your screen should look very similar to the photo below. Because samples are different every day, however, the trendlines will not look exactly the same.

![](https://github.com/GCOM7140/google-trends-analysis/blob/master/output/tjl-gtrends-ui.png)

Scroll your mouse over the trendlines and witness how **relative search interest is aggregated for week intervals**. Look for the peak popularity of the trends and note the specific week they occurred. Do a quick google search for news around that time -- did TJL open a new location or have a story written on them? Is there an obvious reason that relative search interest for them was highest then?

Download the displayed data as a csv file and open it with Excel or Numbers (using the download button on the top right of the line graph).

You will notice that each term has its own column. However, the search terms are values, not variables, and so the dataset as you see it is **not tidy**. To quote <a href = "https://r4ds.had.co.nz/tidy-data.html#tidy-data-1" target = "blank">R4DS</a>, there are three interrelated rules which make a dataset tidy:

-   Each variable must have its own column.
-   Each observation must have its own row.
-   Each value must have its own cell.

That said, the variable should be "search term", and each term (one for each observation) should fall under that column.

Now that you are familiar with the UI and all of the nuances with search terms and topics, you are ready to repeat the process and expand on that process within R.

------------------------------------------------------------------------

### Testing the `gtrendsR` package

Our first objective is to ensure that data pulled from gtrendsR is tidy and matches the data obtained directly from the UI (on the same day of course).

Open RStudio and install/load the required packages.

``` r
devtools::install_github("PMassicotte/gtrendsR")
library(gtrendsR)
library(tidyverse)
```

Assign the time period and search terms we used in the UI. The topic (represented in the URL as a code) must be decoded.

``` r
time_span <- "2016-10-09 2018-12-31"
topic_url <- "q=%2Fg%2F12m9gwg0k"
search_terms <- c("the juice laundry", 
                  '"the juice laundry"', 
                  "juice laundry",
                  '"juice laundry"', 
                  gsub("q=", "", URLdecode(topic_url)))
```

Run gtrendsR and I recommend saving the interest\_over\_time dataframe (the only one we are concerned with) as a csv file with today's date.

``` r
gtrends_list <- gtrends(search_terms, geo = "US", time = time_span)

write_csv(gtrends_list[["interest_over_time"]], 
          paste0(Sys.Date(), "-google-trends-gtrendsr.csv"))
```

Notice how `gtrendsR` data is tidy without any extra work on our part. Change the column names and types so that they make more sense and rename the topic code.

``` r
gtrends <- gtrends_list[["interest_over_time"]] %>% 
  as_tibble() %>% 
  rename('relative_interest' = 'hits', 
         'week_of' = 'date', 
         'search_term' = 'keyword') %>% 
  select(c('week_of', 'search_term', 'relative_interest'))

gtrends$week_of <- as.Date(gtrends$week_of) # Rather than datetime default
gtrends$relative_interest <- as.double(gtrends$relative_interest) # Not Int
gtrends[gtrends$search_term == gsub("q=", "", 
                                    URLdecode(topic_url)), 
        "search_term"] <- "TJL Topic"

View(gtrends)
```

Read in the csv you downloaded from the UI. Swap my local path with your local path.

``` r
csv <- "/Users/malcolm_mashig/Downloads/multiTimeline-37.csv"
raw_google_trends <- read_csv(csv, skip = 2)

View(raw_google_trends)
```

The data from the UI is not tidy. Tidy it. Reading in from the UI, as you can see, becomes tedious.

``` r
google_trends <- raw_google_trends %>% 
  as_tibble() %>% 
  gather('the juice laundry: (United States)', 
         '"the juice laundry": (United States)',
         'juice laundry: (United States)',
         '"juice laundry": (United States)',
         'The Juice Laundry: (United States)', 
         key = "search_term", 
         value = "relative_interest") %>% 
  rename('week_of' = Week)

google_trends[google_trends$search_term == "the juice laundry: (United States)", "search_term"] <- "the juice laundry"

google_trends[google_trends$search_term == '"the juice laundry": (United States)', "search_term"] <- '"the juice laundry"'

google_trends[google_trends$search_term == 'juice laundry: (United States)', "search_term"] <- "juice laundry"

google_trends[google_trends$search_term == '"juice laundry": (United States)', "search_term"] <- '"juice laundry"'

google_trends[google_trends$search_term == 'The Juice Laundry: (United States)', "search_term"] <- "TJL Topic"

View(google_trends)
```

They two datasets may appear identical but we must make sure they are.

``` r
setequal(google_trends, gtrends)
```

    ## [1] TRUE

**NOTE:** If you do not get TRUE, download a new csv from the UI and rerun everything with the new file.

------------------------------------------------------------------------

### Replicating the *Google Trends* visuals

### `thejuicelaundry` dataset

### Corner Juice Search Terms Comparision

### Corner Juice vs. TJL
