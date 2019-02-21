The Google Trends R Guide
================
A manual for *intelligent*, *reproducible*, and *programmatic* analysis of *Google Trends* search interest over time with the `gtrendsR` package

-   [Overview](#overview)
-   [Understanding *Google Trends*](#understanding-google-trends)
-   [Navigating the User Interface (UI)](#navigating-the-user-interface-ui)
-   [TJL Search Terms Comparision](#tjl-search-terms-comparision)
-   [Sampling](#sampling)
-   [`thejuicelaundry` dataset](#thejuicelaundry-dataset)
-   [Corner Juice Search Terms Comparision](#corner-juice-search-terms-comparision)
-   [Corner Juice vs. TJL](#corner-juice-vs.-tjl)

### Overview

First and foremost, you must understand what *Google Trends* is, how it retrieves data, what that data means, and what you can gain from it.

Then you can start to use it, first through the User Interface (UI) found [here](https://trends.google.com/trends/?geo=US) and later through the `gtrendsR` package.

The benefits of using an R package are numerous and will become more and more apparent throughout this guide. To summarize, an R package allows your analysis to be more *intelligent*, *reproducible*, and *programmatic*.

We will walk you through using Google Trends, pointing you some nuances along the way, and then we will show you how to generate the same exact data (and even the same visuals) with the `gtrendsR` package. We will apply everything to *The Juice Laundry*, demonstrating methods to extract data that is most useful and most accurate, and comparing that data to local competition, namely *Corner Juice*.

### Understanding *Google Trends*

According to the *Google Trends Help* page...

*Google Trends* data is an unbiased sample of Google search data:

-   Only a percentage of searches are used to compile Trends data.

-   Samples are refreshed every day and so data from one day with differ slightly from data (with the same parameters) from another.

Search results are proportionate to the time and location of a search (commonly referred to as a query) by the following process:

-   Each data point is divided by the total searches of the geography and time range it represents to compare relative popularity. Otherwise, places with the most search volume would always be ranked highest.

-   The resulting numbers are then scaled on a range of 0 to 100 based on a topic’s proportion to all searches on all topics.

-   Different regions that show the same search interest for a term don't always have the same total search volumes.

Some data is excluded:

-   Searches made by very few people: Trends only shows data for popular terms, so search terms with low volume appear as "0"

-   Duplicate searches: Trends eliminates repeated searches from the same person over a short period of time

-   Special characters: Trends filters out queries with apostrophes and other special characters

The uses for *Google Trends* are plentiful. As [bruceclay.com](https://www.bruceclay.com/newsletter/volume120/why-use-google-trends.htm) highlights...

-   Google Trends offers a multidimensional view of queries and how they have evolved as a result of factors like seasonality, geographic location, and media coverage.

-   Data provided as relative popularity over time – not total search volume – can provide an apples to apples idea of query popularity

-   Graphed media coverage incidents help marketers see direct correlations between media coverage and spikes in interest.

From my experience, *Google Trends* is most practical for *benchmarking against competitors* and *understanding emerging trends* for a business or an industry.

### Navigating the User Interface (UI)

If you do not already have it open, go to [Google Trends](https://trends.google.com/trends/?geo=US)

### TJL Search Terms Comparision

### Sampling

### `thejuicelaundry` dataset

### Corner Juice Search Terms Comparision

### Corner Juice vs. TJL
