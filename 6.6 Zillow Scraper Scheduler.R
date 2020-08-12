
library(taskscheduleR)

myscript <- "C:/Users/rjeut/Documents/Code/R Hacks/6.5 Zillow Scraper Script.R"

## run script once within 62 seconds
taskscheduler_create(taskname = "zillowScraper", rscript = myscript, 
                     schedule = "WEEKLY",
                     startdate = format(Sys.Date(), "%d/%m/%Y"),#"08/04/2020",
                     starttime = format(Sys.time() + 63, "%H:%M"),#"10:43",
                     days = c('TUE'))

#taskscheduler_delete(taskname = "zillowScraper")
