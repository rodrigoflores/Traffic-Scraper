# Traffic Scraper #

![Build Status](https://secure.travis-ci.org/rodrigoflores/Traffic-Scraper.png)

A gem to retrieve Sao Paulo traffic information from CET-SP website. It retrieves the HTML and parsed it to get the information.

## How to use ##

Only two methods are available right now:

    Traffic::Scrapper.overall_traffic #=> Returns the amount of overall traffic (in km) that we currently have
    Traffic::Scrapper.zone_traffic    #=> Returns a Hash with the amount of traffic in each zone (in km) that we currently have.
