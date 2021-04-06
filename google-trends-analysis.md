Google Trends Analysis with R
================

## Goals and objectives

Today, we are going to cover how you can generate insights from Google
Trends in R. This tutorial includes all of the information you need to
start using Google Trends, initially, through the [Google Trends
homepage](https://trends.google.com/trends/) and, subsequently, with the
[{trendyy} package](https://github.com/JosiahParry/trendyy#-trendyy-).

In particular, we are going to go through a step-by-step process that
you can follow to generate the same data (and even the same
visualizations) that the Google Trends homepage produces. The tool that
makes this possible is {trendyy}, an R package that provides a
tidyverse-friendly interface for retrieving and displaying Google Trends
information.

The benefits of using the {trendyy} package instead of the Google Trends
homepage to explore what the world is searching for are numerous, and I
hope these benefits will become more and more apparent to you as we
proceed. We will conclude our time together by discussing the benefits
that you think of, so please be sure to write them down as ideas come to
you.

Without further ado, let’s get started using the Google Trends homepage.

## Using the Google Trends homepage

Please navigate to www.google.com/trends, type “juice laundry” (with
quotes) into the search bar, and hit enter.

-   This search will automatically take you to a line chart with time
    (specifically, weekly data covering the past twelve months) on the x
    axis, search interest on the y axis, the United States as the
    region, and web search as the domain.

With this search as your starting point, please have a look around
Google Trends and test things out to learn how you can change the
parameters of this search to access search patterns for any search term
or topic that you are interested in. The parameters you can change
include keywords, locations, time periods, categories, and domains.

Here are some specific questions for you and two-three classmates to
consider:

1.  What does the variable on the y axis mean?
    -   Hint: Click on the question mark next to “Interest over time”
        and read the [Trends Help
        page](https://support.google.com/trends/answer/4365533?hl=en&ref_topic=6248052)
        to gain an accurate understanding of how this variable is
        calculated. The answer to this question also lies in [this
        Medium
        article](https://medium.com/google-news-lab/what-is-google-trends-data-and-what-does-it-mean-b48f07342ee8).
2.  Do the numbers in your chart line up with the numbers in another
    classmate’s charts? Compare a few values with one another. If they
    do not line up, discuss why that is the case.
    -   Hint: Take a second look at the [Trends Help
        page](https://support.google.com/trends/answer/4365533?hl=en&ref_topic=6248052)
        if you didn’t catch the answer to this question the first time
        you read it.
3.  What is the difference between search terms, quoted search terms,
    and topics? Compare a few different search terms, quoted search
    terms, and topics a try to see how they differ (e.g., see
    [here](https://trends.google.com/trends/explore?date=now%207-d&geo=US&q=%22juice%20laundry%22,juice%20laundry,%2Fg%2F12m9gwg0k)).
    -   Hint: Find answers
        [here](https://support.google.com/trends/answer/4359582?hl=en)
        and [here](https://support.google.com/trends/answer/4359550).
4.  How granularly can you set the location parameter? Down to the
    country, state, or city level?
5.  How far in the past and how close to the present can you specify the
    time period parameter? Play around with this parameter to see how
    the data being plotted differs based on the length of the time
    period you specify. Do you always get weekly data in return?
6.  Beyond web search, what domains can you query with Google Trends?

## Using the {trendyy} package

The {trendyy} package facilitates a *programmatic* approach to
processing Google Trends information, as opposed to an *ad hoc,
point-and-click* approach. As such, it can help you develop analyses
that are [reproducible, accurate, and
collaborative](https://peerj.com/preprints/3210/#).

Here is a code skeleton that you can use for any Google Trends query
that you want to process with the `trendyy::trendy()` function:

``` r
trendy(
   search_terms = "",
   from         = "",
   to           = "",
   geo          = ""
) ->
   google_trends
```

If you ever need to install the {trendyy} package from GitHub, you can
with:

``` r
remotes::install_github("josiahparry/trendyy", force = TRUE)
```

Here are the library calls that are needed to go through the steps that
follow:

``` r
library(tidyverse)
library(lubridate)
library(trendyy)
library(juicelaundry)
```

Skip ahead to the graph at the bottom of this page to see the light at
the end of the tunnel. It’s a graph that compares search interest for
the University of Virginia’s Google Trends topic in Virginia to gross
sales at The Juice Laundry’s location on the Corner. As you might
expect, the correlation between these two trendlines is positive and
significant (in the neighborhood of .38).

### Step 1

Use the `trendyy::trendy()` function to query Google Trends for search
interest related to the University of Virginia in 2019 in Virginia,
using the `search_terms`, `from`, `to`, and `geo` arguments,
accordingly.

Note that:  
\* The search term or topic you specify for the `search_terms` argument
can be unquoted, quoted or pulled from a Google Trends URL and nested
within the `URLdecode()` function.  
\* The dates you feed into the `from` and `to` arguments need to be in
the form `"YYYY-MM-DD"`  
\* The value you specify for the `geo` argument must adhere to the [ISO
3166](https://en.wikipedia.org/wiki/ISO_3166) standard (find the code
for Virginia [here](https://en.wikipedia.org/wiki/ISO_3166-2:US))

Assigning the result of your query to an object named something like
`google_trends` will allow you to store the data you pull for later use.

Once you have specified the correct parameters in the code skeleton
above and have run the code, typing `google_trends` into the console and
hitting enter should print the following summary:

    ## ~Trendy results~
    ## 
    ## Search Terms: /m/0g8rj
    ## 
    ## (>^.^)> ~~~~~~~~~~~~~~~~~~~~ summary ~~~~~~~~~~~~~~~~~~~~ <(^.^<)
    ## # A tibble: 1 x 5
    ##   keyword  max_hits min_hits from       to        
    ##   <chr>       <int>    <int> <date>     <date>    
    ## 1 /m/0g8rj      100       14 2017-06-25 2021-02-28

Note that your value for `min_hits` might differ from the value printed
above, because only a sample of Google searches are used for Google
Trends outputs and your sample likely varies from the one I pulled when
I compiled this R Markdown document.

### Step 2

Pipe the trendy object that you created in Step 1 (i.e.,
`google_trends`) into the `get_interest()` accessor function to retrieve
data related to search interest over time and name this tibble
`search_interest`:

``` r
google_trends %>% 
   get_interest() -> 
   search_interest
```

    ## # A tibble: 193 x 7
    ##    date                 hits keyword  geo   time              gprop category    
    ##    <dttm>              <int> <chr>    <chr> <chr>             <chr> <chr>       
    ##  1 2017-06-25 00:00:00    18 /m/0g8rj US-VA 2017-06-22 2021-… web   All categor…
    ##  2 2017-07-02 00:00:00    19 /m/0g8rj US-VA 2017-06-22 2021-… web   All categor…
    ##  3 2017-07-09 00:00:00    22 /m/0g8rj US-VA 2017-06-22 2021-… web   All categor…
    ##  4 2017-07-16 00:00:00    24 /m/0g8rj US-VA 2017-06-22 2021-… web   All categor…
    ##  5 2017-07-23 00:00:00    18 /m/0g8rj US-VA 2017-06-22 2021-… web   All categor…
    ##  6 2017-07-30 00:00:00    25 /m/0g8rj US-VA 2017-06-22 2021-… web   All categor…
    ##  7 2017-08-06 00:00:00    29 /m/0g8rj US-VA 2017-06-22 2021-… web   All categor…
    ##  8 2017-08-13 00:00:00    35 /m/0g8rj US-VA 2017-06-22 2021-… web   All categor…
    ##  9 2017-08-20 00:00:00    51 /m/0g8rj US-VA 2017-06-22 2021-… web   All categor…
    ## 10 2017-08-27 00:00:00    52 /m/0g8rj US-VA 2017-06-22 2021-… web   All categor…
    ## # … with 183 more rows

Again, do not be alarmed if your values for the `hits` variable differ
from the values printed above. The reason being is that only a sample of
Google searches are used in Google Trends outputs and your sample likely
varies from the one I pulled when I compiled this R Markdown document.

### Step 3

Wrangle the `search_interest` data you now have in your R environment in
the following way:

1.  Use the `mutate()` function to create a new variable named `week`
    that takes on the same values as the `date` variable, except in
    `<date>` form rather than `<dttm>` form.
2.  Use the `select()` function to not only select the `week` and `hits`
    variables, but also rename the `hits` variable
    `interest_normalized`.

``` r
search_interest %>% 
   mutate(week = as_date(date)) %>% 
   select(week, interest_normalized = hits) ->
   search_interest
```

After you run the code above, typing `search_interest` into the console
and hitting enter should print the following:

    ## # A tibble: 193 x 2
    ##    week       interest_normalized
    ##    <date>                   <int>
    ##  1 2017-06-25                  18
    ##  2 2017-07-02                  19
    ##  3 2017-07-09                  22
    ##  4 2017-07-16                  24
    ##  5 2017-07-23                  18
    ##  6 2017-07-30                  25
    ##  7 2017-08-06                  29
    ##  8 2017-08-13                  35
    ##  9 2017-08-20                  51
    ## 10 2017-08-27                  52
    ## # … with 183 more rows

### Step 4

Bring the `location_name` variable from the `location` dataset into the
`transaction` dataset using the `left_join()` function and then filter
the data for transactions that occurred at The Juice Laundry’s location
on the Corner. Name the tibble that stems from these operations
`transaction_corner`.

``` r
transaction %>% 
   left_join(location %>% select(location_id, location_name)) %>%
   filter(location_name == "The Corner (C'ville)") ->
   transaction_corner
```

After you run the code above, typing `transaction_corner` into the
console and hitting enter should print the following:

    ## # A tibble: 110,232 x 15
    ##    ordered_at          price_charged tax_collected tip_received fee_paid
    ##    <dttm>                      <dbl>         <dbl>        <dbl>    <dbl>
    ##  1 2017-06-22 09:06:10             8          0.74            0     0.22
    ##  2 2017-06-22 09:06:48             8          0.74            0     0.22
    ##  3 2017-06-22 09:09:46             8          0.74            0     0.22
    ##  4 2017-06-22 09:14:09             8          0.74            0     0.22
    ##  5 2017-06-22 09:20:10            22          2.06            0     0.59
    ##  6 2017-06-22 09:21:53             9          0.84            0     0.24
    ##  7 2017-06-22 09:43:40             8          0.74            0     0.22
    ##  8 2017-06-22 09:50:06            11          1.03            0     0.3 
    ##  9 2017-06-22 09:51:20             8          0.74            0     0.22
    ## 10 2017-06-22 09:57:13             9          0.84            0     0.24
    ## # … with 110,222 more rows, and 10 more variables: discount_given <dbl>,
    ## #   discount_name <chr>, transaction_source <chr>, payment_method <chr>,
    ## #   card_brand <chr>, refund_reason <chr>, customer_id <chr>,
    ## #   location_id <chr>, transaction_id <chr>, location_name <chr>

### Step 5

Create a week-level dataset that you can join with `search_interest`,
and have the key variable of interest in the week-level dataset that you
create be weekly gross sales (normalized, with a possible range from 0
to 100).

``` r
transaction_corner %>% 
   mutate(
      week        = floor_date(ordered_at, unit = "week") %>% as_date(),
      gross_sales = price_charged + discount_given - tip_received
   ) %>%
   group_by(week) %>% 
   summarize(gross_sales = sum(gross_sales)) %>% 
   mutate(gross_sales_normalized = (gross_sales / max(gross_sales)) * 100) %>% 
   select(-gross_sales) ->
   gross_sales_corner
```

Before you run the code above, go through it function-by-function to see
what is happening “under the hood.” Be sure to ask for clarification
if/when things do not make sense.

After you run the code above, typing `gross_sales_corner` into the
console and hitting enter should print the following:

    ## # A tibble: 182 x 2
    ##    week       gross_sales_normalized
    ##    <date>                      <dbl>
    ##  1 2017-06-18                   19.1
    ##  2 2017-06-25                   53.9
    ##  3 2017-07-02                   62.5
    ##  4 2017-07-09                   68.0
    ##  5 2017-07-16                   59.3
    ##  6 2017-07-23                   48.5
    ##  7 2017-07-30                   53.2
    ##  8 2017-08-06                   34.9
    ##  9 2017-08-13                   60.2
    ## 10 2017-08-20                   92.3
    ## # … with 172 more rows

### Step 6

Join the `search_interest` dataset with the `gross_sales_corner`
dataset:

``` r
search_interest %>%    
   left_join(gross_sales_corner) ->
   search_and_gross_sales
```

After you run the code above, typing `search_and_gross_sales` into the
console and hitting enter should print the following:

    ## # A tibble: 193 x 3
    ##    week       interest_normalized gross_sales_normalized
    ##    <date>                   <int>                  <dbl>
    ##  1 2017-06-25                  18                   53.9
    ##  2 2017-07-02                  19                   62.5
    ##  3 2017-07-09                  22                   68.0
    ##  4 2017-07-16                  24                   59.3
    ##  5 2017-07-23                  18                   48.5
    ##  6 2017-07-30                  25                   53.2
    ##  7 2017-08-06                  29                   34.9
    ##  8 2017-08-13                  35                   60.2
    ##  9 2017-08-20                  51                   92.3
    ## 10 2017-08-27                  52                   63.2
    ## # … with 183 more rows

### Step 7

Tidy up the data and plot the trendlines of normalized search interest
and gross sales over time.

``` r
search_and_gross_sales %>% 
   pivot_longer(
      cols = c("interest_normalized", "gross_sales_normalized"),
      names_to  = "metric",
      values_to = "performance"
   ) %>% 
   mutate(
      metric = ifelse(
                  metric == "interest_normalized", 
                  "Search interest (normalized)", 
                  "Gross sales (normalized)"
               ) %>% 
               factor(levels = c("Search interest (normalized)", 
                                 "Gross sales (normalized)"))
   ) %>% 
   ggplot(aes(week, performance, color = metric)) +
   geom_line(size = 1.1) +
   theme_minimal() +
   theme(legend.position = "bottom") +
   labs(
      x = "Time",
      y = "Normalized score",
      color = "Metric"
   )
```

<img src="google-trends-analysis_files/figure-gfm/unnamed-chunk-16-1.png" width="95%" height="80%" style="display: block; margin: auto;" />

Because Google Trends data come from samples, the data you can access
over time will differ slightly. This feature of the data generation
process makes it necessary to save the data you use for analyses if you
want technical artifacts (e.g., visualizations) stemming from your work
to be reproducible ([Peng
2011](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3383002/)). You can
leverage the `readr::write_csv()` and `ggplot2::ggsave()` functions to
save the data and visualizations that you create for future use.

## Your turn

Create a visualization like the one above for (a) normalized search
interest related to a search term or topic of your choice and (b)
normalized gross sales at one of The Juice Laundry’s locations (e.g., on
the Corner or in the AFC).

In addition, use the following code to determine the correlation between
search interest for the search term or topic you choose and gross sales
at the store location you choose.

``` r
search_and_gross_sales %>% 
   select(-week) %>% 
   cor()
```

    ##                        interest_normalized gross_sales_normalized
    ## interest_normalized                      1                     NA
    ## gross_sales_normalized                  NA                      1

## Wrap-up discussion

What are the benefits of using the {trendyy} package instead of the
Google Trends homepage to explore what the world is searching for? </br>
</br> </br> </br> </br> </br> </br> </br> </br> </br>
