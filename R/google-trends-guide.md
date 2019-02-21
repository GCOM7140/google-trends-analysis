The Google Trends R Guide
================
Analyzing *Google* search interest over time with the `gtrendsR` package

-   [Overview](#overview)
    -   [Understanding *Google Trends*](#understanding-google-trends)
    -   [Data Cleaning](#data-cleaning)
    -   [Case Insensitive Check](#case-insensitive-check)
    -   [TJL Search Terms Comparision](#tjl-search-terms-comparision)
    -   [Sampling](#sampling)
    -   [`thejuicelaundry` dataset](#thejuicelaundry-dataset)
    -   [Corner Juice Search Terms Comparision](#corner-juice-search-terms-comparision)
    -   [Corner Juice vs. TJL](#corner-juice-vs.-tjl)

Overview
--------

First and foremost, you must understand what *Google Trends* is, how it retrieves data, what that data means, and what you can gain from it.

Then you can start to use it. First, you will use Google Trends through the User Interface (UI) found [here](https://trends.google.com/trends/?geo=US) and by the end of this guide, you will be using it through the `gtrendsR` package.

### Understanding *Google Trends*

*Google Trends* data is an unbiased sample of Google search data:

-   Only a percentage of searches are used to compile Trends data.

-   Samples are refreshed every day and so data from one day with differ slightly from data (with the same parameters) from another

Search results are proportionate to the time and location of a search term/topic (known as a query) by the following process:

-   Each data point is divided by the total searches of the geography and time range it represents to compare relative popularity. Otherwise, places with the most search volume would always be ranked highest.

-   The resulting numbers are then scaled on a range of 0 to 100 based on a topic’s proportion to all searches on all topics.

-   Different regions that show the same search interest for a term don't always have the same total search volumes.

Data that is excluded:

-   Searches made by very few people: Trends only shows data for popular terms, so search terms with low volume appear as "0"

-   Duplicate searches: Trends eliminates repeated searches from the same person over a short period of time

-   Special characters: Trends filters out queries with apostrophes and other special characters

### Data Cleaning

### Case Insensitive Check

### TJL Search Terms Comparision

### Sampling

### `thejuicelaundry` dataset

### Corner Juice Search Terms Comparision

### Corner Juice vs. TJL
